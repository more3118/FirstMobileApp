import 'package:flutter/material.dart';

void main() {
  runApp(const ConverterApp());
}

class ConversionOption {
  const ConversionOption({
    required this.label,
    required this.inputUnit,
    required this.outputUnit,
    required this.factor,
  });

  final String label;
  final String inputUnit;
  final String outputUnit;
  final double factor;
}

const List<ConversionOption> _conversionOptions = [
  ConversionOption(
    label: 'Distance: km → miles',
    inputUnit: 'km',
    outputUnit: 'miles',
    factor: 0.621371,
  ),
  ConversionOption(
    label: 'Distance: miles → km',
    inputUnit: 'miles',
    outputUnit: 'km',
    factor: 1 / 0.621371,
  ),
  ConversionOption(
    label: 'Weight: kg → lb',
    inputUnit: 'kg',
    outputUnit: 'lb',
    factor: 2.20462,
  ),
  ConversionOption(
    label: 'Weight: lb → kg',
    inputUnit: 'lb',
    outputUnit: 'kg',
    factor: 1 / 2.20462,
  ),
];

/// Root Application Widget
class ConverterApp extends StatelessWidget {
  const ConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ConverterHomePage(),
    );
  }
}

/// Home Page Stateful Widget
class ConverterHomePage extends StatefulWidget {
  const ConverterHomePage({super.key});

  @override
  State<ConverterHomePage> createState() => _ConverterHomePageState();
}

class _ConverterHomePageState extends State<ConverterHomePage> {
  final TextEditingController _controller = TextEditingController();

  ConversionOption _selectedOption = _conversionOptions.first;
  String _result = '';
  String _errorMessage = '';

  void _convert() {
    final inputValue = double.tryParse(_controller.text);

    if (inputValue == null) {
      setState(() {
        _result = '';
        _errorMessage = 'Enter a valid number.';
      });
      return;
    }

    final outputValue = inputValue * _selectedOption.factor;
    setState(() {
      _errorMessage = '';
      _result = '${inputValue.toStringAsFixed(2)} ${_selectedOption.inputUnit} = '
          '${outputValue.toStringAsFixed(2)} ${_selectedOption.outputUnit}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Metric ↔ Imperial Converter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<ConversionOption>(
              value: _selectedOption,
              items: _conversionOptions.map((option) {
                return DropdownMenuItem<ConversionOption>(
                  value: option,
                  child: Text(option.label),
                );
              }).toList(),
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Enter value in ${_selectedOption.inputUnit}',
                hintText: 'e.g. 10.0',
                errorText: _errorMessage.isEmpty ? null : _errorMessage,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
