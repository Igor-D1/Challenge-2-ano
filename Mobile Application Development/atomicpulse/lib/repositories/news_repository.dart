import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:atomicpulse/models/news_model.dart';

class NewsRepository {
  Future<List<NewsModel>> fetchNews() async {
    try {
      final String response = await rootBundle.loadString('assets/json/news.json');
      final List<dynamic> data = jsonDecode(response);
      return data.map((json) => NewsModel.fromJson(json)).toList();
    } catch (e) {
      return [
        NewsModel(
          id: '1',
          title: 'Avanço do Reator Multipropósito Brasileiro (RMB)',
          summary: 'O RMB garantirá a produção soberana de radiofármacos.',
          category: 'Saúde & Ciência',
          date: '2026-10-20',
          url: 'amazul.gov.br',
          isHighlight: true,
        ),
      ];
    }
  }
}
