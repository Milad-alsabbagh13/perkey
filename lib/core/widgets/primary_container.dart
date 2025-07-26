import 'package:flutter/material.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/styles/text_styles.dart';

class PrimaryContainer extends StatelessWidget {
  const PrimaryContainer({
    super.key,
    this.color = kPrimaryColor,
    required this.text,
    this.textColor = kOnPrimaryColor,
  });
  final Color color;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyles.styleMedium16(
            context,
          ).copyWith(fontSize: 22, color: textColor),
        ),
      ),
    );
  }
}
