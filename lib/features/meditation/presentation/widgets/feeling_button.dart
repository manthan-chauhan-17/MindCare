import 'package:flutter/material.dart';
import 'package:mind_care/theme.dart';

class FeelingButton extends StatelessWidget {
  const FeelingButton({
    super.key,
    required this.label,
    required this.image,
    required this.color,
    required this.onTap,
  });
  final String label;
  final String image;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: color,
            ),
            child: Image.asset(
              image,
              height: 25.0,
            ),
          ),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.labelSmall,
          )
        ],
      ),
    );
  }
}
