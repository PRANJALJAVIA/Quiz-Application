import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  final int correct, incorrect, total, not_attempted;

  Result({required this.correct, required this.incorrect, required this.total, required this.not_attempted});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 270,),

            Text("Result", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),

            SizedBox(height: 20,),

            Text("Total questions: ${widget.total}", style: TextStyle(fontSize: 25),),

            SizedBox(height: 10,),

            Text("Correct: ${widget.correct}", style: TextStyle(fontSize: 25),),

            SizedBox(height: 10,),

            Text("Incorrect: ${widget.incorrect}", style: TextStyle(fontSize: 25),),

            SizedBox(height: 10,),

            Text("Not Attemted: ${widget.not_attempted}", style: TextStyle(fontSize: 25),),

            Spacer(),

            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.symmetric(
                    horizontal: 24, vertical: 20),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  "Home",
                  style: TextStyle(
                      fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
