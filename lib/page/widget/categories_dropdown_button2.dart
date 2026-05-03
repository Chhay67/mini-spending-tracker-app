import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/settings/categories_bloc/categories_bloc.dart';
import '../../core/utils/logger.dart';
import '../../core/widget/custom_dropdown_button2.dart';
import '../../model/category_model.dart';

class CategoriesFilterDropdownButton2 extends StatelessWidget {
  const CategoriesFilterDropdownButton2({super.key, this.onChanged, this.initialCategory});
  final void Function(CategoryModel category)? onChanged;
  final String? initialCategory;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        final categories = state is CategoriesLoaded
            ? [CategoryModel(categoryName: "All categories"), ...state.categories]
            : <CategoryModel>[];
        final isLoading = state is CategoriesLoading;
        final isError = state is CategoriesError;
        final initCategory = categories.firstWhereOrNull((category) => category.categoryId == initialCategory);
        return CustomDropdownButton2<CategoryModel>(
          initValue: initCategory,
          isLoading: isLoading,
          isError: isError,
          errorMessage: state is CategoriesError ? state.message : null,
          onRefresh: () async => context.read<CategoriesBloc>().add(const LoadCategoriesEvent()),
          labelBuilder: (item) => item?.categoryName ?? "Select category",

          items: categories,
          onChanged: (category) {
            Logger.info("Selected category: ${category.categoryName}");
            onChanged?.call(category);
          },
        );
      },
    );
  }
}
