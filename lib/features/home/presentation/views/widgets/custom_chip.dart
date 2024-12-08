import 'package:flutter/material.dart';
import 'package:food_app/core/exenstions/context_extenstion.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.label, required this.isSelected, required this.onTap});
final String label;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Chip(
        label: Text(
          label,
          style: context.textTheme.labelMedium?.copyWith(
            color:  isSelected
                ? context.colorScheme.onPrimaryContainer
                : Colors.grey,//context.colorScheme.onPrimaryContainer
          )
        ),
        backgroundColor: Colors.orange.withOpacity(0.1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side:BorderSide(
                color: Colors.orange.withOpacity(0.1)
            )
        ),
      ),
    );
  }
}
