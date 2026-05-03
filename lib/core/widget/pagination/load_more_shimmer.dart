

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadMoreShimmer extends StatelessWidget {
  const LoadMoreShimmer({
    super.key,
    this.hasError = false,
    this.hasMoreData = false,
    this.errorWidget,
    this.loadingWidget,
  });
  final bool hasError;
  final bool hasMoreData;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return errorWidget ??
          const TextButton(
            onPressed: null,
            child: Text('Something went wrong!'),
          );
    }
    if (hasMoreData && !hasError) {
      return loadingWidget ?? const _DefaultLoadMoreShimmer();
    }
    return const SizedBox.shrink();
  }
}

class _DefaultLoadMoreShimmer extends StatelessWidget {
  const _DefaultLoadMoreShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          1,
          (index) => ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            title: Container(
              width: double.infinity,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            subtitle: Container(
              width: 100,
              height: 14,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            trailing: Container(
              width: 60,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
