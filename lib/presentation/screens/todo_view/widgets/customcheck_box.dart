import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Color borderColor;
  final Icon checkIcon;

  const CustomCheckBox(
      {required this.isChecked,
      required this.onChange,
      required this.size,
      required this.iconSize,
      required this.selectedColor,
      required this.selectedIconColor,
      required this.borderColor,
      required this.checkIcon,
      super.key});

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: widget.selectedColor,
            borderRadius: BorderRadius.circular(widget.size / 2),
            border: Border.all(
              color: Colors.transparent,
              width: 1.5,
            )),
        width: widget.size,
        height: widget.size,
        child: Icon(
          Icons.check,
          color: widget.selectedIconColor,
          size: widget.iconSize,
        ));
  }
}
