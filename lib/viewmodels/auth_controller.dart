import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grain_machine_test/core/routes/app_routes.dart';
import 'package:grain_machine_test/core/widgets/app_snackbar.dart';
import 'package:grain_machine_test/repositories/auth_repository.dart';
import 'package:grain_machine_test/services/firebase_auth_service.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository(FirebaseAuthService());

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  final TextEditingController loginEmailController = TextEditingController();

  final TextEditingController loginPasswordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController registerEmailController = TextEditingController();

  final TextEditingController registerPasswordController =
      TextEditingController();

  final FocusNode loginEmailFocus = FocusNode();

  final FocusNode loginPasswordFocus = FocusNode();

  final FocusNode nameFocus = FocusNode();

  final FocusNode registerEmailFocus = FocusNode();

  final FocusNode registerPasswordFocus = FocusNode();

  final RxBool isLoading = false.obs;

  final RxBool isLoginPasswordVisible = false.obs;

  final RxBool isRegisterPasswordVisible = false.obs;

  final RxBool isPrivacyAccepted = false.obs;

  Future<void> login() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    final String email = loginEmailController.text.trim();

    final String password = loginPasswordController.text.trim();

    try {
      isLoading.value = true;

      await _authRepository.login(email: email, password: password);

      AppSnackbar.success('Success', 'Login successful');

      Get.offAllNamed(AppRoutes.users);
      loginEmailController.clear();
      loginPasswordController.clear();
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      AppSnackbar.error('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    final String name = nameController.text.trim();

    final String email = registerEmailController.text.trim();

    final String password = registerPasswordController.text.trim();

    try {
      isLoading.value = true;

      await _authRepository.register(
        name: name,
        email: email,
        password: password,
      );

      AppSnackbar.success('Success', 'Account created successfully');

      Get.offAllNamed(AppRoutes.users);
      registerEmailController.clear();
      registerPasswordController.clear();
      nameController.clear();
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      AppSnackbar.error('Error', 'Something went wrong. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  void toggleLoginPasswordVisibility() {
    isLoginPasswordVisible.value = !isLoginPasswordVisible.value;
  }

  void toggleRegisterPasswordVisibility() {
    isRegisterPasswordVisible.value = !isRegisterPasswordVisible.value;
  }

  void togglePrivacyAccepted() {
    isPrivacyAccepted.value = !isPrivacyAccepted.value;
  }

  void setPrivacyAccepted(bool value) {
    isPrivacyAccepted.value = value;
  }

  void _handleAuthError(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      // Login errors
      case 'invalid-credential':
        message = 'Invalid email or password.';
        break;

      case 'user-not-found':
        message = 'No account found with this email.';
        break;

      case 'wrong-password':
        message = 'Incorrect password.';
        break;

      // Common errors
      case 'invalid-email':
        message = 'Please enter a valid email.';
        break;

      case 'user-disabled':
        message = 'This account has been disabled.';
        break;

      // Register errors
      case 'email-already-in-use':
        message = 'An account already exists with this email.';
        break;

      case 'weak-password':
        message = 'Password is too weak.';
        break;

      case 'operation-not-allowed':
        message = 'Email/password authentication is not enabled.';
        break;

      // Network
      case 'network-request-failed':
        message = 'Please check your internet connection.';
        break;

      case 'too-many-requests':
        message = 'Too many attempts. Please try again later.';
        break;

      default:
        message = e.message ?? 'Authentication failed.';
    }

    AppSnackbar.error('Authentication Error', message);
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();

      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppSnackbar.error('Error', 'Unable to logout. Please try again.');
    }
  }

  User? get currentUser {
    return _authRepository.currentUser;
  }

  bool get isLoggedIn {
    return _authRepository.isLoggedIn;
  }

  @override
  void onClose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();

    nameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();

    loginEmailFocus.dispose();
    loginPasswordFocus.dispose();

    nameFocus.dispose();
    registerEmailFocus.dispose();
    registerPasswordFocus.dispose();

    super.onClose();
  }
}
