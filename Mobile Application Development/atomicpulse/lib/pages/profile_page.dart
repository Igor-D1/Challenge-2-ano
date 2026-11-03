import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Perfil do Jogador'),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 116,
                        height: 116,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.cyanAccent, width: 3),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.asset(
                          'assets/images/perfil.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.person,
                            size: 60,
                            color: AppTheme.cyanAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Estudante FIAP 2TDS',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Nível 5 • Mestre da Energia Nuclear',
                    style: TextStyle(color: AppTheme.cyanAccent, fontSize: 14),
                  ),
                  const SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Progresso do Nível', style: TextStyle(fontSize: 12, color: Colors.grey)),
                            Text('1.250 / 1.500 XP', style: TextStyle(fontSize: 12, color: AppTheme.cyanAccent, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 6),
                        LinearProgressIndicator(
                          value: 0.83,
                          backgroundColor: Colors.grey.shade800,
                          color: AppTheme.cyanAccent,
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                buildStatCard('Pontos', '1.250', Icons.star),
                buildStatCard('Acertos', '90%', Icons.check_circle_outline),
                buildStatCard('Ranking', '#3', Icons.emoji_events_outlined),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Conquistas Recentes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildBadgeCard('Fisiculturista', 'Reactor Pro', Icons.bolt, true),
                  buildBadgeCard('Sequência', '7 Dias Seguidos', Icons.local_fire_department, true),
                  buildBadgeCard('Missão 1', 'Desafio Concluído', Icons.military_tech, true),
                  buildBadgeCard('Mestre', 'Gênio do Quiz', Icons.psychology, false),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Desempenho Geral',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    buildDetailRow(Icons.task_alt, 'Missões Concluídas', '42 / 50'),
                    const Divider(height: 24, color: Colors.white12),
                    buildDetailRow(Icons.timer, 'Tempo de Jogo', '14h 32m'),
                    const Divider(height: 24, color: Colors.white12),
                    buildDetailRow(Icons.trending_up, 'Precisão Média', '88.5%'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  // Futuramente vai ter algo aqui enquanto isso calma
                },
                icon: const Icon(Icons.edit),
                label: const Text('Editar Perfil', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStatCard(String label, String value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Icon(icon, color: AppTheme.cyanAccent, size: 22),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.cyanAccent),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBadgeCard(String title, String subtitle, IconData icon, bool unlocked) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: unlocked ? Colors.white.withValues(alpha: 0.05) : Colors.black12,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: unlocked ? AppTheme.cyanAccent.withValues(alpha: 0.5) : Colors.grey.shade800,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: unlocked ? AppTheme.cyanAccent : Colors.grey,
            size: 28,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: unlocked ? Colors.white : Colors.grey,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 9, color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget buildDetailRow(IconData icon, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.cyanAccent, size: 20),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 14)),
          ],
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    );
  }
}
