// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class fireDb{
//   FirebaseAuth auth = FirebaseAuth.instance;
//   createNewUser(String name, String email, int score) async{
//     final User? current_user = auth.currentUser;
//
//     if(current_user != null){
//       await FirebaseFirestore.instance.collection("users").doc(current_user.uid).set(
//           {
//             "email" : current_user.email,
//             "name" : name,
//             "score" : score,
//           }).then((value) => print("data added successfully"));
//     }
//   }
// }