import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings/categories_bloc/categories_bloc.dart';
import '../../core/utils/logger.dart';
import '../../core/widget/custom_dropdown_button2.dart';
import '../../model/category_model.dart';

class CategoriesDropdownButton extends StatelessWidget {
  const CategoriesDropdownButton({super.key, this.onChanged,this.isReset = false,this.initialCategory});

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
        final initCategory = categories.firstWhereOrNull((category) => category.categoryId == initialCategory);
        return CustomDropdownButton2<CategoryModel>(
          label: "category",
          labelBuilder: (item) => item?.categoryName ?? "Select category",
          hintText: "Select category",
          initValue:initCategory ,
          isRequired: true,
          items: categories,
          isLoading: isLoading,
          isError: isError,
          isReset: isReset,
          errorMessage: state is CategoriesError ? state.message : null,
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
