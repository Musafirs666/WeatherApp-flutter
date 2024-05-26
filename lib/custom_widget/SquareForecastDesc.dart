import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SquareForecastDesc extends StatefulWidget {
  final Widget image;
  final String text;
  final Color textColor;

  const SquareForecastDesc({
    Key? key,
    required this.image,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  @override
  State<SquareForecastDesc> createState() => _SquareForecastDescState();
}

class _SquareForecastDescState extends State<SquareForecastDesc> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 75,
          height: 75,
          decoration: BoxDecoration(
              color: const Color(0xFFf8f8f9),
              borderRadius: BorderRadius.circular(20)),
          child: widget.image,
        ),
        const SizedBox(height: 5,),
        Text(
          widget.text,
          style: TextStyle(
              fontFamily: 'Poppins',
              color: widget.textColor,
              fontWeight: FontWeight.w700,
              fontSize: 15,
              height: 2),
        )
      ],
    );
  }
}
