
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get_utils/src/extensions/widget_extensions.dart';
import 'extensions.dart';

class CommonTextField extends StatelessWidget {
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator<String>? validator;
  final GlobalKey<FormFieldState>? _fieldKey;
  final ValueChanged<String>? fieldSubmitted;
  final TextEditingController controller;
  final BoxConstraints? iconConstraints;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String labelText;
  final FocusNode? focus;
  final bool isReadOnly;
  final String hintText;
  final Widget? suffix;
  final Widget? prefix;
  final bool isCanSee;
  final bool obscure;
  final int maxLines;
  final int minLines;
  final Widget Function(
      BuildContext, {
      required int currentLength,
      required bool isFocused,
      required int? maxLength,
      })? buildCounter;
  final TextCapitalization? textCapitalization;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? cursorColor;
  final double? contentPadding;
  final double? verticalPadding;
  final double? horizontalPadding;
  final int? maxLength;
  final double? borderWidth;
  final double borderRadius;
  final String? showCounter;

  const CommonTextField({
    required this.controller,
    this.labelText = "",
    GlobalKey<FormFieldState>? globalKey,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.inputAction = TextInputAction.next,
    this.validator,
    this.fieldSubmitted,
    this.focus,
    this.onChanged,
    this.prefix,
    this.suffix,
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters = const [],
    this.maxLines = 1,
    this.minLines = 1,
    this.isReadOnly = false,
    this.hintText = "",
    this.textAlign = TextAlign.start,
    this.onTap,
    this.iconConstraints = const BoxConstraints(maxWidth: 160),
    super.key,
    this.obscuringCharacter = '•',
    this.autofillHints,
    this.isCanSee = false,
    this.buildCounter,
    this.textCapitalization,
    this.borderColor,
    this.bgColor,
    this.textColor,
    this.cursorColor,
    this.contentPadding,
    this.verticalPadding = 16,
    this.horizontalPadding = 16,
    this.borderRadius = 12,
    this.maxLength,
    this.showCounter,
    this.borderWidth,
  }) : _fieldKey = globalKey;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: BorderSide(
        color: borderColor ?? context.colorScheme.scrim.withValues
          (alpha: 0.1),
        width: borderWidth ?? 1,
      ),
    );

    OutlineInputBorder focusedBorderStyle = borderStyle.copyWith(
      borderSide: BorderSide(
        color: borderColor ?? context.colorScheme.scrim,
        width: borderWidth ?? 1.5,
      ),
    );

    OutlineInputBorder errorBorderStyle = borderStyle.copyWith(
      borderSide: BorderSide(
        color: context.colorScheme.error,
        width: borderWidth ?? 1.5,
      ),
    );

    return TextFormField(
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      cursorColor: cursorColor ?? context.colorScheme.onSurfaceVariant,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscuringCharacter: obscuringCharacter,
      readOnly: isReadOnly,
      autofocus: false,
      canRequestFocus: !isReadOnly,
      inputFormatters: inputFormatters,
      onFieldSubmitted: fieldSubmitted,
      autofillHints: autofillHints,
      textInputAction: inputAction,
      buildCounter: buildCounter,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscure,
      onChanged: onChanged,
      maxLength: maxLength,
      validator: validator,
      textAlign: textAlign,
      maxLines: maxLines,
      minLines: minLines,
      focusNode: focus,
      key: _fieldKey,
      onTap: onTap,
      style: context.textTheme.bodyLarge?.copyWith(
        color: textColor ?? context.colorScheme.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      decoration: InputDecoration(
        prefixIconConstraints: iconConstraints ?? BoxConstraints(maxWidth: 160.w),
        suffixIconConstraints: iconConstraints ?? BoxConstraints(maxWidth: 160.w),
        suffixIcon: suffixIcon?.marginOnly(left: 14.w, right: 14.w),
        prefixIcon: prefixIcon?.marginOnly(left: 14.w, right: 8.w),
        fillColor: bgColor ?? context.colorScheme.surface,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.error,
          fontSize: 12.sp,
        ),
        hintStyle: context.textTheme.bodyMedium!.copyWith(
          color: context.colorScheme.scrim.withValues
            (alpha: 0.4),
          fontSize: 14.sp,
        ),
        isDense: true,

        contentPadding: EdgeInsets.symmetric(
          horizontal: 0.w,
          vertical: 12.h,
        ),

        focusedBorder: focusedBorderStyle,
        errorBorder: errorBorderStyle,
        enabledBorder: borderStyle,
        counterText: showCounter,
        alignLabelWithHint: true,
        border: borderStyle,
        hintText: hintText,
        prefix: prefix,
        suffix: suffix,
        filled: true,
      ),
    );
  }
}

