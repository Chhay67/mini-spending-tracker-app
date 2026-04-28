import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_spend_tracker_app/core/widget/custom_text_form_field.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/app_validator.dart';
import '../core/utils/responsive_utils.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: AppPadding.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.defaultSpacing,
        children: [
          Text(
            "Settings",
            textAlign: TextAlign.start,
            style: textTheme.displayLarge?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),

          DefaultCard(
            children: [
              CustomTextFormField(
                label: "Monthly Budget",
                hintText: "0.00",
                style: textTheme.titleMedium?.copyWith(fontSize: 24),
                hintStyle: textTheme.labelSmall?.copyWith(fontSize: 24),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                // Only digits and a single decimal point are accepted
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                validator: AppValidator.amount,
                prefixIcon: Icon(Icons.attach_money),
              ),
            ],
          ),
          _CategoryHeaderButton(onAddCategory: () {}),
          _CategoriesListView<String>(
            onDeleteCategory: (category) {},
            categories: [
              "Food",
              "Transport",
              "Entertainment",
              "Utilities",
              "Health",
              "Education",
              "Shopping",
              "Travel",
              "Gifts",
              "Other",
            ],
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: ResponsiveUtils.mobileMaxWidth,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.maxFinite, 52),
              ),
              onPressed: () {},
              child: Text("Save Settings"),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriesListView<T> extends StatelessWidget {
  const _CategoriesListView({
    super.key,
    this.categories = const [],
    this.onDeleteCategory,
  });

  final List<T> categories;
  final Function(T category)? onDeleteCategory;

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text(
            "No categories added yet",
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: ResponsiveUtils.mobileMaxWidth,
      ),
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
            title: Text(categories[index].toString()),
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

class _CategoryHeaderButton extends StatelessWidget {
  const _CategoryHeaderButton({this.onAddCategory});

  final Function()? onAddCategory;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: ResponsiveUtils.mobileMaxWidth,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Categories",
            textAlign: TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: AppColors.primaryDark,
                width: 1,
              )
            ),
              onPressed: onAddCategory, child: Text("Add")),
        ],
      ),
    );
  }
}
