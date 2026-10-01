import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grain_machine_test/core/widgets/app_snackbar.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepository repository;

  UserController({required this.repository});

  final RxList<UserModel> users = <UserModel>[].obs;

  final ScrollController scrollController = ScrollController();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  final RxString errorMessage = ''.obs;

  int currentPage = 1;

  final int perPage = 5;

  int totalPages = 1;

  bool get hasMorePages => currentPage < totalPages;

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(_onScroll);

    fetchUsers();
  }

  void _onScroll() {
    if (!scrollController.hasClients ||
        isLoading.value ||
        isLoadingMore.value) {
      return;
    }

    final position = scrollController.position;

    if (position.pixels > 0 && position.extentAfter <= 200) {
      loadNextPage();
    }
  }

  Future<void> fetchUsers() async {
    if (isLoading.value || isLoadingMore.value) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await repository.getUsers(page: 1, perPage: perPage);

      users.assignAll(response.users);

      currentPage = response.page;
      totalPages = response.totalPages;
    } catch (e) {
      errorMessage.value = 'Unable to load users.';

    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadNextPage() async {
    if (isLoading.value || isLoadingMore.value) {
      return;
    }

    if (!hasMorePages) {
      return;
    }

    final int nextPage = currentPage + 1;

    try {
      isLoadingMore.value = true;
      final response = await repository.getUsers(
        page: nextPage,
        perPage: perPage,
      );

      if (response.users.isNotEmpty) {
        users.addAll(response.users);
      }

      currentPage = response.page;
      totalPages = response.totalPages;

    } catch (e) {
      AppSnackbar.error(
        'Error',
        'Unable to load more users.',
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }


  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();

    super.onClose();
  }
}
