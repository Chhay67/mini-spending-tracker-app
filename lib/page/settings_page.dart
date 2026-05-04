import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/bloc/settings/add_category_cubit/add_category_cubit.dart';
import 'package:mini_spend_tracker_app/bloc/settings/delete_category_cubit/delete_category_cubit.dart';
import 'package:mini_spend_tracker_app/core/utils/currency_format.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';
import 'package:mini_spend_tracker_app/core/widget/custom_text_form_field.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';

import '../bloc/selected_month_cubit/selected_month_cubit.dart';
import '../bloc/settings/categories_bloc/categories_bloc.dart';
import '../bloc/settings/monthly_budget_cubit/monthly_budget_cubit.dart';
import '../core/state/action_state.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_snack_bar.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/app_validator.dart';
import '../core/utils/date_format.dart';
import '../core/utils/date_picker.dart';
import '../core/utils/responsive_utils.dart';
import '../core/widget/custom_progress_indicator.dart';
import '../core/widget/error_state_widget.dart';
import '../init_dependencies.dart';
import '../model/category_model.dart';
import 'widget/categories_shimmer.dart';
import 'widget/monthly_budget_shimmer.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(
      providers: [
        BlocProvider<MonthlyBudgetCubit>(
          create: (context) => serviceLocator<MonthlyBudgetCubit>()..loadMonthlyBudget(month: context.read<SelectedMonthCubit>().state),
        ),
        BlocProvider<CategoriesBloc>(create: (_) => serviceLocator<CategoriesBloc>()..add(const LoadCategoriesEvent())),
        BlocProvider<AddCategoryCubit>(create: (_) => serviceLocator<AddCategoryCubit>()),
      ],

      child: MultiBlocListener(
        listeners: [
          BlocListener<SelectedMonthCubit, DateTime>(
            listener: (context, selectedMonth) => context.read<MonthlyBudgetCubit>().loadMonthlyBudget(month: selectedMonth),
          ),
          BlocListener<AddCategoryCubit, AddCategoryState>(
            listener: (context, state) {
              if (state is AddCategorySuccess) {
                AppSnackBar.showSuccess(context, message: "${state.categoryToAdd.categoryName} added successfully");
                context.read<CategoriesBloc>().add(AddCategoryEvent(category: state.categoryToAdd));
                return;
              }
              if (state is AddCategoryError) {
                AppSnackBar.showError(context, message: "Failed to add category: ${state.message}");
                return;
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: AppPadding.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSpacing.defaultSpacing,
            children: [
              Text(
                "Settings",
                textAlign: TextAlign.start,
                style: textTheme.displayLarge?.copyWith(color: AppColors.textPrimary),
              ),
              _MonthlyBudgetView(),
              _CategoriesView(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MonthlyBudgetView extends StatefulWidget {
  const _MonthlyBudgetView();

  @override
  State<_MonthlyBudgetView> createState() => _MonthlyBudgetViewState();
}

class _MonthlyBudgetViewState extends State<_MonthlyBudgetView> {
  final _formKey = GlobalKey<FormState>();

  void onLoadMonthlyBudget(BuildContext context) {
    final selectedMonth = context.read<SelectedMonthCubit>().state;
    context.read<MonthlyBudgetCubit>().loadMonthlyBudget(month: selectedMonth);
  }

  void onSaveMonthlyBudget(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<MonthlyBudgetCubit>().saveMonthlyBudget();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<MonthlyBudgetCubit, MonthlyBudgetState>(
      listener: (context, state) {
        if (state is MonthlyBudgetLoaded) {
          final saveState = state.saveState;

          if (saveState is ActionSuccess) {
            onLoadMonthlyBudget(context);
            AppSnackBar.showSuccess(context, message: "Monthly budget saved successfully");
            return;
          }
          if (saveState is ActionError) {
            AppSnackBar.showError(context, message: "Failed to save monthly budget: ${saveState.message}");
            return;
          }
        }
      },
      builder: (context, state) {
        if (state is MonthlyBudgetLoading || state is MonthlyBudgetInitial) {
          return const MonthlyBudgetShimmer();
        }

        if (state is MonthlyBudgetError) {
          return ErrorStateWidget(message: state.message, onRetry: () => onLoadMonthlyBudget(context));
        }
        if (state is MonthlyBudgetLoaded) {
          final data = state.data;
          final isSaving = state.saveState is ActionLoading;
          Logger.info("Loaded monthly budget for month: ${data.monthKey} with amount: ${data.budgetAmount}");
          return Form(
            key: _formKey,
            child: DefaultCard(
              children: [
                CustomTextFormField(
                  label: "Monthly Budget for",
                  labelMainAxisAlignment: MainAxisAlignment.start,
                  labelTrailing: BlocBuilder<SelectedMonthCubit,DateTime>(builder: (context, selectedMonth) {
                    return TextButton(
                      child: Text(DateFormater.formatYearMonth(selectedMonth), textAlign: TextAlign.center, style: textTheme.titleSmall?.copyWith(color: AppColors.textPrimary,fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        final pickedMonth = await DatePicker.showMonthPickerDialog(context, initialDate: selectedMonth);
                        if (pickedMonth != null && context.mounted) {
                          context.read<SelectedMonthCubit>().onMonthChanged(newMonth: pickedMonth);
                        }
                      },
                    );
                  },),
                  // labelTrailing: TextButton(onPressed: onPressed, child: child),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton(
                          onPressed: isSaving ? null : () => onSaveMonthlyBudget(context),
                          child: isSaving ? const CustomProgressIndicator() : const  Text("Save"),
                        ),
                      ],
                    ),
                  ),
                  hintText: "0.00",
                  initialValue: CurrencyFormat.number(data.budgetAmount),
                  style: textTheme.titleMedium?.copyWith(fontSize: 24),
                  hintStyle: textTheme.labelSmall?.copyWith(fontSize: 24),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                  validator: AppValidator.amount,
                  prefixIcon: Icon(Icons.attach_money),
                  onChanged: (value) {
                    final parsedValue = num.tryParse(value) ?? 0.0;
                    if (parsedValue >= 0) {
                      final selectedMonth = context.read<SelectedMonthCubit>().state;
                      context.read<MonthlyBudgetCubit>().updateMonthlyBudget(newBudget: parsedValue, month: selectedMonth);
                    }
                  },
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _CategoriesView extends StatefulWidget {
  const _CategoriesView();

  @override
  State<_CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<_CategoriesView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController categoryNameController = TextEditingController();

  @override
  dispose() {
    categoryNameController.dispose();
    super.dispose();
  }

  Future<void> onAddCategory(BuildContext context) async {
    Logger.info("Add category button pressed");
    categoryNameController.clear();
    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        constraints: BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth,minWidth: 300),
        title: const Text("Add Category"),
        content: Form(
          key: _formKey,
          child: CustomTextFormField(
            label: "Category Name",
            hintText: "e.g. Food, Transport, etc.",
            controller: categoryNameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Category name is required";
              }
              return null;
            },
          ),
        ),
        actions: [
          OutlinedButton(onPressed: () => Navigator.of(dialogContext).pop(), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              // Check if the widget is still on screen before using context!
              if (!mounted) return;
              final newCategoryName = categoryNameController.text.trim();
              context.read<AddCategoryCubit>().addCategory(categoryName: newCategoryName);
              Navigator.of(dialogContext).pop();
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  Future<void> onDeleteCategory(BuildContext context, CategoryModel category) async {
    Logger.info("Delete category with id: ${category.categoryId} and name: ${category.categoryName}");

    await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (dialogContext) {
        return BlocProvider(
          create: (providerContext) => serviceLocator<DeleteCategoryCubit>(),
          child: BlocConsumer<DeleteCategoryCubit, DeleteCategoryState>(
            listener: (listenerContext, state) {
              if (state is DeleteCategorySuccess) {
                context.read<CategoriesBloc>().add(DeleteCategoryEvent(categoryId: state.categoryToDelete.categoryId!));
                listenerContext.pop();
                AppSnackBar.showSuccess(context, message: "${state.categoryToDelete.categoryName} deleted successfully.");
              }
            },
            builder: (builderContext, state) {
              final isLoading = state is DeleteCategoryLoading;
              final isError = state is DeleteCategoryError;
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
                      Text("Delete Category", style: Theme.of(builderContext).textTheme.titleLarge),
                      if (isError) const Icon(Icons.error_outline, color: AppColors.error, size: 48),
                      Text(
                        isError
                            ? state.errorMessage
                            : "Are you sure you want to delete the category \"${category.categoryName}\"? This action cannot be undone.",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(builderContext).textTheme.bodySmall?.copyWith(color: isError ? AppColors.error : AppColors.textSecondary),
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
                                    builderContext.read<DeleteCategoryCubit>().deleteCategory(categoryToDelete: category);
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading || state is CategoriesInitial) {
          return const CategoriesShimmer();
        }

        if (state is CategoriesError) {
          return ErrorStateWidget(message: state.message, onRetry: () => context.read<CategoriesBloc>().add(const LoadCategoriesEvent()));
        }
        if (state is CategoriesLoaded) {
          return Column(
            spacing: AppSpacing.defaultSpacing,
            children: [
              _CategoryHeaderButton(onAddCategory: () => onAddCategory(context)),
              _CategoriesListView<CategoryModel>(
                onDeleteCategory: (category) => onDeleteCategory(context, category),
                labelBuilder: (category) => category.categoryName,
                categories: state.categories,
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _CategoryHeaderButton extends StatelessWidget {
  const _CategoryHeaderButton({this.onAddCategory});

  final Function()? onAddCategory;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            textAlign: TextAlign.start,
            style: textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
          ),

          BlocSelector<AddCategoryCubit, AddCategoryState, bool>(
            selector: (state) {
              if (state is AddCategoryLoading) {
                return true;
              }
              return false;
            },
            builder: (context, isLoading) {
              return OutlinedButton(
                style: Theme.of(context).outlinedButtonTheme.style?.copyWith(backgroundColor: WidgetStateProperty.all(AppColors.surface)),
                onPressed: isLoading ? null : onAddCategory,
                child: isLoading ? CustomProgressIndicator() : Text("Add"),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CategoriesListView<T> extends StatelessWidget {
  const _CategoriesListView({super.key, this.categories = const [], this.onDeleteCategory, required this.labelBuilder});

  final List<T> categories;
  final Function(T category)? onDeleteCategory;
  final String Function(T category) labelBuilder;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text(
            "No categories added yet",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
      child: ListView.builder(
        itemCount: categories.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final first = index == 0;
          final last = index == categories.length - 1;
          final shape = RoundedRectangleBorder(
            side: BorderSide(color: AppColors.primaryLight, width: 1),
            borderRadius: BorderRadius.vertical(
              top: first ? Radius.circular(8) : Radius.zero,
              bottom: last ? Radius.circular(8) : Radius.zero,
            ),
          );
          return ListTile(
            shape: shape,
            title: Text(labelBuilder(categories[index])),
            trailing: IconButton(
              onPressed: () => onDeleteCategory?.call(categories[index]),
              icon: Icon(Icons.delete, color: AppColors.error),
            ),
          );
        },
      ),
    );
  }
}
