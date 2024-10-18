import 'package:flutter/material.dart';

class buttons extends StatefulWidget {
  buttons({required this.text, required this.text_color, required this.btnPressed});

  final String text;
  final Color text_color;
  final Function(String) btnPressed;

  @override
  State<buttons> createState() => _buttonsState();
}

class _buttonsState extends State<buttons> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          widget.btnPressed(widget.text); // Call the passed function
        },
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 30,
              color: widget.text_color,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          fixedSize: Size(70, 70),
          shape: CircleBorder(),
          padding: EdgeInsets.all(5),
        ),
      ),
    );
  }
}
