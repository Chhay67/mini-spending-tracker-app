import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/core/enum/filter_type_enum.dart';
import 'package:mini_spend_tracker_app/core/widget/custom_text_form_field.dart';
import 'package:mini_spend_tracker_app/core/widget/pagination/pagination_list_view.dart';
import 'package:mini_spend_tracker_app/init_dependencies.dart';
import 'package:mini_spend_tracker_app/page/widget/categories_dropdown_button2.dart';
import 'package:mini_spend_tracker_app/page/widget/transactions_shimmer.dart';
import 'package:mini_spend_tracker_app/route/app_navigation.dart';

import '../bloc/delete_transaction_cubit/delete_transaction_cubit.dart';
import '../bloc/settings/categories_bloc/categories_bloc.dart';
import '../bloc/transactions_bloc/transactions_bloc.dart';
import '../core/constants/constants.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_snack_bar.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/currency_format.dart';
import '../core/utils/date_format.dart';
import '../core/utils/date_picker.dart';
import '../core/utils/responsive_utils.dart';
import '../core/widget/custom_dropdown_button2.dart';
import '../core/widget/custom_progress_indicator.dart';
import '../core/widget/error_state_widget.dart';
import '../core/widget/pagination/scroll_notification_handler.dart';
import '../model/transaction_model.dart';
import '../route/routes.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  Timer? _debounce;
  String? _searchQuery;
  String? _selectedCategoryId;
  DateTime _selectedDate = DateTime.now();
  FilterTypeEnum _selectedFilter = FilterTypeEnum.month;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void onLoadTransactions(BuildContext context) {
    context.read<TransactionsBloc>().add(
      LoadTransactionsEvent(date: _selectedDate, search: _searchQuery, categoryId: _selectedCategoryId, filterType: _selectedFilter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionsBloc>(
          create: (context) => serviceLocator<TransactionsBloc>()..add(LoadTransactionsEvent(date: _selectedDate,)),
        ),
        BlocProvider<CategoriesBloc>(create: (context) => serviceLocator<CategoriesBloc>()..add(LoadCategoriesEvent())),
      ],
      child: BlocSelector<TransactionsBloc, TransactionsState, bool>(
        selector: (state) {
          if (state is TransactionsLoaded) {
            return state.pagination.hasNext;
          }
          return false;
        },
        builder: (context, isHasMore) {
          return ScrollNotificationHandler(
            loadMore: () {
              context.read<TransactionsBloc>().add(
                LoadMoreTransactionsEvent(
                  date: _selectedDate,
                  search: _searchQuery,
                  categoryId: _selectedCategoryId,
                  filterType: _selectedFilter,
                ),
              );
            },
            isHasMore: isHasMore,
            child: SingleChildScrollView(
              padding: AppPadding.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppSpacing.defaultSpacing,
                children: [
                  Text(
                    "History",
                    textAlign: TextAlign.start,
                    style: textTheme.displayLarge?.copyWith(color: AppColors.textPrimary),
                  ),
                BlocBuilder<TransactionsBloc, TransactionsState>(builder: (context, state) {
                  if (state is TransactionsLoading) {
                    return const TransactionsShimmer();
                  }
                  if (state is TransactionsError) {
                    return ErrorStateWidget(message: state.message, onRetry: () => onLoadTransactions(context));
                  }
                  if (state is TransactionsLoaded) {
                    final transactions = state.transactions;
                    final hasMoreData = state.pagination.hasNext;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
                      child: Column(
                        spacing: AppSpacing.defaultSpacing,
                        children: [
                          CustomTextFormField(
                            prefixIcon: const Icon(Icons.search),
                            hintText: "Search by category or note",
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false) _debounce?.cancel();
                              _debounce = Timer(const Duration(milliseconds: 500), () {
                                _searchQuery = value.trim().isEmpty ? null : value.trim();
                                onLoadTransactions(context);
                              });
                            },
                          ),
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
                            child: SizedBox(
                              height: kDefaultDropDownHeight,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    height: kDefaultDropDownHeight,
                                    child: TextButton(
                                      style: TextButton.styleFrom(backgroundColor: AppColors.surface),
                                      onPressed: () async {
                                        final pickedDate = await DatePicker.showDatePickerDialog(context, initialDate: _selectedDate);
                                        if (pickedDate != null && context.mounted) {
                                          _selectedDate = pickedDate;
                                          onLoadTransactions(context);
                                        }
                                      },
                                      child: Row(
                                        spacing: AppSpacing.defaultSpacing,
                                        children: [
                                          Text(
                                            _selectedFilter == FilterTypeEnum.month
                                                ? DateFormater.formatYearMonth(_selectedDate)
                                                : DateFormater.formatDate(_selectedDate),
                                            style: textTheme.labelSmall,
                                          ),
                                          const Icon(Icons.calendar_month_outlined, color: AppColors.navUnselected)
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.smallSpacing),
                                  CustomDropdownButton2<FilterTypeEnum>(
                                    initValue: _selectedFilter,
                                    items: FilterTypeEnum.values,
                                    labelBuilder: (item) => item?.name ?? "Select filter",
                                    onChanged: (selectedFilter) {
                                      _selectedFilter = selectedFilter;
                                      onLoadTransactions(context);
                                    },
                                  ),
                                  const SizedBox(width: AppSpacing.smallSpacing),
                                  CategoriesFilterDropdownButton2(
                                    initialCategory: _selectedCategoryId,
                                    onChanged: (selectedCategory) {
                                      _selectedCategoryId = selectedCategory.categoryId;
                                      onLoadTransactions(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PaginationListView(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            emptyWidget: SizedBox(
                              height: 100,
                              child: Center(
                                child: Text(
                                  "No transactions added yet",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                                ),
                              ),
                            ),
                            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.defaultSpacing),
                            hasMoreData: hasMoreData,
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return _TransactionItem(transaction: transaction);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem({required this.transaction});

  final TransactionModel transaction;

  String getTitleWithDescription({required String title, String? note}) {
    final StringBuffer buffer = StringBuffer(title);
    if (note != null && note.isNotEmpty) {
      buffer.write("($note)");
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding, vertical: AppPadding.defaultPadding),
      decoration: BoxDecoration(color: theme.colorScheme.surface, borderRadius: BorderRadius.circular(16)),
      child: Row(
        spacing: AppSpacing.defaultSpacing,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTitleWithDescription(title: transaction.categoryName, note: transaction.note),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleMedium,
                ),
                Text(
                  DateFormater.formatDate(transaction.date ?? DateTime.now()),
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(CurrencyFormat.format(transaction.amount), style: textTheme.titleMedium),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      AppNavigation.navigateToRoute(
                        context: context,
                        routePath: Routes.addExpense.path,
                        queryParameters: {
                          "transactionId": transaction.transactionId,
                          "amount": transaction.amount.toString(),
                          "categoryId": transaction.categoryId,
                          if (transaction.date != null) "date": DateFormat('yyyy-MM-dd').format(transaction.date!),
                          "note": transaction.note,
                        },
                      );
                    },
                    icon: const Icon(Icons.edit, size: 18),
                  ),
                  IconButton(
                    onPressed: () => onDeleteTransaction(context: context, transactionId: transaction.transactionId),
                    icon: Icon(Icons.delete, size: 18),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onDeleteTransaction({required BuildContext context, required String transactionId}) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (dialogContext) {
        return BlocProvider(
          create: (providerContext) => serviceLocator<DeleteTransactionCubit>(),
          child: BlocConsumer<DeleteTransactionCubit, DeleteTransactionState>(
            listener: (listenerContext, state) {
              if (state is DeleteTransactionSuccess) {
                context.read<TransactionsBloc>().add(DeleteTransactionEvent(transactionId: transactionId));
                listenerContext.pop();
                AppSnackBar.showSuccess(context, message: "transaction deleted  successfully.");
              }
            },
            builder: (builderContext, state) {
              final isLoading = state is DeleteTransactionLoading;
              final isError = state is DeleteTransactionError;
              return Dialog(
                constraints: BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.defaultPadding),
                  child: Column(
                    spacing: AppPadding.defaultPadding,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Delete Transaction", style: Theme.of(builderContext).textTheme.titleLarge),
                      if (isError) const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                      Text(
                        isError ? state.message : "Are you sure you want to delete, This action cannot be undone.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(
                          builderContext,
                        ).textTheme.bodySmall?.copyWith(color: isError ? AppColors.error : AppColors.textSecondary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: AppSpacing.defaultSpacing,
                        children: [
                          OutlinedButton(
                            onPressed: isLoading ? null : () => Navigator.of(dialogContext).pop(),
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                            onPressed: isLoading
                                ? null
                                : () {
                                    builderContext.read<DeleteTransactionCubit>().deleteTransaction(transactionId: transactionId);
                                  },
                            child: isLoading ? const CustomProgressIndicator() : const Text("Delete"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
