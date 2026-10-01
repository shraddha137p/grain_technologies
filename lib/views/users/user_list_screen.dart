import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:grain_machine_test/core/widgets/extensions.dart';

import '../../core/widgets/common_text.dart';
import '../../viewmodels/auth_controller.dart';
import '../../viewmodels/user_controller.dart';
import 'widgets/user_card.dart';
import 'widgets/user_list_header.dart';
import 'widgets/user_list_loader.dart';

class UserListScreen extends GetView<UserController> {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              child: UserListHeader(
                onLogoutTap: () {
                  _showLogoutDialog(context);
                },
              ),
            ),

            SizedBox(height: 22.h),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.users.isEmpty) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: context.colorScheme.primary,
                    ),
                  );
                }

                if (controller.errorMessage.value.isNotEmpty &&
                    controller.users.isEmpty) {
                  return _errorView(context);
                }

                if (controller.users.isEmpty) {
                  return Center(
                    child: CommonText.medium(
                      'No users found',
                      size: 16.sp,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  );
                }

                return RefreshIndicator(
                  color: context.colorScheme.primary,
                  onRefresh: controller.refreshUsers,
                  child: NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      if (notification.direction == ScrollDirection.reverse &&
                          notification.metrics.maxScrollExtent <= 0 &&
                          controller.hasMorePages &&
                          !controller.isLoading.value &&
                          !controller.isLoadingMore.value) {
                        controller.loadNextPage();
                      }

                      return false;
                    },
                    child: ListView.builder(
                      controller: controller.scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 4.h,
                      ),
                      itemCount:
                          controller.users.length +
                          (controller.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.users.length) {
                          return const UserListLoader();
                        }

                        final user = controller.users[index];

                        return UserCard(user: user);
                      },
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _errorView(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 48.sp,
            color: context.colorScheme.error,
          ),

          SizedBox(height: 12.h),

          CommonText.semiBold(
            'Something went wrong',
            size: 16.sp,
            color: context.colorScheme.onSurface,
          ),

          SizedBox(height: 16.h),

          ElevatedButton(
            onPressed: controller.refreshUsers,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: context.colorScheme.surface,
        title: CommonText.semiBold(
          'Logout',
          size: 18.sp,
          color: context.colorScheme.onSurface,
        ),
        content: CommonText.regular(
          'Are you sure you want to logout?',
          size: 14.sp,
          color: context.colorScheme.onSurfaceVariant,
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: CommonText.medium(
              'CANCEL',
              size: 13.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.find<AuthController>().logout();
            },
            child: CommonText.semiBold(
              'LOGOUT',
              size: 13.sp,
              color: context.colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }
}
