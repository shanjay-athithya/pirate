import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: BMICalculator()));

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String _bmiResult = "";
  String _bmiCategory = "";

  void _calculateBMI() {
    double height = double.tryParse(_heightController.text) ?? 0;
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        _bmiResult = "BMI: ${bmi.toStringAsFixed(1)}";
        _bmiCategory = _getBMICategory(bmi);
      });
    } else {
      setState(() {
        _bmiResult = "Invalid Input";
        _bmiCategory = "";
      });
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return "Underweight";
    if (bmi < 24.9) return "Normal Weight";
    if (bmi < 29.9) return "Overweight";
    return "Obese";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("BMI Calculator",style: const TextStyle(fontSize: 24, color: Colors.white)), backgroundColor: Colors.blueGrey[900],centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextField(_heightController, "Height (cm)"),
            const SizedBox(height: 15),
            _buildTextField(_weightController, "Weight (kg)"),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _calculateBMI, child: const Text("Calculate BMI")),
            const SizedBox(height: 20),
            Text(_bmiResult, style: const TextStyle(fontSize: 24, color: Colors.white)),
            Text(
              _bmiCategory,
              style: TextStyle(fontSize: 20, color: _getColor(_bmiCategory), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Color _getColor(String category) {
    return {
      "Underweight": Colors.yellow,
      "Normal Weight": Colors.green,
      "Overweight": Colors.orange,
      "Obese": Colors.red
    }[category] ?? Colors.white;
  }
}
