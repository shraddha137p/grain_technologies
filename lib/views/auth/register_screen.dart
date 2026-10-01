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

class RegisterScreen extends GetView<AuthController> {
  const RegisterScreen({super.key});

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
              height: 250.h,
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
                  key: controller.registerFormKey,
                  child: Column(
                    children: [
                      CommonBackButton(
                        onTap: () {
                          Get.back();
                        },
                      ),

                      SizedBox(height: 28.h),

                      CommonText.bold(
                        'Create your account',
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
                            // Google Sign Up later
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
                        'OR SIGN UP WITH EMAIL',
                        size: 13.sp,
                        color: context.colorScheme.onSurfaceVariant,
                        textAlign: TextAlign.center,
                        letterSpacing: 0.3,
                      ),

                      SizedBox(height: 30.h),

                      CommonTextField(
                        controller: controller.nameController,
                        focus: controller.nameFocus,
                        hintText: 'Name',
                        keyboardType: TextInputType.name,
                        inputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.words,
                        autofillHints: const [AutofillHints.name],
                        prefixIcon: Icon(
                          Icons.person_outline,
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
                          ).requestFocus(controller.registerEmailFocus);
                        },
                        validator: Validators.name,
                      ),

                      SizedBox(height: 16.h),

                      CommonTextField(
                        controller: controller.registerEmailController,
                        focus: controller.registerEmailFocus,
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
                          ).requestFocus(controller.registerPasswordFocus);
                        },
                        validator: Validators.email,
                      ),

                      SizedBox(height: 16.h),

                      Obx(
                        () => CommonTextField(
                          controller: controller.registerPasswordController,
                          focus: controller.registerPasswordFocus,
                          hintText: 'Password',
                          keyboardType: TextInputType.visiblePassword,
                          inputAction: TextInputAction.done,
                          obscure: !controller.isRegisterPasswordVisible.value,
                          obscuringCharacter: '•',
                          autofillHints: const [AutofillHints.newPassword],
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 20.sp,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          suffixIcon: IconButton(
                            onPressed:
                                controller.toggleRegisterPasswordVisibility,
                            icon: Icon(
                              controller.isRegisterPasswordVisible.value
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
                            controller.register();
                          },
                          validator: Validators.password,
                        ),
                      ),

                      SizedBox(height: 18.h),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.togglePrivacyAccepted();
                              },
                              child: Row(
                                children: [
                                  CommonText.regular(
                                    'I have read the ',
                                    size: 12.sp,
                                    color: context.colorScheme.onSurfaceVariant,
                                  ),
                                  CommonText.medium(
                                    'Privacy Policy',
                                    size: 12.sp,
                                    color: context.colorScheme.primary,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(
                            width: 24.w,
                            height: 24.w,
                            child: Obx(
                              () => Checkbox(
                                value: controller.isPrivacyAccepted.value,
                                onChanged: (value) {
                                  controller.setPrivacyAccepted(value ?? false);
                                },
                                activeColor: context.colorScheme.primary,
                                checkColor: context.colorScheme.onPrimary,
                                side: BorderSide(
                                  color: context.colorScheme.outline,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 22.h),

                      Obx(
                        () => CommonButton(
                          text: 'GET STARTED',
                          isLoading: controller.isLoading.value,
                          onPressed: controller.register,
                        ),
                      ),

                      SizedBox(height: 30.h),

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
