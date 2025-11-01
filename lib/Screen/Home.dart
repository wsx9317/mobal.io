import 'package:flutter/material.dart';
import 'package:mobal/Model/UiColor.dart';
import 'package:mobal/Widget/TextWidget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Textwidget(
          text: '테스트',
          fontSize: 18,
          fontSpacing: 0,
          fontHeight: 1,
          fontWeight: FontWeight.w600,
          fontColor: UiColor.black100Per,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
