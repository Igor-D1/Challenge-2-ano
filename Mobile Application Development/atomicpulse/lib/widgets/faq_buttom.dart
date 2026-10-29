import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';
import 'package:atomicpulse/pages/faq_page.dart';

class FaqButtonWidget extends StatelessWidget {
  const FaqButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FaqPage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.cyanAccent,
          foregroundColor: AppTheme.darkNavy,
          elevation: 6,
          shadowColor: AppTheme.cyanAccent.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        icon: const Icon(Icons.help_outline, color: AppTheme.darkNavy),
        label: const Text(
          'Perguntas Frequentes (FAQ)',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
