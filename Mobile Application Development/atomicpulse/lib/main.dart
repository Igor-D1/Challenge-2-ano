import 'package:flutter/material.dart';
import 'package:atomicpulse/theme/app_theme.dart';
import 'package:atomicpulse/pages/splash_page.dart';

void main() {
  runApp(const AtomicPulseApp());
}

class AtomicPulseApp extends StatefulWidget {
  const AtomicPulseApp({super.key});

  @override
  State<AtomicPulseApp> createState() => AtomicPulseAppState();
}

class AtomicPulseAppState extends State<AtomicPulseApp> {
  Color customPrimaryColor = AppTheme.cyanAccent;

  void updateThemeColor(Color newColor) {
    setState(() {
      customPrimaryColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = AppTheme.darkTheme;

    if (customPrimaryColor != AppTheme.cyanAccent) {
      theme = theme.copyWith(
        primaryColor: customPrimaryColor,
        colorScheme: theme.colorScheme.copyWith(primary: customPrimaryColor),
      );
    }

    return MaterialApp(
      title: 'AtomicPulse: Conexão Nuclear',
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) {
        return SafeArea(
          child: child ?? const SizedBox(),
        );
      },
      home: SplashPage(onColorChanged: updateThemeColor),
    );
  }
}