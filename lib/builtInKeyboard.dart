library built_in_keyboard;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuiltInKeyboard extends StatefulWidget {
  final String layoutType;
  final TextStyle letterStyle;
  final BorderRadius borderRadius;
  final Color color;
  final Color highlightColor;
  final Color splashColor;
  final TextEditingController controller;
  final double height;
  final double width;
  final double spacing;
  final bool enableBackSpace;
  final bool enableUppercaseAll;
  final bool enableLongPressUppercase;
  BuiltInKeyboard({
    this.controller,
    this.layoutType,
    this.letterStyle = const TextStyle(fontSize: 25, color: Colors.black),
    this.borderRadius,
    this.color = Colors.deepOrange,
    this.highlightColor,
    this.splashColor,
    this.height = 46.0,
    this.width = 35.0,
    this.spacing = 8.0,
    this.enableBackSpace = true,
    this.enableUppercaseAll = false,
    this.enableLongPressUppercase = false,
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
    return Container(
      height: widget.height,
      width: widget.width,
      child: Material(
        type: MaterialType.button,
        color: widget.color,
        borderRadius: widget.borderRadius,
        child: InkWell(
          highlightColor: widget.highlightColor,
          splashColor: widget.splashColor,
          onTap: () {
            widget.controller.text += letter;
            widget.controller.selection = TextSelection.fromPosition(
                TextPosition(offset: widget.controller.text.length));
          },
          onLongPress: () {
            if (widget.enableLongPressUppercase && !widget.enableUppercaseAll) {
              widget.controller.text += letter.toUpperCase();
              widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length));
            }
          },
          child: Center(
            child: Text(
              letter,
              style: widget.letterStyle,
            ),
          ),
        ),
      ),
    );
  }

  Widget backSpace() {
    return Container(
      height: widget.height,
      width: widget.width + 20,
      child: Material(
        type: MaterialType.button,
        color: widget.color,
        borderRadius: widget.borderRadius,
        child: InkWell(
          highlightColor: widget.highlightColor,
          splashColor: widget.splashColor,
          onTap: () {
            if (widget.controller.text.isNotEmpty) {
              widget.controller.text = widget.controller.text
                  .substring(0, widget.controller.text.length - 1);
              widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length));
            }
          },
          onLongPress: () {
            if (widget.controller.text.isNotEmpty) {
              widget.controller.text = '';
              widget.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: widget.controller.text.length));
            }
          },
          child: Center(
            child: Icon(
              Icons.backspace_outlined,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> layout(String layoutType) {
    List<String> letters = [];
    if (layoutType == 'EN') {
      if (widget.enableUppercaseAll) {
        letters = 'qwertyuiopasdfghjklzxcvbnm'.toUpperCase().split("");
      } else {
        letters = 'qwertyuiopasdfghjklzxcvbnm'.split("");
      }
    } else if (layoutType == 'FR') {
      if (widget.enableUppercaseAll) {
        letters = 'azertyuiopqsdfghjklmwxcvbn'.toUpperCase().split("");
      } else {
        letters = 'azertyuiopqsdfghjklmwxcvbn'.split("");
      }
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
