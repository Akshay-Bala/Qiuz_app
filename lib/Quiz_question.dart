import 'package:flutter/material.dart';
import 'package:quizapp/dashboard.dart';

import 'dart:async';

import 'package:quizapp/database.dart';

class Quizscreen extends StatefulWidget {
  @override
  _QuizscreenState createState() => _QuizscreenState();
}

class _QuizscreenState extends State<Quizscreen> {
  List<Map<String, dynamic>> questions = [];
  bool isLoading = true;
  int currentQuestionIndex = 0;
  int timerDuration = 30;
  Timer? _timer;
  int remainingTime = 30;

  int answered = 0;
  int unanswered = 0;
  int? selectedOptionIndex;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questionList = await DatabaseHelper.instance.fetchQuestions();
    setState(() {
      questions = questionList;
      unanswered = questions.length;
      isLoading = false;
    });
    if (questions.isNotEmpty) _startTimer();
  }

  void _startTimer() {
    setState(() {
      remainingTime = timerDuration;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        _markUnansweredAndMoveNext();
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _markUnansweredAndMoveNext() {
    _stopTimer();
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        _startTimer();
      } else {
        _showQuizEndDialog();
      }
    });
  }

  void _answerQuestion(int selectedIndex) {
    _stopTimer();
    setState(() {
      answered++;
      if (unanswered > 0) unanswered--;
      selectedOptionIndex = selectedIndex;

      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        _startTimer();
      } else {
        _showQuizEndDialog();
      }
    });
  }

  void _showQuizEndDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Quiz Completed"),
        content: Text("You have completed the quiz."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => DashboardScreen(
                    totalQuestions: questions.length,
                    answered: answered,
                    unanswered: unanswered,
                  ),
                ),
              );
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios_outlined),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.menu),
        ),
        body: Center(child: Text("No questions available")),
      );
    }

    final currentQuestion = questions[currentQuestionIndex];
    final options = currentQuestion['options'].toString().split(',');

    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Time remaining: $remainingTime seconds",
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            SizedBox(height: 20),
            Text(
              currentQuestion['questionText'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Column(
              children: options.asMap().entries.map((entry) {
                int index = entry.key;
                String option = entry.value;

                bool isSelected = selectedOptionIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOptionIndex = index;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.green: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected
                          ? Colors.green
                          : Colors.transparent,
                    ),
                    child: Text(
                      option,
                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              }).toList(),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(),
                onPressed: () {
                  if (selectedOptionIndex != null) {
                    _answerQuestion(selectedOptionIndex!);
                  }
                },
                child: Text("Next",style: TextStyle(color: Colors.black,fontSize: 20),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
