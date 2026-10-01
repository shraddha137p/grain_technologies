import 'package:get/get.dart';
import 'package:grain_machine_test/views/auth/auth_binding.dart';
import 'package:grain_machine_test/views/auth/welcome_screen.dart';
import 'package:grain_machine_test/views/users/user_binding.dart';

import '../../views/auth/login_screen.dart';
import '../../views/auth/register_screen.dart';
import '../../views/users/user_list_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(name: AppRoutes.welcome, page: () => const WelcomeScreen()),

    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: AppRoutes.users,
      page: () => const UserListScreen(),
      binding: UserBinding(),
    ),
  ];
}
