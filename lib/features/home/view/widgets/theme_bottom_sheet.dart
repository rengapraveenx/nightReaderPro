
import 'package:flutter/material.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: Colors.black,
      child: const Center(
        child: Text(
          'Theme Settings',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
