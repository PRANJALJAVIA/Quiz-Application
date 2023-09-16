import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screen/SignUp.dart';
import 'package:quickalert/quickalert.dart';

import 'Home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void errorAlert() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Invalid credentials',
    );
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

                Text('Login', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),),

                SizedBox(height: 24.0,),

                Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                            hintText: 'Enter your password',
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
                            else{
                              return null;
                            }
                          },
                        ),

                        SizedBox(height: 30,),

                        ElevatedButton(onPressed: (){

                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              // _register();
                              FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value) {
                                print("Logged In");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
                              }).onError((error, stackTrace) {
                                errorAlert();
                              });
                            }
                          });

                        }, child: Text('Login')),

                        SizedBox(height: 30,),

                        ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        }, child: Text("New User than Sign up, ", style: TextStyle(
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


