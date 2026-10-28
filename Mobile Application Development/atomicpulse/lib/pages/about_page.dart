import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Sobre a AMazul'),
        centerTitle: true, // Garante que o texto fica no meio exato
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Image.asset(
              'assets/images/logo.jpeg',
              height: 60,
              width: 60,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.surfaceBlue,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppTheme.cyanAccent.withValues(alpha: 0.3)),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amazônia Azul Tecnologias de Defesa S.A.',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.cyanAccent),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A AMazul foi criada em 2012 para absorver e desenvolver tecnologias dos programas nucleares e de defesa do Brasil.',
                    style: TextStyle(color: Colors.white70, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Os 4 Pilares Tecnológicos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            buildPillarTile(Icons.directions_boat, '1. Tecnologia Naval',
                'Submarinos e Defesa Nacional.'),
            buildPillarTile(Icons.local_fire_department,
                '2. Combustível Nuclear', 'Ciclo de enriquecimento do urânio.'),
            buildPillarTile(Icons.bolt, '3. Geração de Energia',
                'Usinas e plantas de propulsão.'),
            buildPillarTile(Icons.medical_services, '4. Radiofármacos',
                'Medicina e diagnósticos de saúde.'),
          ],
        ),
      ),
    );
  }

  Widget buildPillarTile(IconData icon, String title, String desc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.cyanAccent),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(desc,
            style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ),
    );
  }
}
