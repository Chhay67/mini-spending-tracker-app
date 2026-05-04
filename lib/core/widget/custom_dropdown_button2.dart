import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/constants.dart';
import '../theme/app_colors.dart';

class CustomDropdownButton2<T> extends StatefulWidget {
  const CustomDropdownButton2({
    super.key,
    required this.items,
    required this.onChanged,
    required this.labelBuilder,
    this.initValue,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
    this.onRefresh,
    this.padding = EdgeInsets.zero,
  });
  final List<T> items;

  /// The initially selected value.
  final T? initValue;

  final void Function(T item) onChanged;

  /// Builds the display string for each item.
  final String Function(T? item) labelBuilder;

  final bool isLoading;

  final bool isError;
  final String? errorMessage;

  final Future<void> Function()? onRefresh;
  final EdgeInsets padding;

  @override
  State<CustomDropdownButton2<T>> createState() => _CustomDropdownButton2State<T>();
}

class _CustomDropdownButton2State<T> extends State<CustomDropdownButton2<T>> {
  late final ValueNotifier<T?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<T?>(widget.initValue);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownButton2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.initValue != widget.initValue) {
      _valueNotifier.value = widget.initValue;
    }

    if (widget.items.isNotEmpty && _valueNotifier.value != null && !widget.items.contains(_valueNotifier.value)) {
      _valueNotifier.value = null;
    }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const _LoadingShimmer();
    }
    
    final textTheme = Theme.of(context).textTheme;
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        valueListenable: _valueNotifier,
        style: textTheme.labelSmall,
        isExpanded: false,
        isDense: true,
        buttonStyleData: ButtonStyleData(
          padding: widget.padding,
          height:  kDefaultDropDownHeight,
          elevation: 0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: AppColors.surface,
          ),
        ),

        dropdownStyleData: DropdownStyleData(
          elevation: 2,
          isOverButton: false,
          maxHeight: 240,
          padding: EdgeInsets.zero,
          useSafeArea: true,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.fromBorderSide(BorderSide(color: Colors.grey.shade400, width: 1)),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          useDecorationHorizontalPadding: true,
          selectedMenuItemBuilder: (context, child) => ColoredBox(color: AppColors.primaryLight, child: child),
        ),
        iconStyleData: IconStyleData(
          icon: widget.isError
              ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  tooltip: 'Refresh',
                  onPressed: widget.onRefresh == null ? null : () async => await widget.onRefresh!.call(),
                  icon: const Icon(Icons.refresh_rounded, color: AppColors.error, size: 20),
                )
              : widget.isLoading
              ? _LoadingShimmer()
              : Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey.shade500),
        ),
        onChanged: widget.isLoading
            ? null
            : (T? newValue) {
                if (newValue != null) {
                  _valueNotifier.value = newValue;
                  widget.onChanged(newValue);
                }
              },
        items: widget.items
            .map(
              (e) => DropdownItem<T>(
                value: e,
                child: Text(widget.labelBuilder(e), style: textTheme.labelSmall),
              ),
            )
            .toList(),
      ),
    );
  }
}


class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 35,
        width: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
      ),
    );
  }
}
