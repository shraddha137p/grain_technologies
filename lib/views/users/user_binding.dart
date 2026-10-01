import 'package:get/get.dart';
import 'package:grain_machine_test/viewmodels/auth_controller.dart';

import '../../repositories/user_repository.dart';
import '../../services/api_service.dart';
import '../../viewmodels/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiService>(() => ApiService());

    Get.lazyPut<UserRepository>(
      () => UserRepository(apiService: Get.find<ApiService>()),
    );

    Get.lazyPut<UserController>(
      () => UserController(repository: Get.find<UserRepository>()),
    );

    Get.lazyPut<AuthController>(() => AuthController());
  }
}
