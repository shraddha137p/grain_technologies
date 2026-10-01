import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:grain_machine_test/core/widgets/extensions.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/common_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 440.h,
            child: Image.asset(
              'assets/images/welcome_illustration.png',
              width: double.infinity,
              height: 440.h,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: Column(
                children: [
                  SizedBox(height: 28.h),
                  CommonText.bold(
                    'Manage Your Users',
                    size: 26.sp,
                    color: context.colorScheme.onSurface,
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 14.h),

                  CommonText.regular(
                    'View user details and manage your user list\n'
                        'with simple and easy navigation.',
                    size: 14.sp,
                    color: context.colorScheme.onSurfaceVariant,
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 58.h,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.register);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        foregroundColor: context.colorScheme.onPrimary,
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: CommonText.semiBold(
                        'SIGN UP',
                        size: 13.sp,
                        color: context.colorScheme.onPrimary,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.login);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CommonText.medium(
                          'ALREADY HAVE AN ACCOUNT? ',
                          size: 13.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        CommonText.semiBold(
                          'LOG IN',
                          size: 13.sp,
                          color: context.colorScheme.primary,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 60.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
