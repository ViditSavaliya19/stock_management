import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';

class AuthHelper {
  static AuthHelper helper = AuthHelper._();

  AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool?> signInEmailPassword(email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      // Login successful, navigate to the next screen
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('No user found for that email.', 'Auth Error');
        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Wrong password provided.', 'Auth Error');
        return false;
      }
    }
    return null;
  }

  void singOut() {
    auth.signOut();
  }

  bool currentUser()
  {
    User? user = auth.currentUser;
    return user!=null;
  }




}
