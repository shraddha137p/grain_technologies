import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:grain_machine_test/core/utils/validators.dart';
import 'package:grain_machine_test/core/widgets/common_back_button.dart';
import 'package:grain_machine_test/core/widgets/common_button.dart';
import 'package:grain_machine_test/core/widgets/extensions.dart';

import '../../core/routes/app_routes.dart';
import '../../core/widgets/common_text.dart';
import '../../core/widgets/common_text_field.dart';
import '../../viewmodels/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 245.h,
              child: Image.asset(
                'assets/images/background-img.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Form(
                  key: controller.loginFormKey,
                  child: Column(
                    children: [
                      CommonBackButton(
                        onTap: () {
                          Get.back();
                        },
                      ),

                      SizedBox(height: 28.h),
                      CommonText.bold(
                        'Welcome Back!',
                        size: 26.sp,
                        color: context.colorScheme.onSurface,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 30.h),

                      SizedBox(
                        width: double.infinity,
                        height: 56.h,
                        child: OutlinedButton(
                          onPressed: () {
                            // Google authentication later
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: context.colorScheme.surface,
                            side: BorderSide(
                              color: context.colorScheme.outlineVariant,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 8.w),

                              Image.asset(
                                'assets/images/google_icon.png',
                                width: 22.w,
                                height: 22.w,
                              ),

                              Expanded(
                                child: Center(
                                  child: CommonText.medium(
                                    'CONTINUE WITH GOOGLE',
                                    size: 13.sp,
                                    color: context.colorScheme.onSurface,
                                  ),
                                ),
                              ),

                              SizedBox(width: 30.w),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 32.h),
                      CommonText.semiBold(
                        'OR LOG IN WITH EMAIL',
                        size: 13.sp,
                        color: context.colorScheme.onSurfaceVariant,
                        textAlign: TextAlign.center,
                        letterSpacing: 0.3,
                      ),

                      SizedBox(height: 30.h),
                      CommonTextField(
                        controller: controller.loginEmailController,
                        focus: controller.loginEmailFocus,
                        hintText: 'Email address',
                        keyboardType: TextInputType.emailAddress,
                        inputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: 20.sp,
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                        bgColor: context.colorScheme.surfaceContainerHigh,
                        borderColor: Colors.transparent,
                        borderWidth: 0,
                        borderRadius: 14.r,
                        cursorColor: context.colorScheme.primary,
                        fieldSubmitted: (_) {
                          FocusScope.of(
                            context,
                          ).requestFocus(controller.loginPasswordFocus);
                        },
                        validator: Validators.email,
                      ),

                      SizedBox(height: 16.h),

                      Obx(
                        () => CommonTextField(
                          controller: controller.loginPasswordController,
                          focus: controller.loginPasswordFocus,
                          hintText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          inputAction: TextInputAction.done,
                          obscure: !controller.isLoginPasswordVisible.value,
                          obscuringCharacter: '•',
                          autofillHints: const [AutofillHints.password],
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.sp,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          suffixIcon: IconButton(
                            onPressed: controller.toggleLoginPasswordVisibility,
                            icon: Icon(
                              controller.isLoginPasswordVisible.value
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 21.sp,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          bgColor: context.colorScheme.surfaceContainerHigh,
                          borderColor: Colors.transparent,
                          borderWidth: 0,
                          borderRadius: 14.r,
                          cursorColor: context.colorScheme.primary,
                          fieldSubmitted: (_) {
                            controller.login();
                          },
                          validator: Validators.password,
                        ),
                      ),

                      SizedBox(height: 26.h),

                      Obx(
                        () => CommonButton(
                          text: 'LOG IN',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.login,
                        ),
                      ),

                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          // Forgot password later
                        },
                        child: CommonText.medium(
                          'Forgot Password?',
                          size: 13.sp,
                          color: context.colorScheme.onSurface,
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 80.h),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.register);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CommonText.medium(
                              'DON\'T HAVE AN ACCOUNT? ',
                              size: 13.sp,
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                            CommonText.semiBold(
                              'SIGN UP',
                              size: 13.sp,
                              color: context.colorScheme.primary,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
