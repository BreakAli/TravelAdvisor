import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  String errorMessage;

  // depending on if signed in or signed out, returns user or null
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // Could add error messages if wrong inputs for fields
  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      return e.message;
    }
  }

  Future<String> signUp({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
      return e.message;
    }
  }

  String validateEmail(String value) {
    if (value.isEmpty) {
      return "Email can't be empty";
    } else if (errorMessage != null) {
      // Error caught, so return error message to validator
      String tmp = errorMessage;
      errorMessage = null;
      return tmp;
    }
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Password can't be empty";
    } else if (errorMessage != null) {
      // Error caught, so return error message to validator
      String tmp = errorMessage;
      errorMessage = null;
      return tmp;
    }
    return null;
  }
}

// class EmailValidator {
//   static String validate(String value) {
//     if (value.isEmpty) {
//       return "Email can't be empty";
//     } else if (errorMessage != null) {
//       // Error caught, so return error message to validator
//       String tmp = errorMessage;
//       errorMessage = null;
//       return tmp;
//     }
//     return null;
//   }
// }

// bad log in -> errorMessage is nulled -> returns tmpString -> not valid
// good log in -> returns null -> displays previous error
// good log in p2 -> returns null -> valid

// class PasswordValidator {
//   static String validate(String value) {
//     if (value.isEmpty) {
//       return "Password can't be empty";
//     } else if (errorMessage != null) {
//       String tmp = errorMessage;
//       errorMessage = null;
//       return tmp;
//     }
//     return null;
//   }
// }
