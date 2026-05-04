import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/core/utils/app_padding.dart';

import '../../bloc/settings/categories_bloc/categories_bloc.dart';
import '../../core/utils/logger.dart';
import '../../core/widget/custom_dropdown_button_form_field2.dart';
import '../../model/category_model.dart';
import '../../route/app_navigation.dart';
import '../../route/routes.dart';

class CategoriesDropdownButtonFormField2 extends StatelessWidget {
  const CategoriesDropdownButtonFormField2({super.key, this.onChanged, this.isReset = false, this.initialCategory});

  final void Function(CategoryModel category)? onChanged;
  final bool isReset;
  final String? initialCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        final categories = state is CategoriesLoaded ? state.categories : <CategoryModel>[];
        final isLoading = state is CategoriesLoading;
        final isError = state is CategoriesError;

        // When the list is empty (and not loading/error), guide the user to Settings.
        if (!isLoading && !isError && categories.isEmpty) {
          return const _GoToSettingsHint();
        }

        final initCategory = categories.firstWhereOrNull((category) => category.categoryId == initialCategory);
        return CustomDropdownButtonFormField2<CategoryModel>(
          label: "category",
          labelBuilder: (item) => item?.categoryName ?? "Select category",
          hintText: "Select category",
          initValue: initCategory,
          isRequired: true,
          items: categories,
          isLoading: isLoading,
          isError: isError,
          isReset: isReset,
          errorMessage: isError ? state.message : null,
          onRefresh: () async => context.read<CategoriesBloc>().add(const LoadCategoriesEvent()),
          onChanged: (category) {
            Logger.info("Selected category: ${category.categoryName}");
            onChanged?.call(category);
          },
        );
      },
    );
  }
}

class _GoToSettingsHint extends StatelessWidget {
  const _GoToSettingsHint();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => AppNavigation.navigateToRoute(
        context: context,
        routePath: Routes.settings.path,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding, vertical: AppPadding.defaultPadding),
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.orange.shade200),
        ),

        child: Column(
          children: [
            Text(
              "No categories found",
              style: textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.orange.shade800),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline_rounded, size: 16, color: Colors.orange.shade400),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    'No categories yet — go to Settings to add one',
                    style: textTheme.labelSmall?.copyWith(color: Colors.orange.shade600),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.arrow_forward_ios_rounded, size: 12, color: Colors.orange.shade400),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
