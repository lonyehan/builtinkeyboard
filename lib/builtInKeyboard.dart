library built_in_keyboard;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuiltInKeyboard extends StatefulWidget {
  final String layoutType;
  final TextStyle letterStyle;
  final BoxDecoration decoration;
  final TextEditingController controller;
  final double height;
  final double width;
  final double spacing;
  final bool enableBackSpace;
  BuiltInKeyboard({
    this.controller,
    this.layoutType,
    this.letterStyle = const TextStyle(fontSize: 25, color: Colors.black),
    this.decoration,
    this.height = 46.0,
    this.width = 35.0,
    this.spacing = 8.0,
    this.enableBackSpace = true,
  });
  @override
  BuiltInKeyboardState createState() => BuiltInKeyboardState();
}

class BuiltInKeyboardState extends State<BuiltInKeyboard> {
  @override
  Widget build(BuildContext context) {
    List<Widget> keyboardLayout = layout(widget.layoutType);
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: keyboardLayout.sublist(0, 10),
        ),
        SizedBox(
          height: widget.spacing,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: keyboardLayout.sublist(10, 19),
        ),
        SizedBox(
          height: widget.spacing,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 5,
          runSpacing: 5,
          children: keyboardLayout.sublist(19),
        ),
      ],
    );
  }

  Widget buttonLetter(String letter) {
    return InkWell(
      onTap: () => widget.controller.text += letter,
      child: Container(
        decoration: widget.decoration,
        height: widget.height,
        width: widget.width,
        child: Center(
          child: Text(
            letter,
            style: widget.letterStyle,
          ),
        ),
      ),
    );
  }

  Widget backSpace() {
    return InkWell(
      onTap: () => widget.controller.text = widget.controller.text
          .substring(0, widget.controller.text.length - 1),
      child: Container(
        decoration: widget.decoration,
        height: 45,
        width: 100,
        child: Center(
          child: Text('<backspace>'),
        ),
      ),
    );
  }

  List<Widget> layout(String layoutType) {
    List<String> letters = [];
    if (layoutType == 'EN') {
      letters = 'QWERTYUIOPASDFGHJKLZXCVBNM'.split("");
    } else if (layoutType == 'FR') {
      letters = 'azertyuiopqsdfghjklmwxcvbn'.split("");
    }

    List<Widget> keyboard = [];
    letters.forEach((String letter) {
      keyboard.add(
        buttonLetter(letter),
      );
    });
    if (widget.enableBackSpace) {
      keyboard.add(backSpace());
    }
    return keyboard;
  }
}
