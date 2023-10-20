import 'package:flutter/material.dart';
import 'package:quiz_app/services/databaseService.dart';
import 'package:random_string/random_string.dart';
import 'package:quiz_app/screen/addQuestion.dart ';

import '../widget/widget.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({Key? key}) : super(key: key);

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  String quizTitle ="";
  String quizDesc = "";
  String quizId = "";
  DatabaseService databaseService = new DatabaseService();

  bool _isLoading = false;

  creatQuizOnline() async{
    quizId = randomAlphaNumeric(16);

    if(_formKey.currentState!.validate()){

      setState(() {
        _isLoading = true;
      });

      Map<String, String> quizMap = {
        "quizTitle": quizTitle,
        "quizDescription": quizDesc,
        "quizId":quizId
      };

      await databaseService.addQuizData(quizMap, quizId).then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(context, MaterialPageRoute(
           builder: (context) =>  AddQuestion(quizId)
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black54,
        ),
        title: AppLogo(),
        // brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //brightness: Brightness.li,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),)
          : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(top: 80, left: 30, right:30),
          child: Column(
            children: [
              SizedBox(height: 5,),

              TextFormField(
                decoration: InputDecoration(
                    hintText: "Quiz Title",
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
                        color: Colors.blue,
                        width: 2,
                      )
                  ),
                ),
                validator: (String? value){
                  if(value == null || value.isEmpty){
                    return 'Please enter quiz title';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  quizTitle = val;
                },
              ),

              SizedBox(height: 30,),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "Quiz Description",
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
                        color: Colors.blue,
                        width: 2,
                      )
                  ),
                ),
                validator: (String? value){
                  if(value == null || value.isEmpty){
                    return 'Please enter quiz description';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  quizDesc = val;
                },
              ),

              Spacer(),

              GestureDetector(
                onTap: () {
                  creatQuizOnline();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Create Quiz",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),

              SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}
