import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/bloc/add_expense_cubit/add_expense_cubit.dart';
import 'package:mini_spend_tracker_app/core/utils/app_padding.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';
import 'package:mini_spend_tracker_app/init_dependencies.dart';
import 'package:mini_spend_tracker_app/page/widget/categories_dropdown_button.dart';

import '../bloc/add_expense_cubit/add_expense_state.dart';
import '../bloc/settings/categories_bloc/categories_bloc.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/app_validator.dart';
import '../core/utils/date_format.dart';
import '../core/utils/date_picker.dart';
import '../core/widget/custom_text_form_field.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _dateController;

  @override
  void initState() {
    _dateController = TextEditingController(text: DateFormater.formatDate(DateTime.now()));
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _onSaveExpense({required BuildContext context}) {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AddExpenseCubit>().addExpense();
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
        listener: (context, state) {},
        builder: (context, state) {
          final expenseData = state.addExpense;
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: AppPadding.all,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: AppSpacing.defaultSpacing,
                children: [
                  Text(
                    "Add Expense",
                    textAlign: TextAlign.start,
                    style: textTheme.displayLarge?.copyWith(color: AppColors.textPrimary),
                  ),
                  Text("log your expenses and keep track of your spending habits", style: textTheme.bodySmall, textAlign: TextAlign.start),
                  DefaultCard(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Amount", style: textTheme.titleMedium),
                      TextFormField(
                        initialValue: expenseData?.amount != null ? expenseData!.amount.toString() : null,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: false),
                        // Only digits and a single decimal point are accepted
                        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
                        style: textTheme.displayLarge,
                        validator: AppValidator.amount,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textAlign: TextAlign.center,
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
                        onChanged: (value) {
                          if (value.isEmpty) return;
                          final amount = double.tryParse(value);
                          if (amount != null) {
                            context.read<AddExpenseCubit>().updateAddExpense(amount: amount);
                          }
                        },
                      ),
                      Divider(color: AppColors.primaryLight, thickness: 1),
                      CustomTextFormField(
                        label: "Date",
                        hintText: "Select date",
                        readOnly: true,
                        showCursor: true,
                        enabled: false,
                        controller: _dateController,
                        isRequired: true,
                        onTap: () async {
                          Logger.info("Date field tapped");
                          final selectedDate = await DatePicker.showDatePickerDialog(context, initialDate: expenseData?.date);
                          if (selectedDate != null && context.mounted) {
                            _dateController.text = DateFormater.formatDate(selectedDate);
                            context.read<AddExpenseCubit>().updateAddExpense(date: selectedDate);
                          }
                        },
                        suffixIcon: Icon(Icons.calendar_month_outlined, color: AppColors.navUnselected),
                      ),
                      CategoriesDropdownButton(
                        onChanged: (category) {
                          context.read<AddExpenseCubit>().updateAddExpense(category: category.categoryName);
                        },
                      ),
                      CustomTextFormField(
                        label: "Note(optional)",
                        hintText: "Add a note about this expense...",
                        minLines: 4,
                        maxLines: 4,
                        initialValue: expenseData?.note,
                        onChanged: (note) {
                          if (note.isEmpty) return;
                          context.read<AddExpenseCubit>().updateAddExpense(note: note);
                        },
                      ),
                      Divider(color: AppColors.primaryLight, thickness: 1),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: theme.elevatedButtonTheme.style,
                          onPressed: () => _onSaveExpense(context: context),
                          child: Text("Save Expense"),
                        ),
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
