import 'dart:convert';
import '../models/quiz_model.dart';

class QuizRepository {
  Future<QuizModel> generateAIQuiz({
    required String difficulty,
    required int questionCount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    List<QuestionModel> questions = List.generate(
      questionCount,
      (i) => QuestionModel(
        id: 'q_ai_${i + 1}',
        question: 'Questão ${i + 1} ($difficulty): Qual a função do Reator Multipropósito Brasileiro (RMB)?',
        options: [
          'Produção de radiofármacos para a saúde e medicina nuclear',
          'Geração comercial de energia elétrica em larga escala',
          'Fabricação de baterias portáteis para smartphones',
          'Extração de combustíveis fósseis em águas profundas',
        ],
        correctIndex: 0,
      ),
    );

    return QuizModel(
      title: 'Quiz IA: Nível $difficulty ($questionCount Questões)',
      questions: questions,
    );
  }

  QuizModel importQuizFromJson(String jsonContent) {
    final Map<String, dynamic> data = jsonDecode(jsonContent);
    final String title = data['quizTitle'] ?? 'Quiz Importado (JSON)';
    final List<dynamic> qList = data['questions'] ?? [];

    List<QuestionModel> questions = qList.map((item) => QuestionModel.fromJson(item)).toList();
    return QuizModel(title: title, questions: questions);
  }

  QuizModel importQuizFromTxt(String txtContent) {
    List<QuestionModel> questions = [];
    List<String> lines = txtContent.split('\n');

    String currentQuestion = '';
    List<String> currentOptions = [];
    int correctIndex = 0;

    for (String line in lines) {
      line = line.trim();
      if (line.startsWith('Pergunta:')) {
        if (currentQuestion.isNotEmpty && currentOptions.length == 4) {
          questions.add(QuestionModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            question: currentQuestion,
            options: List.from(currentOptions),
            correctIndex: correctIndex,
          ));
          currentOptions.clear();
        }
        currentQuestion = line.replaceFirst('Pergunta:', '').trim();
      } else if (line.startsWith('A)') || line.startsWith('B)') || line.startsWith('C)') || line.startsWith('D)')) {
        currentOptions.add(line.substring(2).trim());
      } else if (line.startsWith('Correta:')) {
        correctIndex = int.tryParse(line.replaceFirst('Correta:', '').trim()) ?? 0;
      }
    }

    if (currentQuestion.isNotEmpty && currentOptions.length == 4) {
      questions.add(QuestionModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        question: currentQuestion,
        options: currentOptions,
        correctIndex: correctIndex,
      ));
    }

    return QuizModel(
      title: 'Quiz Importado (TXT)',
      questions: questions.isEmpty
          ? [
              QuestionModel(
                id: '1',
                question: 'Qual o pilar central da medicina nuclear?',
                options: ['Radiofármacos', 'Diesel', 'Petróleo', 'Energia Eólica'],
                correctIndex: 0,
              )
            ]
          : questions,
    );
  }
}
