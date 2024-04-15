import 'package:attendease/core/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: CustomCircularIndicator(),
      ),
    );
  }
}
