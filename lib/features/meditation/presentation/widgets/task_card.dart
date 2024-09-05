import 'package:flutter/material.dart';
import 'package:mind_care/theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });
  final String title;
  final String description;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 6.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        description,
                        style: AppTheme.lightTheme.textTheme.labelSmall,
                      ),
                    ),
                    const SizedBox(
                      height: 3.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      child: const Icon(Icons.arrow_forward),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
