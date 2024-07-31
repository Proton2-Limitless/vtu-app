import 'package:flutter/material.dart';
import 'package:vtu_client/utils/constant_widget.dart';

class QuickAccess extends StatelessWidget {
  const QuickAccess({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPress,
  });

  final String text;
  final IconData icon;
  final Color color;
  final void Function() onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
          ),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: customColor(context),
                ),
          )
        ],
      ),
    );
  }
}
