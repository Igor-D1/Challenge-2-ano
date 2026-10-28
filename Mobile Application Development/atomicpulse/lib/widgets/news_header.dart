import 'package:flutter/material.dart';
import 'package:atomicpulse/models/news_model.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class NewsHeaderWidget extends StatelessWidget {
  final NewsModel highlightNews;

  const NewsHeaderWidget({super.key, required this.highlightNews});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppTheme.surfaceBlue,
            AppTheme.deepNavy,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTheme.cyanAccent.withValues(alpha: 0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppTheme.cyanAccent.withValues(alpha: 0.15),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.cyanAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'DESTAQUE CENTRAL',
                  style: TextStyle(
                    color: AppTheme.darkNavy,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.radar, color: AppTheme.cyanAccent, size: 20),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            highlightNews.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            highlightNews.summary,
            style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8)),
          ),
        ],
      ),
    );
  }
}
