import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  final Function(Color) onColorChanged;

  const SettingsPage({super.key, required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Configurações'),
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Personalização Visual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('Cor de Destaque Global:'),
            const SizedBox(height: 12),
            Row(
              children: [
                buildColorOption(context, AppTheme.cyanAccent, 'Ciano'),
                const SizedBox(width: 12),
                buildColorOption(context, Colors.greenAccent, 'Verde'),
                const SizedBox(width: 12),
                buildColorOption(context, Colors.orangeAccent, 'Laranja'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildColorOption(BuildContext context, Color color, String name) {
    return GestureDetector(
      onTap: () => onColorChanged(color),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
