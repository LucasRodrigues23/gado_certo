import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'result.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora IMC')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Adicione suas informações:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
                controller: heightController,
                decoration: const InputDecoration(labelText: 'Altura (cm)'),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true), // Permite números decimais
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ]),
            TextField(
                controller: weightController,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true), // Permite números decimais
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ]),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                double height = double.tryParse(heightController.text) ?? 0;
                double weight = double.tryParse(weightController.text) ?? 0;
                double imc = calculateIMC(height, weight);

                if (imc.isNaN || height == 0 || weight == 0) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Erro'),
                        content: const Text(
                            'O valor do IMC não pôde ser calculado.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultScreen(imc: imc),
                    ),
                  );
                }
              },
              child: const Text('Calcular'),
            ),
          ],
        ),
      ),
    );
  }

  double calculateIMC(double height, double weight) {
    return weight / ((height / 100) * (height / 100));
  }
}
