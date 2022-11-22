import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const PerfectSquareOrCube());
}

class PerfectSquareOrCube extends StatelessWidget {
  const PerfectSquareOrCube({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Perfect Square or Cube',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Perfect Square or Cube'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? number;
  int? inputValue;
  final String messageIsSquare = 'The number is a perfect square.';
  final String messageIsCube = 'The number is a perfect cube.';
  final String messageIsSquareAndCube = 'The number is a perfect square and a perfect cube.';
  final String messageIsNotSquareOrCube = 'The number is nor a perfect square neither a perfect cube.';
  bool isSquare = false;
  bool isCube = false;
  String currentMessage = '';
  final TextEditingController numberTextFieldController = TextEditingController();

  void checkIfSquareOrCube() {
    setState(() {
      if (numberTextFieldController.text.isEmpty) {
        number = null;
        currentMessage = 'Please insert a number.';
        return;
      }
      isSquare = false;
      isCube = false;
      number = int.parse(numberTextFieldController.text);
      for (int i = 1; i <= number! / 2; i++) {
        final int product = i * i;
        if (product == number) {
          isSquare = true;
        }
        if (product * i == number) {
          isCube = true;
        }
      }
      if (isSquare) {
        if (isCube) {
          currentMessage = messageIsSquareAndCube;
        } else {
          currentMessage = messageIsSquare;
        }
      } else {
        if (isCube) {
          currentMessage = messageIsCube;
        } else {
          currentMessage = messageIsNotSquareOrCube;
        }
      }
    });
  }

  @override
  void dispose() {
    numberTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              Text(
                'Please input a number to see if it is perfect square or cube.',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: TextField(
                  controller: numberTextFieldController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    hintText: 'Insert a number',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkIfSquareOrCube();
          showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text('Check result for $number'),
                    content: Text(currentMessage),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        },
        tooltip: 'Check',
        child: const Icon(Icons.check),
      ),
    );
  }
}
