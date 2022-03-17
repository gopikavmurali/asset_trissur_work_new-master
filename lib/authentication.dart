
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;

//SIGN UP METHOD
//   Future<String?> signUp({required String email, required String password}) async {
//     try {
//       await auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return null;
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

  //SIGN IN METHODJ
  Future<String?> signIn({required String email, required String password, required String privi,}) async {

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password, );
      return null;
    } on
    FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future<void> signOut() async {
    await auth.signOut();

    print('signout');
  }
}
