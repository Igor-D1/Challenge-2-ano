import 'package:flutter/material.dart';
import 'package:atomicpulse/models/news_model.dart';
import 'package:atomicpulse/repositories/news_repository.dart';
import 'package:atomicpulse/widgets/news_header.dart';
import 'package:atomicpulse/widgets/news_card.dart';
import 'package:atomicpulse/widgets/faq_buttom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final NewsRepository newsRepository = NewsRepository();
  late Future<List<NewsModel>> newsFuture;

  @override
  void initState() {
    super.initState();
    newsFuture = newsRepository.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Notícias AtomicPulse'),
        centerTitle: true, // Garante que o texto fica no meio exato
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
      ),
      body: FutureBuilder<List<NewsModel>>(
        future: newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final newsList = snapshot.data ?? [];
          final highlight = newsList.firstWhere(
            (n) => n.isHighlight,
            orElse: () => newsList.isNotEmpty ? newsList.first : NewsModel(
              id: '0',
              title: 'Notícia Nuclear',
              summary: 'Tecnologia para o desenvolvimento.',
              category: 'Geral',
              date: '2026',
              url: 'amazul.gov.br',
            ),
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NewsHeaderWidget(highlightNews: highlight),
                const SizedBox(height: 24),
                const Text(
                  'Últimas Atualizações',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: newsList.length,
                  itemBuilder: (context, index) {
                    return NewsCardWidget(news: newsList[index]);
                  },
                ),
                const SizedBox(height: 20),
                const FaqButtonWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
