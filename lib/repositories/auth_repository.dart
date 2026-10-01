import 'package:firebase_auth/firebase_auth.dart';
import 'package:grain_machine_test/services/firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepository(this._firebaseAuthService);

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await _firebaseAuthService.login(email: email, password: password);
  }

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _firebaseAuthService.register(
      email: email,
      password: password,
      name: name,
    );
  }

  Future<void> logout() async {
    await _firebaseAuthService.logout();
  }

  User? get currentUser => _firebaseAuthService.currentUser;

  bool get isLoggedIn => _firebaseAuthService.isLoggedIn;

  String? get userName => _firebaseAuthService.userName;

  String? get userEmail => _firebaseAuthService.userEmail;

  String? get userId => _firebaseAuthService.userId;
}
