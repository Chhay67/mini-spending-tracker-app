import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/bloc/add_expense_cubit/add_expense_cubit.dart';
import 'package:mini_spend_tracker_app/core/utils/app_padding.dart';
import 'package:mini_spend_tracker_app/core/utils/app_snack_bar.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';
import 'package:mini_spend_tracker_app/core/widget/custom_progress_indicator.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';
import 'package:mini_spend_tracker_app/init_dependencies.dart';
import 'package:mini_spend_tracker_app/page/widget/categories_dropdown_button_form_field2.dart';
import 'package:mini_spend_tracker_app/route/app_navigation.dart';
import '../bloc/settings/categories_bloc/categories_bloc.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/app_validator.dart';
import '../core/utils/date_format.dart';
import '../core/utils/date_picker.dart';
import '../core/widget/custom_text_form_field.dart';
import '../route/routes.dart';

class AddOrUpdateExpensePage extends StatefulWidget {
  const AddOrUpdateExpensePage({super.key, this.transactionId, this.note, this.amount, this.date, this.categoryId});
  final String? transactionId;
  final String? note;
  final num? amount;
  final DateTime? date;
  final String? categoryId;

  @override
  State<AddOrUpdateExpensePage> createState() => _AddOrUpdateExpensePageState();
}

class _AddOrUpdateExpensePageState extends State<AddOrUpdateExpensePage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController noteController;
  late final TextEditingController amountController;
  late final TextEditingController dateController;
  String? _selectedCategoryId;
  late DateTime _selectedDate = DateTime.now();

  bool get isEditMode => widget.transactionId != null;

  @override
  void initState() {
    noteController = TextEditingController(text: widget.note);
    amountController = TextEditingController(text: widget.amount != null ? widget.amount.toString() : "");
    _selectedDate = widget.date ?? DateTime.now();
    dateController = TextEditingController(text: widget.date != null ? DateFormater.formatDate(widget.date!) : DateFormater.formatDate(_selectedDate));
    _selectedCategoryId = widget.categoryId;

    super.initState();
  }

  @override
  void dispose() {
    amountController.dispose();
    noteController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void _onSaveExpense({required BuildContext context}) {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if(isEditMode){
      context.read<AddExpenseCubit>().updateExpense(
        transactionId: widget.transactionId!,
        amount: num.parse(amountController.text),
        date: _selectedDate,
        categoryId: _selectedCategoryId ?? "",
        note: noteController.text.isEmpty ? null : noteController.text.trim(),
      );
    }else{
      context.read<AddExpenseCubit>().addExpense(
        amount: num.parse(amountController.text),
        date: _selectedDate,
        categoryId: _selectedCategoryId ?? "",
        note: noteController.text.isEmpty ? null : noteController.text.trim(),
      );
    }

  }

  void _resetForm() {
    formKey.currentState?.reset();
    noteController.clear();
    amountController.clear();
    dateController.text = DateFormater.formatDate(DateTime.now());
    _selectedCategoryId = null;
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<CategoriesBloc>()..add(LoadCategoriesEvent())),
        BlocProvider(create: (context) => serviceLocator<AddExpenseCubit>()),
      ],
      child: BlocConsumer<AddExpenseCubit, AddExpenseState>(
        listener: (context, state) {
          if (state is AddExpenseSuccess) {
            _resetForm();
            AppSnackBar.showSuccess(
              context,
              message: "Expense added successfully",
              trialing: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  elevation: 0,
                ),
                onPressed: () => AppNavigation.navigateToRoute(context: context, routePath: Routes.transactions.path),
                child: Text("view transactions", style: textTheme.bodySmall?.copyWith(color: Colors.white)),
              ),
            );
            return;
          }
          if(state is UpdateExpenseSuccess){
            _resetForm();
            AppSnackBar.showSuccess(
              context,
              message: "Expense updated successfully" ,
              trialing: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  elevation: 0,
                ),
                onPressed: () => AppNavigation.navigateToRoute(context: context, routePath: Routes.transactions.path),
                child: Text("view transactions", style: textTheme.bodySmall?.copyWith(color: Colors.white)),
              ),
            );
            AppNavigation.navigateToRoute(context: context, routePath: Routes.addExpense.path);
          }
          if (state is AddExpenseError) {
            final bool isMessageContainBudgetNotFound = state.message.toLowerCase().contains("Budget not found".toLowerCase());
            AppSnackBar.showError(
                context, message:  state.message,
              trialing:isMessageContainBudgetNotFound ? TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  elevation: 0,
                ),
                onPressed: () => AppNavigation.navigateToRoute(context: context, routePath: Routes.settings.path),
                child: Text("Go Settings", style: textTheme.bodySmall?.copyWith(color: Colors.white)),
              ) : null,
            );
            return;
          }
          if (state is UpdateExpenseError) {
            final bool isMessageContainBudgetNotFound = state.message.toLowerCase().contains("Budget not found".toLowerCase());
            AppSnackBar.showError(
              context, message:  state.message,
              trialing:isMessageContainBudgetNotFound ? TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(color: Colors.white, width: 0.5),
                  ),
                  elevation: 0,
                ),
                onPressed: () => AppNavigation.navigateToRoute(context: context, routePath: Routes.settings.path),
                child: Text("Go Settings", style: textTheme.bodySmall?.copyWith(color: Colors.white)),
              ) : null,
            );
            return;
          }
        },

        builder: (context, state) {
          final isSaveSuccess = state is AddExpenseSuccess || state is UpdateExpenseSuccess;
          final isSaving = state is AddExpenseLoading || state is UpdateExpenseLoading;

          return Form(
            key: formKey,
            child: SingleChildScrollView(
              padding: AppPadding.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppSpacing.defaultSpacing,
                children: [
                  Text(
                    isEditMode ? "Update Expense" :"Add Expense",
                    textAlign: TextAlign.start,
                    style: textTheme.displayLarge?.copyWith(color: AppColors.textPrimary),
                  ),
                  Text("log your expenses and keep track of your spending habits", style: textTheme.bodySmall, textAlign: TextAlign.start),
                  DefaultCard(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount", style: textTheme.titleMedium),
                      TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                        style: textTheme.displayLarge,
                        validator: AppValidator.amount,
                        autovalidateMode: AutovalidateMode.disabled,
                        textAlign: TextAlign.center,
                        controller: amountController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "0.00",
                          hintStyle: textTheme.displayLarge?.copyWith(color: Colors.grey[500]),
                          fillColor: AppColors.surface,
                          focusColor: AppColors.surface,
                          hoverColor: AppColors.surface,
                          prefixIcon: Icon(Icons.attach_money, color: AppColors.primary, size: 42),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: AppColors.error, width: 1),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide: BorderSide(color: AppColors.error, width: 1),
                          ),
                        ),
                      ),
                      Divider(color: AppColors.primaryLight, thickness: 1),
                      CustomTextFormField(
                        label: "Date",
                        hintText: "Select date",
                        readOnly: true,
                        showCursor: true,
                        enabled: false,
                        isRequired: true,
                        controller: dateController,
                        onTap: () async {
                          Logger.info("Date field tapped");
                          final selectedNewDate = await DatePicker.showDatePickerDialog(context, initialDate: _selectedDate);
                          if (selectedNewDate != null && context.mounted) {
                            dateController.text = DateFormater.formatDate(selectedNewDate);
                            _selectedDate = selectedNewDate;
                          }
                        },
                        suffixIcon: Icon(Icons.calendar_month_outlined, color: AppColors.navUnselected),
                      ),
                      CategoriesDropdownButtonFormField2(
                        isReset: isSaveSuccess,
                        initialCategory: _selectedCategoryId,
                        onChanged: (category) {
                          if (category.categoryId == null) return;
                          _selectedCategoryId = category.categoryId;
                        },
                      ),
                      CustomTextFormField(
                        label: "Note(optional)",
                        hintText: "Add a note about this expense...",
                        minLines: 4,
                        maxLines: 4,
                        controller: noteController,
                      ),
                      Divider(color: AppColors.primaryLight, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: isSaving ? null : () => _onSaveExpense(context: context),

                            child: isSaving ? const CustomProgressIndicator() :  Text( isEditMode  ? "Update Expense": "Add Expense"),
                          ),
                        ],
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
  }
}
