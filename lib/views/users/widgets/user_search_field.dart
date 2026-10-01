import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:grain_machine_test/core/widgets/extensions.dart';

import '../../../core/widgets/common_text_field.dart';

class UserSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const UserSearchField({
    required this.controller,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54.h,
      child: CommonTextField(
        controller: controller,
        hintText: 'Search users...',
        keyboardType: TextInputType.text,
        inputAction: TextInputAction.search,
        prefixIcon: Icon(
          Icons.search_rounded,
          size: 24.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),
        bgColor: context.colorScheme.surfaceContainerHigh,
        borderColor: Colors.transparent,
        borderWidth: 0,
        borderRadius: 30.r,
        onChanged: onChanged,
      ),
    );
  }
}