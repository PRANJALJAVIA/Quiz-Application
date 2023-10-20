import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:quiz_app/helper/constants.dart';
import 'package:quiz_app/services/databaseService.dart';
import 'Home.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/services/auth.dart';
// import 'package:quiz_app/services/firedb.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DatabaseService databaseService = new DatabaseService();
  AuthService authService = new AuthService();

  String email = "";
  String password = "";
  String name = "";
  bool _loading = false;

  // Future<void> _register() async {
  //   try {
  //     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
  //     String userId = userCredential.user!.uid;
  //
  //     print("******************************************");
  //     print(userId);
  //     print("*******************************************");
  //
  //     // Create a reference to the user node in the database
  //     // DatabaseReference userRef = databaseReference.child('users');
  //
  //
  //     // print("******************************************");
  //     // print(userRef);
  //     // print("*******************************************");
  //
  //
  //     // Set the user data
  //     // await userRef.set({
  //     //   'username': _userNameController.text,
  //     //   'useremail': _emailController.text,
  //     //   // 'password': _passwordController.text,
  //     //   'score': 0
  //     // });
  //
  //     // print("User registered: ${userCredential.user!.email}");
  //
  //     // await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
  //
  //     // String userId = FirebaseAuth.instance.currentUser!.uid;
  //
  //     // DatabaseReference userRef = databaseReference.child('users').child(userId);
  //     //
  //     // await userRef.set({
  //     //   'username': _userNameController.text,
  //     //   'useremail': _emailController.text,
  //     //   'score': 0, // Initialize score to 0
  //     // });
  //
  //
  //
  //     print("User registered: ${FirebaseAuth.instance.currentUser!.email}");
  //     print("Navigating to Home page");
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
  //
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'weak-password') {
  //       print('The password provided is too weak.');
  //     } else if (e.code == 'email-already-in-use') {
  //       print('The account already exists for that email.');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  getInfoAndSignUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });
      email = _emailController.text;
      password = _passwordController.text;
      name = _userNameController.text;


      await authService
          .signUpWithEmailAndPassword(email, password)
          .then((value) {
        Map<String, String> userInfo = {
          "userName": name,
          "email": email,
        };

        // databaseService.addData(userInfo);

        Constants.saveUserLoggedInSharedPreference(true);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/quiz.png', width: 200, height: 200,),

                SizedBox(height: 24.0,),

                Text('Welcome to quiz app', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),),

                SizedBox(height: 24.0,),

                Text('Sign Up', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),),

                SizedBox(height: 24.0,),

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter username',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                  width: 2,
                                )
                            ),
                            prefixIcon: Icon(Icons.account_circle_outlined),
                          ),
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Please enter your email';
                            }
                            else{
                              return null;
                            }
                          },
                        ),

                        SizedBox(height: 30,),

                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                  width: 2,
                                )
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Please enter your email';
                            }
                            else{
                              return null;
                            }
                          },
                        ),

                        SizedBox(height: 30,),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                )
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.deepPurple,
                                  width: 2,
                                )
                            ),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          validator: (String? value){
                            if(value == null || value.isEmpty){
                              return 'Please enter new password';
                            }
                            else if(value.length < 6){
                              return 'password size should minimum 6 charactor';
                            }
                            else{
                              return null;
                            }
                          },
                        ),

                        SizedBox(height: 30,),

                        ElevatedButton(onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            getInfoAndSignUp();
                            // _register();
                            // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                            //   print("User created");
                            //   // createNewUser(_emailController.text, _userNameController.text);
                            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                            // });
                          }
                        }, child: Text('Sign Up')),

                        SizedBox(height: 30,),

                        ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        }, child: Text("Already have an account, than Login", style: TextStyle(
                          color: Colors.blue, // You can customize the color
                          decoration: TextDecoration.underline,
                        ),))
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}
