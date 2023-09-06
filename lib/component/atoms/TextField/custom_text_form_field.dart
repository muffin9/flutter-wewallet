import 'package:flutter/material.dart';
import 'package:flutter_wewallet/common/const/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.onChanged,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
        borderSide: BorderSide(
      color: INPUT_BORDER_COLOR,
      width: 1.0,
    ));

    return TextFormField(
      cursorColor: PRIMARY_COLOR,
      obscureText: obscureText,
      autofocus: autofocus,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14),
        fillColor: INPUT_BG_COLOR,
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
