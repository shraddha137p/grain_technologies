import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';

import 'package:grain_machine_test/core/widgets/extensions.dart';
import 'package:grain_machine_test/core/widgets/common_text.dart';
import 'package:grain_machine_test/viewmodels/auth_controller.dart';

class UserListHeader extends GetView<AuthController> {
  final VoidCallback? onLogoutTap;

  const UserListHeader({
    this.onLogoutTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = controller.currentUser;

    final String name = user?.displayName?.trim().isNotEmpty == true
        ? user!.displayName!.trim()
        : 'User';

    final String? photoUrl = user?.photoURL;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // CURRENT USER
        Row(
          children: [
            _UserAvatar(
              name: name,
              photoUrl: photoUrl,
            ),

            SizedBox(width: 12.w),

            CommonText.regular(
              'Hi, ',
              size: 17.sp,
              color: context.colorScheme.onSurfaceVariant,
            ),

            CommonText.bold(
              name,
              size: 17.sp,
              color: context.colorScheme.onSurface,
            ),
          ],
        ),

        // LOGOUT
        _CircleButton(
          icon: Icons.logout_rounded,
          onTap: onLogoutTap,
        ),
      ],
    );
  }
}
class _UserAvatar extends StatelessWidget {
  final String name;
  final String? photoUrl;

  const _UserAvatar({
    required this.name,
    this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    final String initials = _getInitials(name);

    return Container(
      width: 52.w,
      height: 52.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.primaryContainer,
      ),
      child: ClipOval(
        child: photoUrl != null && photoUrl!.isNotEmpty
            ? Image.network(
          photoUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return _InitialsAvatar(
              initials: initials,
            );
          },
        )
            : _InitialsAvatar(
          initials: initials,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final List<String> parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((element) => element.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return 'U';
    }

    if (parts.length == 1) {
      return parts.first[0].toUpperCase();
    }

    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }
}
class _InitialsAvatar extends StatelessWidget {
  final String initials;

  const _InitialsAvatar({
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CommonText.bold(
        initials,
        size: 17.sp,
        color: context.colorScheme.primary,
      ),
    );
  }
}
class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleButton({
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.surface,
          border: Border.all(
            color: context.colorScheme.outlineVariant,
          ),
        ),
        child: Icon(
          icon,
          size: 24.sp,
          color: context.colorScheme.onSurface,
        ),
      ),
    );
  }
}