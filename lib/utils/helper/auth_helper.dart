import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/route_manager.dart';
import 'package:srock_management/model/user_model.dart';
import 'package:srock_management/utils/helper/firedb_helper.dart';


class AuthHelper {
  static AuthHelper helper = AuthHelper._();
  AuthHelper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;


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

  void signOut() {
    auth.signOut();
  }

  bool currentUser() {
    user = auth.currentUser;

    print("${user?.displayName}");
    print("${user?.email}");

    return user != null;
  }

  Future<bool> createNewUserAsEmp({required UserModel model}) async {


    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: model.email!, password: model.password!);

      await FireDbHelper.helper.addNewAccessEmpData(
          name: model.name,
          email: model.email,
          password: model.password,
          department: model.department,
          mobile: model.mobile,
          uid: userCredential.user!.uid);


      //For reLogin as Admin
      signOut();
      await signInEmailPassword("Admin@gmail.com", "Admin@123");


      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('No user found for that email.', 'Auth Error');
        return false;
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Wrong password provided.', 'Auth Error');
        return false;
      } else {
        return false;
      }
    }
  }
}
