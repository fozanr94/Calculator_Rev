import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'dart:math';

import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorRevApp());
}

class CalculatorRevApp extends StatelessWidget {
  const CalculatorRevApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorAppHome(),
    );
  }
}

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({Key? key}) : super(key: key);

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  //below this is the logic

  String equation = '0';
  String result = '0';
  String expression = '';

  //cunction for button working

  buttonPresed(btnText) {
    setState(() {
      if (btnText == 'AC') {
        equation = '0';
        result = '0';
      } else if (btnText == '⌫') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '') {
          equation = '0';
        }
      } else if (btnText == '=') {
        expression = equation;
        expression = expression.replaceAll('x', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();

          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          'Error';
        }
      } else {
        if (equation == '0') {
          equation = btnText;
        } else
          equation = equation + btnText;
      }
    });
  }

  Widget calButtons(
      String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPresed(btnText);
      }
      //call our function
      ,
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btnText,
          style: TextStyle(
              color: txtColor, fontSize: 30, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        shape: const BeveledRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.elliptical(200, 100))),
        title: const Text(
          'Calculator Rev',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ), //display expression{equations} value
          Container(
            alignment: Alignment.centerRight,
            height: 70,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              equation,
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),

          const SizedBox(
            height: 10.0,
          ), //display result
          Container(
            alignment: Alignment.centerRight,
            height: 70,
            width: double.infinity,
            color: Colors.black,
            child: Text(
              result,
              style: TextStyle(color: Colors.white, fontSize: 60),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('AC', Colors.white, 80, Colors.lightGreen!),
                    calButtons('⌫', Colors.white, 80, Colors.white38!),
                    calButtons('%', Colors.white, 80, Colors.white38!),
                    calButtons('÷', Colors.white, 80, Colors.lightGreen!),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('7', Colors.white, 80, Colors.white10!),
                    calButtons('8', Colors.white, 80, Colors.white10!),
                    calButtons('9', Colors.white, 80, Colors.white10!),
                    calButtons('x', Colors.white, 80, Colors.lightGreen!),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('4', Colors.white, 80, Colors.white10!),
                    calButtons('5', Colors.white, 80, Colors.white10!),
                    calButtons('6', Colors.white, 80, Colors.white10!),
                    calButtons('-', Colors.white, 80, Colors.lightGreen!),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('1', Colors.white, 80, Colors.white10!),
                    calButtons('2', Colors.white, 80, Colors.white10!),
                    calButtons('3', Colors.white, 80, Colors.white10!),
                    calButtons('+', Colors.white, 80, Colors.lightGreen!),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    calButtons('0', Colors.white, 170, Colors.white10!),
                    calButtons(',', Colors.white, 80, Colors.white10!),
                    calButtons('=', Colors.white, 80, Colors.lightGreen!),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
