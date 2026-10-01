import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:grain_machine_test/core/widgets/extensions.dart';

import '../../../core/widgets/common_text.dart';
import '../../../models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;

  const UserCard({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: context.colorScheme.outlineVariant,
          width: 0.6,
        ),
      ),
      child: Row(
        children: [
          _buildAvatar(context),

          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText.semiBold(
                  user.fullName,
                  size: 16.sp,
                  color: context.colorScheme.onSurface,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 6.h),

                CommonText.regular(
                  user.email,
                  size: 13.sp,
                  color: context.colorScheme.onSurfaceVariant,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: 8.w),

          Icon(
            Icons.chevron_right_rounded,
            size: 28.sp,
            color: context.colorScheme.primary.withValues(alpha: 0.65),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: user.avatar,
        width: 64.w,
        height: 64.w,
        fit: BoxFit.cover,
        placeholder: (context, url) {
          return _placeholder(context);
        },
        errorWidget: (context, url, error) {
          return _placeholder(context);
        },
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      color: context.colorScheme.primaryContainer,
      child: Icon(
        Icons.person,
        size: 30.sp,
        color: context.colorScheme.primary,
      ),
    );
  }
}
