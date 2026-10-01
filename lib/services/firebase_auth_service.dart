import 'package:firebase_auth/firebase_auth.dart';
import 'package:grain_machine_test/core/widgets/app_logger.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ============================================================
  // REGISTER
  // ============================================================

  Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    AppLogger.separator();

    AppLogger.info('REGISTER REQUEST');

    AppLogger.debug('Name: $name');
    AppLogger.debug('Email: $email');

    try {
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      AppLogger.info('FIREBASE ACCOUNT CREATED');

      await credential.user?.updateDisplayName(name);

      await credential.user?.reload();

      final User? user = _auth.currentUser;

      AppLogger.info('REGISTER SUCCESS');

      AppLogger.debug('UID: ${user?.uid}');

      AppLogger.debug('Name: ${user?.displayName}');

      AppLogger.debug('Email: ${user?.email}');

      AppLogger.separator();

      return credential;
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('REGISTER FAILED', e, stackTrace);

      AppLogger.debug('Firebase Error Code: ${e.code}');

      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('REGISTER ERROR', e, stackTrace);

      rethrow;
    }
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    AppLogger.separator();

    AppLogger.info('LOGIN REQUEST');

    AppLogger.debug('Email: $email');

    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      AppLogger.info('LOGIN SUCCESS');

      AppLogger.debug('UID: ${credential.user?.uid}');

      AppLogger.debug('Email: ${credential.user?.email}');

      AppLogger.debug('Name: ${credential.user?.displayName}');

      AppLogger.separator();

      return credential;
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('LOGIN FAILED', e, stackTrace);

      AppLogger.debug('Firebase Error Code: ${e.code}');

      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('LOGIN ERROR', e, stackTrace);

      rethrow;
    }
  }

  Future<void> logout() async {
    AppLogger.separator();

    AppLogger.info('LOGOUT REQUEST');

    try {
      await _auth.signOut();

      AppLogger.info('LOGOUT SUCCESS');

      AppLogger.separator();
    } catch (e, stackTrace) {
      AppLogger.error('LOGOUT FAILED', e, stackTrace);

      rethrow;
    }
  }

  User? get currentUser {
    return _auth.currentUser;
  }

  bool get isLoggedIn {
    return _auth.currentUser != null;
  }

  String? get userName {
    return _auth.currentUser?.displayName;
  }

  String? get userEmail {
    return _auth.currentUser?.email;
  }

  String? get userId {
    return _auth.currentUser?.uid;
  }

  Future<String?> getIdToken() async {
    try {
      final User? user = _auth.currentUser;

      if (user == null) {
        AppLogger.warning('Cannot get ID token. User is not logged in.');

        return null;
      }

      final String? token = await user.getIdToken();

      AppLogger.debug('Firebase ID Token generated');

      return token;
    } catch (e, stackTrace) {
      AppLogger.error('GET ID TOKEN FAILED', e, stackTrace);

      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    AppLogger.separator();

    AppLogger.info('PASSWORD RESET REQUEST');
    AppLogger.debug('Email: $email');

    try {
      await _auth.sendPasswordResetEmail(email: email);

      AppLogger.info('PASSWORD RESET EMAIL SENT');

      AppLogger.separator();
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('PASSWORD RESET FAILED', e, stackTrace);

      AppLogger.debug('Firebase Error Code: ${e.code}');

      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('PASSWORD RESET ERROR', e, stackTrace);

      rethrow;
    }
  }

  Future<User?> refreshUser() async {
    try {
      await _auth.currentUser?.reload();

      AppLogger.debug('Firebase user refreshed');

      return _auth.currentUser;
    } catch (e, stackTrace) {
      AppLogger.error('REFRESH USER FAILED', e, stackTrace);

      rethrow;
    }
  }
}
