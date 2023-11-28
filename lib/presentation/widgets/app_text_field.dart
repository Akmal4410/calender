import 'package:calender/utils/contants/sizes.dart';
import 'package:calender/utils/contants/text_style.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.inputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.controller,
    this.validator,
    this.onChanged,
    this.maxLines,
  });

  final String hint;
  final int? maxLines;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final IconData? suffixIcon;
  final bool obscureText;
  final VoidCallback? onSuffixTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? GestureDetector(
                onTap: onSuffixTap,
                child: Padding(
                  padding: kAppPaddingAll10,
                  child: Icon(suffixIcon),
                ),
              )
            : kSizedBox,
        contentPadding: kAppDefaultPadding,
        border: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(),
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: hint,
        labelText: hint,
        hintStyle: kTextStyle14Regular,
      ),
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      style: kTextStyle14Regular,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      textCapitalization: textCapitalization,
      onChanged: onChanged,
    );
  }
}
