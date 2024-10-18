import 'package:calculator_app/button.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class calculatorApp extends StatefulWidget {
  const calculatorApp({super.key});

  @override
  State<calculatorApp> createState() => _calculatorAppState();
}

class _calculatorAppState extends State<calculatorApp> {

  String expression = '0';

  String result = '';

  List <dynamic> operation = [];

  var history = <dynamic, String> {};

  void _onButtonPressed(String value) {
    setState(() {
      // Handle clearing the expression
      if (value == 'C') {
        expression = '0';
        operation.clear();
        result = '';
      }
      // Handle backspace
      else if (value == '⌫') {
        expression = expression.length > 1
            ? expression.substring(0, expression.length - 1)
            : '0';
      }

      else if (value == '=') {
        try {
          // Evaluate the expression safely and show the result
          result = _evaluateExpression(expression).toString();
        } catch (e) {
          expression = 'Error';
        }
        history[expression] = result;
      }

      else if (value == '#') {
        expression = '';
        if (history.isEmpty){
          expression = '0';
        }else{
          for (var entry in history.entries){
              // expression = history.toString();
              expression += '${entry.key} = ${entry.value} \n';

          }
        }
      }

      // Handle other button presses
      else {
        if (expression == '0') {
          expression = value; // Replace initial 0 with the first input
        } else {
          if (value == '+' || value == '-' || value == '*' || value == '/' || value == '.') {
            // Prevent consecutive operators
            if (expression.endsWith('+') ||
                expression.endsWith('-') ||
                expression.endsWith('*') ||
                expression.endsWith('/') ||
                expression.endsWith('.')) {
              return;
            }
          }
          expression += value;
        }
      }
    });
  }

  _evaluateExpression(String expression) {
    List<String> tokens = expression.split(RegExp(r'(\+|-|\*|/)'));
    List<String> operators = expression.replaceAll(RegExp(r'[^+\-*/]'), '').split('');

    // First, handle multiplication and division
    for (int i = 0; i < operators.length; i++) {
      if (operators[i] == '*' || operators[i] == '/') {
        double left = double.parse(tokens[i]);
        double right = double.parse(tokens[i + 1]);
        num result;
        if (operators[i] == '*') {
          result = left * right;
        } else {
          result = left / right;
        }
        tokens[i] = result.toString();
        tokens.removeAt(i + 1);
        operators.removeAt(i);
        i--; // Adjust index after removal
      }
    }

    // Then, handle addition and subtraction
    num result = double.parse(tokens[0]);
    for (int i = 0; i < operators.length; i++) {
      double right = double.parse(tokens[i + 1]);
      if (operators[i] == '+') {
        result += right;
      } else if (operators[i] == '-') {
        result -= right;
      }
    }

    //checks if there is only one digit after the decimal point and if its value is 0
    if (result.toString() == result.toStringAsFixed(1) && result.toString().split('.')[1] == '0') {
      result = result.toInt();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bodyContainer()
    );
  }

  bodyContainer() => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Text(result,
                      style: TextStyle(fontSize: 40),
                    )),
              ),
              SizedBox(height: 40,),
              Container(
                alignment: Alignment.centerRight,
                child: Text(expression, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => _onButtonPressed('#'),
                      icon: Icon(
                        FluentIcons.clock_24_regular,
                        size: 25,
                      )),
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        FluentIcons.ruler_24_regular,
                        size: 25,
                      )),
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        FluentIcons.calculator_multiple_24_regular,
                        size: 25,
                      ))
                ],
              ),
              IconButton(
                  onPressed: () => _onButtonPressed('⌫'),
                  icon: Icon(
                    FluentIcons.backspace_24_regular,
                    size: 25,
                  )),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: Colors.grey.shade300,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttons(
                    text: 'C',
                    text_color: Colors.red,
                    btnPressed: _onButtonPressed,
                  ),
                  buttons(
                    text: '7',
                    text_color: Colors.black,
                    btnPressed: _onButtonPressed,
                  ),
                  buttons(
                    text: '4',
                    text_color: Colors.black,
                    btnPressed: _onButtonPressed,
                  ),
                  buttons(
                      text: '1',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '+/-',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttons(
                      text: '( )',
                      text_color: Colors.brown,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '8',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '5',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '2',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '0',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttons(
                      text: '%',
                      text_color: Colors.brown,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '9',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '6',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '3',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '.',
                      text_color: Colors.black,
                      btnPressed: _onButtonPressed),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buttons(
                      text: '/',
                      text_color: Colors.red,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '*',
                      text_color: Colors.brown,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '-',
                      text_color: Colors.brown,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '+',
                      text_color: Colors.brown,
                      btnPressed: _onButtonPressed),
                  buttons(
                      text: '=',
                      text_color: Colors.brown,
                      btnPressed: _onButtonPressed),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
