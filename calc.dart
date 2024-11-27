import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = '0';

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        displayText = '0';
      } else if (value == '=') {
        try {
          displayText = _evaluateExpression(displayText);
        } catch (e) {
          displayText = 'Error';
        }
      } else {
        if (displayText == '0' && value != '.') {
          displayText = value;
        } else {
          displayText += value;
        }
      }
    });
  }

  String _evaluateExpression(String expression) {
    // This is a simple evaluation. For advanced calculations, use a library like math_expressions.
    try {
      final result = double.parse(expression);
      return result.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  displayText,
                  style: const TextStyle(fontSize: 48, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return CalculatorButton(
                    text: buttons[index],
                    onPressed: () => onButtonPressed(buttons[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> buttons = [
    '7', '8', '9', '/',
    '4', '5', '6', '*',
    '1', '2', '3', '-',
    '0', '.', '=', '+',
    'C',
  ];
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
