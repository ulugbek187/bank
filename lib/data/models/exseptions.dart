class LoginInWithEmailAndPasswordFailure implements Exception {
  LoginInWithEmailAndPasswordFailure([
    this.message = "An unknown exception occurred",
  ]);

  factory LoginInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return LoginInWithEmailAndPasswordFailure(
          "email is not valid",
        );
      case 'user-disabled':
        return LoginInWithEmailAndPasswordFailure(
          "this user has been disabled",
        );
      case 'user-not-found':
        return LoginInWithEmailAndPasswordFailure(
          "email is not found",
        );

      case 'wrong-password':
        return LoginInWithEmailAndPasswordFailure(
          "incorrect password",
        );

      case 'invalid-credential':
        return LoginInWithEmailAndPasswordFailure(
          "user not found",
        );

      default:
        return LoginInWithEmailAndPasswordFailure(code);
    }
  }

  final String message;
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  SignUpWithEmailAndPasswordFailure([
    this.message = "An unknown exception occurred",
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
          "email is not valid",
        );
      case 'user-disabled':
        return SignUpWithEmailAndPasswordFailure(
          "this user has been disabled",
        );
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          "an account already exists for that email..",
        );

      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
          "operation is not allowed",
        );

      case 'week-password':
        return SignUpWithEmailAndPasswordFailure(
          "please enter a stronger password",
        );

      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LoginWithGoogleFailure implements Exception {
  LoginWithGoogleFailure([
    this.message = "An unknown exception occurred",
  ]);

  factory LoginWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return LoginWithGoogleFailure(
          "Account exists with different credential",
        );
      case 'invalid-credential':
        return LoginWithGoogleFailure(
          "the credential received is malformed or has expired",
        );

      default:
        return LoginWithGoogleFailure();
    }
  }

  final String message;
}
