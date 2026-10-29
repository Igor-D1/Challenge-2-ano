class QuestionModel {
  final String id;
  final String question;
  final List<String> options;
  final int correctIndex;
  bool isReported;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
    this.isReported = false,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctIndex: json['correctIndex'] ?? 0,
    );
  }
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;

  QuizModel({
    required this.title,
    required this.questions,
  });
}

