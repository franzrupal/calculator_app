import 'package:calculator_app/ui/widgets/buttons.dart';
import 'package:flutter/material.dart';
//import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:calculator_app/ui/styles/text_styles.dart';
import 'package:calculator_app/ui/styles/color_styles.dart';
import 'package:calculator_app/ui/constants/contextExtension.dart';

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  var userAnswer = '';

  //button list
  final List<String> buttons = [
    'AC',
    'C',
    '%',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '.',
    '0',
    '00',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColorStyles.background,
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                child: calculateField(),
              )),
          Expanded(
            flex: 2,
            child: buildContainerButtonsField(),
          ),
        ],
      ),
    );
  }

  Container buildContainerButtonsField() {
    return Container(
      child: GridView.builder(
          itemCount: buttons.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            // Clear Button
            if (index == 0) {
              return CalculatorButton(
                buttonTapped: () {
                  setState(() {
                    userAnswer = '';
                  });
                },
                buttonText: buttons[index],
                color: UIColorStyles.GREY_MODE,
              );
            }
            // Delete Button
            else if (index == 1) {
              return CalculatorButton(
                buttonTapped: () {
                  setState(() {
                    userAnswer = userAnswer.substring(0, userAnswer.length - 1);
                  });
                },
                buttonText: buttons[index],
                color: UIColorStyles.GREY_MODE,
              );
            }
            // equal button
            else if (index == buttons.length - 1) {
              return CalculatorButton(
                buttonTapped: () {
                  setState(() {
                    equalPressed();
                  });
                },
                buttonText: buttons[index],
                color: UIColorStyles.PRIMARY_COLOR,
                textColor: Colors.white,
              );
            }
            // % button
            else if (index == 2) {
              return CalculatorButton(
                buttonTapped: () {
                  setState(() {
                    userAnswer += buttons[index];
                  });
                },
                buttonText: buttons[index],
                color: UIColorStyles.GREY_MODE,
              );
            }
            // Normal buttons
            else {
              return CalculatorButton(
                buttonTapped: () {
                  setState(() {
                    userAnswer += buttons[index];
                  });
                },
                buttonText: buttons[index],
                color: isOperator(buttons[index])
                    ? Color(0xFFFF9800)
                    : Color.fromARGB(255, 50, 50, 50),
                textColor:
                    isOperator(buttons[index]) ? Colors.white : Colors.white,
              );
            }
          }),
    );
  }

  Column calculateField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            padding: context.paddingAllow,
            alignment: Alignment.bottomRight,
            child: Text(
              userAnswer,
              style: UITextStyles.buttonTextStyle,
            )),
      ],
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    Parser p = Parser();
    Expression exp = p.parse(userAnswer);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
