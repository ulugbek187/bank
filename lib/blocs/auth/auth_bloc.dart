import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
// Future<void> signInWithGoogle(BuildContext context,
//     [String? clientId]) async {
//   _notify(true);
//
//   final GoogleSignInAccount? googleUser =
//   await GoogleSignIn(clientId: clientId).signIn();
//
//   final GoogleSignInAuthentication? googleAuth =
//   await googleUser?.authentication;
//
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );
//
//   UserCredential userCredential =
//   await FirebaseAuth.instance.signInWithCredential(credential);
//   _notify(false);
//   if (userCredential.user != null) {
//     Navigator.pushReplacementNamed(context, RouteNames.tabRoute);
//   }
// }
