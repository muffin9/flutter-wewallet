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
  final VoidCallback? onClick;
  final double? width;
  final ButtonSize size;
  final String? className; // Note: This has no direct equivalent in Flutter
  final bool disabled;

  const CustomButton({
    super.key,
    this.variant = ButtonVariant.defaultVariant,
    required this.text,
    this.onClick,
    this.width,
    this.size = ButtonSize.medium,
    this.className,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    // Calculated values based on size
    double height;
    EdgeInsetsGeometry padding;
    switch (size) {
      case ButtonSize.small:
        height = 32;
        padding = const EdgeInsets.symmetric(horizontal: 4);
        break;
      case ButtonSize.medium:
        height = 48;
        padding = const EdgeInsets.symmetric(horizontal: 8);
        break;
      case ButtonSize.large:
      default:
        height = 56;
        padding = const EdgeInsets.symmetric(horizontal: 16);
        break;
    }

    Color bgColor;
    TextStyle textStyle;
    BorderRadius borderRadius;
    switch (variant) {
      case ButtonVariant.defaultVariant:
        bgColor = Colors.grey;
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
      onPressed: disabled ? null : onClick,
      child: Text(text),
    );
  }
}
