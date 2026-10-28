import 'package:flutter/material.dart';
import 'package:atomicpulse/pages/home_page.dart';
import 'package:atomicpulse/pages/about_page.dart';
import 'package:atomicpulse/pages/quiz_page.dart';
import 'package:atomicpulse/pages/profile_page.dart';
import 'package:atomicpulse/pages/settings_page.dart';

class MainNavigationPage extends StatefulWidget {
  final Function(Color) onColorChanged;

  const MainNavigationPage({super.key, required this.onColorChanged});

  @override
  State<MainNavigationPage> createState() => MainNavigationPageState();
}

class MainNavigationPageState extends State<MainNavigationPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      const AboutPage(),
      const QuizPage(),
      const ProfilePage(),
      SettingsPage(onColorChanged: widget.onColorChanged),
    ];

    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Sobre'),
          BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'Quiz'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
        ],
      ),
    );
  }
}
