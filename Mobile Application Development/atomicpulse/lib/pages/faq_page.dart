import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        'question': 'O que é a AMazul e qual sua função?',
        'answer':
            'A AMazul (Amazônia Azul Tecnologias de Defesa S.A.) é uma empresa pública para promover tecnologias do Programa Nuclear da Marinha.'
      },
      {
        'question': 'Energia nuclear serve apenas para fins militares?',
        'answer':
            'Não! Possui vasta aplicação civil em medicina (radiofármacos), agricultura e geração de energia limpa.'
      },
      {
        'question': 'O que é o Reator Multipropósito Brasileiro (RMB)?',
        'answer':
            'O RMB é um empreendimento voltado para autossuficiência na produção de radioisótopos para tratamento de câncer.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Perguntas Frequentes (FAQ)'),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              iconColor: AppTheme.cyanAccent,
              collapsedIconColor: Colors.white70,
              title: Text(
                faqs[index]['question']!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faqs[index]['answer']!,
                    style: const TextStyle(color: Colors.white70, height: 1.4),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
