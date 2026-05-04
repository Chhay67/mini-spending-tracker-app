import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/core/constants/constants.dart';
import 'package:mini_spend_tracker_app/core/enum/filter_type_enum.dart';
import 'package:mini_spend_tracker_app/core/utils/date_format.dart';
import 'package:mini_spend_tracker_app/core/widget/custom_dropdown_button2.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';
import 'package:mini_spend_tracker_app/core/widget/error_state_widget.dart';
import 'package:mini_spend_tracker_app/init_dependencies.dart';
import 'package:mini_spend_tracker_app/page/widget/categories_summary_shimmer.dart';
import '../bloc/categories_summary_cubit/categories_summary_cubit.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/currency_format.dart';
import '../core/utils/date_picker.dart';
import '../core/utils/responsive_utils.dart';

class CategorySummaryPage extends StatefulWidget {
  const CategorySummaryPage({super.key});

  @override
  State<CategorySummaryPage> createState() => _CategorySummaryPageState();
}

class _CategorySummaryPageState extends State<CategorySummaryPage> {
  DateTime _selectedDate = DateTime.now();
  FilterTypeEnum _selectedFilter = FilterTypeEnum.month;
  void onLoadCategorySummary(BuildContext context) {
    context.read<CategoriesSummaryCubit>().loadCategoriesSummary(date: _selectedDate, filterType: _selectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesSummaryCubit>(
          create: (context) =>
              serviceLocator<CategoriesSummaryCubit>()..loadCategoriesSummary(date: _selectedDate, filterType: _selectedFilter),
        ),
      ],
      child: SingleChildScrollView(
        padding: AppPadding.all,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: AppSpacing.defaultSpacing,
          children: [
            Text(
              "Category Summary",
              textAlign: TextAlign.start,
              style: textTheme.displayLarge?.copyWith(color: AppColors.textPrimary),
            ),
            BlocBuilder<CategoriesSummaryCubit, CategoriesSummaryState>(
              builder: (context, state) {
                if (state is CategoriesSummaryLoading) {
                  return const CategoriesSummaryShimmer();
                }

                if (state is CategoriesSummaryError) {
                  return ErrorStateWidget(message: state.message, onRetry: () => onLoadCategorySummary(context));
                }

                if (state is CategoriesSummaryLoaded) {
                  final categorySummary = state.data;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: AppSpacing.defaultSpacing,
                    children: [
                      Text(
                        "Total Spending for ${_selectedFilter == FilterTypeEnum.month
                            ? DateFormater.formatYearMonth(_selectedDate)
                            : DateFormater.formatDate(_selectedDate)}",
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
                      ),
                      Text(
                        CurrencyFormat.format(categorySummary.totalSpent),
                        style: textTheme.displayLarge?.copyWith(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.primaryDark),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: AppSpacing.defaultSpacing,
                          children: [
                            Row(
                              spacing: AppSpacing.smallSpacing,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: kDefaultDropDownHeight,
                                  child: TextButton(
                                    style: TextButton.styleFrom(backgroundColor: AppColors.surface),
                                    onPressed: () async {
                                      final pickedDate = await DatePicker.showDatePickerDialog(context, initialDate: _selectedDate);
                                      if (pickedDate != null && context.mounted) {
                                        _selectedDate = pickedDate;
                                        onLoadCategorySummary(context);
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

                                CustomDropdownButton2<FilterTypeEnum>(
                                  initValue: _selectedFilter,
                                  items: FilterTypeEnum.values,
                                  labelBuilder: (item) => item?.name ?? "Select filter",
                                  onChanged: (selectedFilter) {
                                    _selectedFilter = selectedFilter;
                                    context.read<CategoriesSummaryCubit>().loadCategoriesSummary(
                                      date: _selectedDate,
                                      filterType: _selectedFilter,
                                    );
                                  },
                                ),
                              ],
                            ),
                            Text(
                              "Categories",
                              textAlign: TextAlign.start,
                              style: textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
                            ),
                            if (categorySummary.categories.isEmpty)
                              Center(
                                child: Text(
                                  "No categories found.",
                                  style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: categorySummary.categories.length,
                                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.defaultSpacing),
                                itemBuilder: (context, index) {
                                  final category = categorySummary.categories[index];
                                  return DefaultCard(
                                    children: [
                                      Row(
                                        spacing: AppSpacing.smallSpacing,
                                        children: [
                                          CircleAvatar(radius: 4, backgroundColor: AppColors.hexToColor(category.categoryColor)),
                                          Expanded(
                                            child: Text(
                                              category.categoryName,
                                              style: textTheme.titleMedium?.copyWith(color: AppColors.textPrimary),
                                            ),
                                          ),
                                          Text(
                                            CurrencyFormat.format(category.totalSpent),
                                            style: textTheme.labelMedium?.copyWith(color: AppColors.textSecondary, fontSize: 16),
                                          ),
                                        ],
                                      ),
                                      LinearProgressIndicator(
                                        value: category.percent / 100,
                                        color: AppColors.hexToColor(category.categoryColor),
                                        backgroundColor: AppColors.primaryLight,
                                        minHeight: 6,
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
                                      ),
                                    ],
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
