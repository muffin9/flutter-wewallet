import 'package:flutter/material.dart';

enum ButtonVariant {
  defaultVariant,
  primary,
  kakao,
  success,
  ghost,
}

enum ButtonSize {
  small,
  medium,
  large,
}

class CustomButton extends StatelessWidget {
  final ButtonVariant variant;
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final ButtonSize size;
  final bool disabled;

  const CustomButton({
    super.key,
    this.variant = ButtonVariant.defaultVariant,
    required this.text,
    this.onPressed,
    this.width,
    this.size = ButtonSize.medium,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    // Calculated values based on size
    double height;
    EdgeInsetsGeometry padding;
    switch (size) {
      case ButtonSize.small:
        height = 32.0;
        padding = const EdgeInsets.symmetric(horizontal: 4);
        break;
      case ButtonSize.medium:
        height = 48.0;
        padding = const EdgeInsets.symmetric(horizontal: 8);
        break;
      case ButtonSize.large:
      default:
        height = 56.0;
        padding = const EdgeInsets.symmetric(horizontal: 16);
        break;
    }

    Color bgColor;
    TextStyle textStyle;
    BorderRadius borderRadius;
    switch (variant) {
      case ButtonVariant.defaultVariant:
        bgColor = Colors.white;
        textStyle = const TextStyle(
          fontFamily: 'Pretendard',
        );
        borderRadius = BorderRadius.circular(15);
        break;
      case ButtonVariant.primary:
        bgColor = Colors.cyan;
        textStyle = const TextStyle(
          fontFamily: 'Spoqa',
        );
        borderRadius = BorderRadius.circular(25);
        break;
      default:
        bgColor = Colors.transparent;
        textStyle = const TextStyle();
        borderRadius = BorderRadius.circular(0);
        break;
    }

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        padding: MaterialStateProperty.all(padding),
        textStyle: MaterialStateProperty.all(textStyle),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: borderRadius,
        )),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(text),
    );
  }
}
