import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get/get.dart';
import 'package:grain_machine_test/core/theme/app_theme.dart';
import 'package:grain_machine_test/firebase_options.dart';

import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final user = await FirebaseAuth.instance.authStateChanges().first;
  runApp(
    MyApp(
      initialRoute: user == null ? AppRoutes.welcome : AppRoutes.users,
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, this.initialRoute = AppRoutes.welcome});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(360, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Grin Machine Test',
          theme: AppTheme.lightTheme,
          initialRoute: initialRoute,
          getPages: AppPages.pages,
        );
      },
    );
  }
}
