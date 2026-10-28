import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';
import 'package:atomicpulse/pages/main_navigation_page.dart';

class SplashPage extends StatefulWidget {
  final Function(Color) onColorChanged;

  const SplashPage({super.key, required this.onColorChanged});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainNavigationPage(onColorChanged: widget.onColorChanged),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkNavy,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CAIXA GRANDE ESTILIZADA COM LOGO DENTRO
              Container(
                padding: const EdgeInsets.all(28.0),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceBlue,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: AppTheme.cyanAccent, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.cyanAccent.withValues( alpha: 0.35),
                      blurRadius: 30,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/images/logo.jpeg',
                        height: 180,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.blur_on,
                          size: 100,
                          color: AppTheme.cyanAccent,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'AtomicPulse',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Conexão Nuclear • AMazul',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.cyanAccent.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                color: AppTheme.cyanAccent,
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

