import 'package:flutter/material.dart';
import 'package:quiz_app/widget/widget.dart';

import '../services/databaseService.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _formKey = GlobalKey<FormState>();
  DatabaseService databaseService = new DatabaseService();

  String question = "";
  String option1 = "";
  String option2 = "";
  String option3 = "";
  String option4 = "";

  bool _isLoading = false;

  uploadQuestionData() async{

    if (_formKey.currentState!.validate()) {

      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionMap = {
        "question": question,
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4
      };

      print("${widget.quizId}");

      await databaseService.addQuestionData(questionMap, widget.quizId).then((value) {
        question = "";
        option1 = "";
        option2 = "";
        option3 = "";
        option4 = "";
        setState(() {
          _isLoading = false;
        });

      }).catchError((error){
        print(error);
      });

    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLogo(),
      ),
      body: _isLoading ? Container(child: Center(child: CircularProgressIndicator(),),) : Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 5),
          margin: EdgeInsets.only(top: 40, left: 30, right:30),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Question",
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
                    return 'Please enter question';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  question = val;
                },
              ),

              SizedBox(height: 30,),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "option1(Correct answer)",
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
                    return 'Please enter option1';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  option1 = val;
                },
              ),

              SizedBox(height: 30,),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "option2",
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
                    return 'Please enter option2';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  option2 = val;
                },
              ),

              SizedBox(height: 30,),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "option3",
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
                    return 'Please enter option3';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  option3 = val;
                },
              ),

              SizedBox(height: 30,),

              TextFormField(
                decoration: InputDecoration(
                  hintText: "option4",
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
                    return 'Please enter option4';
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                  option4 = val;
                },
              ),

              Spacer(),

              Center(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Submit",
                          style:
                          TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    GestureDetector(
                      onTap: () {
                        uploadQuestionData();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30)),
                        child: Text(
                          "Add Question",
                          style:
                          TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50,)

            ],
          ),
        ),
      ),
    );
  }
}
