import 'package:flutter/material.dart';

/// Spacer widget to add space at the bottom of scrollable pages
/// to prevent content from being hidden behind the glass bottom navigation bar
class BottomNavSpacer extends StatelessWidget {
  const BottomNavSpacer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 150);
  }
}
