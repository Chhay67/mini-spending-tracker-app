import 'package:flutter/material.dart';

import 'load_more_shimmer.dart';

class PaginationListView extends StatelessWidget {
  const PaginationListView(
      {
        super.key,
        required this.hasMoreData,
        required this.itemCount,
        required this.itemBuilder,
        this.separatorBuilder,
        this.emptyWidget,
        this.errorWidget,
        this.loadingWidget,
        this.hasError = false,
        this.padding,
        this.shrinkWrap = false,
        this.physics,
      });


  final int itemCount;
  final bool hasMoreData;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final Widget? emptyWidget;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final bool hasError;

  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  @override
  Widget build(BuildContext context) {
    if (itemCount <= 0) {
      return Center(child: emptyWidget ?? const Text('Empty Data'));
    }
    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      separatorBuilder:
      separatorBuilder ?? (context, index) => const SizedBox.shrink(),
      itemCount: itemCount + 1,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 12),
      itemBuilder: (context, index) {
        if (index == itemCount) {
          return LoadMoreShimmer(
            hasMoreData: hasMoreData,
            hasError: hasError,
            errorWidget: errorWidget,
            loadingWidget: loadingWidget,
          );
        }
        return itemBuilder(context, index);
      },
    );
  }
}