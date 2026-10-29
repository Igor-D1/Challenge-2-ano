import 'dart:async';
import 'package:flutter/material.dart';
import 'package:atomicpulse/models/quiz_model.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class QuizPlayPage extends StatefulWidget {
  final QuizModel quiz;

  const QuizPlayPage({super.key, required this.quiz});

  @override
  State<QuizPlayPage> createState() => QuizPlayPageState();
}

class QuizPlayPageState extends State<QuizPlayPage> {
  int currentIndex = 0;
  int score = 0;
  int timerSeconds = 30;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer?.cancel();
    setState(() => timerSeconds = 30);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (timerSeconds > 0) {
        setState(() => timerSeconds--);
      } else {
        nextQuestion();
      }
    });
  }

  void answerQuestion(int selectedIndex) {
    final currentQ = widget.quiz.questions[currentIndex];
    if (selectedIndex == currentQ.correctIndex && !currentQ.isReported) {
      score += 10;
    }
    nextQuestion();
  }

  void reportQuestion() {
    setState(() {
      widget.quiz.questions[currentIndex].isReported = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Questão reportada ao criador! Pontuação anulada.')),
    );
  }

  void nextQuestion() {
    if (currentIndex < widget.quiz.questions.length - 1) {
      setState(() => currentIndex++);
      startTimer();
    } else {
      timer?.cancel();
      showResultDialog();
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceBlue,
        title: const Text('Partida Concluída!'),
        content: Text('Sua pontuação final foi: $score pontos.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Sair'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.quiz.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quiz.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.report_problem, color: Colors.amber),
            onPressed: reportQuestion,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Questão ${currentIndex + 1}/${widget.quiz.questions.length}'),
                Text('Tempo: $timerSeconds s', style: const TextStyle(color: AppTheme.cyanAccent, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            Text(q.question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...List.generate(q.options.length, (index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => answerQuestion(index),
                  child: Text(q.options[index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

