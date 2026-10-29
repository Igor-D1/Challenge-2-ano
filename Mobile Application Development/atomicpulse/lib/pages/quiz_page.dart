import 'package:flutter/material.dart';
import 'package:atomicpulse/models/quiz_model.dart';
import 'package:atomicpulse/repositories/quiz_repository.dart';
import 'package:atomicpulse/pages/quiz_play_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => QuizPageState();
}

class QuizPageState extends State<QuizPage> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final QuizRepository repository = QuizRepository();

  String difficulty = 'Médio';
  double questionCount = 10;
  bool isLoading = false;

  final TextEditingController importController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    importController.dispose();
    super.dispose();
  }

  void startAiQuiz() async {
    setState(() => isLoading = true);
    try {
      final quiz = await repository.generateAIQuiz(
        difficulty: difficulty,
        questionCount: questionCount.toInt(),
      );

      if (mounted) {
        setState(() => isLoading = false);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QuizPlayPage(quiz: quiz)),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: $e')),
        );
      }
    }
  }

  void importCustomQuiz(bool isJson) {
    final text = importController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cole o código do arquivo primeiro.')),
      );
      return;
    }

    try {
      QuizModel quiz = isJson
          ? repository.importQuizFromJson(text)
          : repository.importQuizFromTxt(text);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizPlayPage(quiz: quiz)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de importação: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central de Quiz'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              'assets/images/logo.jpeg',
              height: 62,
              width: 62,
            ),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(icon: Icon(Icons.psychology), text: 'Gerador IA'),
            Tab(icon: Icon(Icons.upload_file), text: 'Personalizado'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          buildAiTab(),
          buildCustomTab(),
        ],
      ),
    );
  }

  Widget buildAiTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Configurar Desafio por IA', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Text('Dificuldade:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Fácil', label: Text('Fácil')),
              ButtonSegment(value: 'Médio', label: Text('Médio')),
              ButtonSegment(value: 'Difícil', label: Text('Difícil')),
            ],
            selected: {difficulty},
            onSelectionChanged: (set) => setState(() => difficulty = set.first),
          ),
          const SizedBox(height: 24),
          Text('Quantidade de Questões: ${questionCount.toInt()}', style: const TextStyle(fontWeight: FontWeight.bold)),
          Slider(
            value: questionCount,
            min: 10,
            max: 40,
            divisions: 30,
            label: questionCount.toInt().toString(),
            onChanged: (v) => setState(() => questionCount = v),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : startAiQuiz,
              icon: const Icon(Icons.bolt),
              label: Text(isLoading ? 'Gerando...' : 'Iniciar Quiz IA'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCustomTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Importar Arquivo JSON ou TXT', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextField(
            controller: importController,
            maxLines: 8,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Cole o código JSON ou arquivo TXT aqui...',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => importCustomQuiz(true),
                  icon: const Icon(Icons.code),
                  label: const Text('Importar JSON'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => importCustomQuiz(false),
                  icon: const Icon(Icons.text_snippet),
                  label: const Text('Importar TXT'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
