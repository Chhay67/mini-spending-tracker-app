import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/utils/app_padding.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';
import 'package:mini_spend_tracker_app/page/widget/amount_text_form_field.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/date_format.dart';
import '../core/utils/date_picker.dart';
import '../core/widget/custom_dropdown_button2.dart';
import '../core/widget/custom_text_form_field.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  @override
  void dispose() {
    _amountController.dispose();
    _dateController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _onSaveExpense() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
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
              style: textTheme.displayLarge?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              "log your expenses and keep track of your spending habits",
              style: textTheme.bodySmall,
              textAlign: TextAlign.start,
            ),
            DefaultCard(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Amount", style: textTheme.titleMedium),
                AmountTextFormField(amountController: _amountController),
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
                    final selectedDate = await DatePicker.showDatePickerDialog(
                      context,
                      initialDate: _selectedDate,
                    );
                    if (selectedDate != null) {
                      _selectedDate = selectedDate;
                      _dateController.text = DateFormater.formatDate(
                        selectedDate,
                      );
                      Logger.info("Selected date: ${_dateController.text}");
                    }
                  },
                  suffixIcon: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.navUnselected,
                  ),
                ),
                CustomDropdownButton2(
                  label: "category",
                  labelBuilder: (item) => item ?? "",
                  hintText: "Select category",
                  isRequired: true,
                  items: const [
                    "Food",
                    "Transportation",
                    "Entertainment",
                    "Utilities",
                    "Health",
                    "Education",
                    "Shopping",
                    "Other",
                  ],
                  onChanged: (value) {
                    Logger.info("Selected category: $value");
                  },
                ),
                CustomTextFormField(
                  label: "Note(optional)",
                  hintText: "Add a note about this expense...",
                  controller: _noteController,
                  minLines: 4,
                  maxLines: 4,
                ),
                Divider(color: AppColors.primaryLight, thickness: 1),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: theme.elevatedButtonTheme.style,
                    onPressed: _onSaveExpense,
                    child: Text("Save Expense"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
