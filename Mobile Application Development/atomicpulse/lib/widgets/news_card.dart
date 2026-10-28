import 'package:flutter/material.dart';
import 'package:atomicpulse/models/news_model.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class NewsCardWidget extends StatelessWidget {
  final NewsModel news;

  const NewsCardWidget({super.key, required this.news});

  void openNewsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.surfaceBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppTheme.cyanAccent, width: 1.5),
        ),
        title: Text(news.title, style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Categoria: ${news.category}', style: const TextStyle(color: AppTheme.cyanAccent)),
            const SizedBox(height: 8),
            Text(news.summary, style: const TextStyle(color: Colors.white70)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar', style: TextStyle(color: AppTheme.cyanAccent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.deepNavy,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.cyanAccent.withValues(alpha: 0.3)),
          ),
          child: const Icon(Icons.newspaper, color: AppTheme.cyanAccent),
        ),
        title: Text(
          news.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            '${news.category} • ${news.date}',
            style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: AppTheme.cyanAccent, size: 16),
        onTap: () => openNewsDialog(context),
      ),
    );
  }
}

