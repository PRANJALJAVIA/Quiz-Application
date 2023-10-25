import 'package:firebase_auth/firebase_auth.dart';
import 'package:quiz_app/models/user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  // User _userFromFirebaseUser(String userID) {
  //
  //   if (userID != null) {
  //     User obj = new User(uid: userID);
  //     return obj;
  //   } else {
  //     return null;
  //   }
  // }


  Future signUpWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      String userID = userCredential.user!.uid;
      // return _userFromFirebaseUser(userID);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Logout() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e);
      return null;
    }
  }
}
