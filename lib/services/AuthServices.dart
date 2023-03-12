import 'package:campino/models/Users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userCollection = FirebaseFirestore.instance.collection('users');

  Future<bool> signIn(String emailController, String passwordController) async {
    try {
      await auth.signInWithEmailAndPassword(email: emailController, password: passwordController);
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e.message);
      return false;
    }
  }

  Future<bool> signUp(String emailController, String passwordController, String Name, String urlController, String Role,
      String GsmController) async {
    try {
      await auth.createUserWithEmailAndPassword(email: emailController, password: passwordController);

      await saveUser(Cusers(
          uid: user!.uid,
          userName: Name,
          Email: emailController,
          Role: Role,
          Url: urlController,
          basket: [],
          Gsm: GsmController));
      print("done");
      return true;
    } on FirebaseException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> resetPassword(String emailController) async {
    try {
      await auth.sendPasswordResetEmail(email: emailController);
      return true;
    } on FirebaseException catch (e) {
      return false;
    }
  }

  User? get user => auth.currentUser; //pour recuperer l'utilisateur courant

  saveUser(Cusers user) async {
    try {
      await userCollection.doc(user.uid).set(user.Tojson());
      await userCollection.doc(user.uid).update({"income": 0, "expenses": 0});
    } catch (e) {}
  }
}
