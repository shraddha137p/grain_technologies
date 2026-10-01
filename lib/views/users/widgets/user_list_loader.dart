import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:grain_machine_test/core/widgets/extensions.dart';

import '../../../core/widgets/common_text.dart';

class UserListLoader extends StatelessWidget {
  const UserListLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
