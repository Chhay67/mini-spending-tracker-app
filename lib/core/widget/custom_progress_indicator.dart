

import 'package:flutter/material.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()));
  }
}
