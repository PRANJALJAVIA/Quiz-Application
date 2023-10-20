import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/screen/play_quiz.dart';
import 'package:quiz_app/services/databaseService.dart';
import '../widget/widget.dart';
import 'SignUp.dart';
import 'create_quize.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream = Stream.empty();
  DatabaseService databaseService = new DatabaseService();

  Widget quizList() {
    return Container(
      child: Column(
        children: [
          StreamBuilder(
            stream: quizStream,
            builder: (context, snapshot) {
              return snapshot.data == null
                  ? Container()
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return QuizTile(
                      noOfQuestions: snapshot.data.docs.length,
                      title: snapshot.data.docs[index].get("quizTitle"),
                      description: snapshot.data.docs[index].get("quizDescription"),
                      id: snapshot.data.docs[index].get("quizId"),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      quizStream = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: AppLogo()),
      ),

      // body: Column(
      //   children: [
      //     Text("Hello, "),
      //     SizedBox(height: 30,),
      //     ElevatedButton(onPressed: (){
      //       FirebaseAuth.instance.signOut().then((value) {
      //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
      //       });
      //     }, child: Text("Logout"))
      //   ],
      // ),

      body: SingleChildScrollView(
          child: quizList()
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {
  final String title, id, description;
  final int noOfQuestions;

  QuizTile(
      {required this.title,
        required this.description,
        required this.id,
        required this.noOfQuestions});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => PlayQuiz(id)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        margin: EdgeInsets.only(bottom: 15),
        height: 150,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.lightBlue,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    description,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
