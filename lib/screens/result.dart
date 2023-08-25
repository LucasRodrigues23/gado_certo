import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final double imc;

  const ResultScreen({super.key, required this.imc});

  @override
  Widget build(BuildContext context) {
    String resultText = 'IMC ideal';
    IconData resultIcon = Icons.check;
    Color resultColor = Colors.green;
    if (imc < 18.5) {
      resultText = 'IMC abaixo do ideal';
      resultIcon = Icons.warning;
      resultColor = Colors.orange;
    } else if (imc >= 24.5) {
      resultText = 'IMC acima do ideal';
      resultIcon = Icons.error;
      resultColor = Colors.red;
    }

    return Scaffold(
      backgroundColor: resultColor,
      appBar: AppBar(
        title: const Text('Result'),
        backgroundColor: resultColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(resultIcon, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'Seu imc: ${imc.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              resultText,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
