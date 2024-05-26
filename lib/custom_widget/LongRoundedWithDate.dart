import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LongRoundedWithDate extends StatefulWidget {
  final Widget image;
  final String date;
  final String day;
  final bool isActive;

  const LongRoundedWithDate({
    Key? key,
    required this.image,
    required this.day,
    required this.date,
    required this.isActive,
  }) : super(key: key);

  @override
  State<LongRoundedWithDate> createState() => _LongForecastDesc();
}

class _LongForecastDesc extends State<LongRoundedWithDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 140,
      margin: const EdgeInsets.fromLTRB(0, 20, 20, 20),
      decoration: BoxDecoration(
        color: widget.isActive ? Colors.white : null,
        borderRadius: BorderRadius.circular(40),
        gradient: !widget.isActive
            ? const LinearGradient(
                colors: [
                  Color(0xFFAECDFF), // Warna gradient dari atas
                  Color(0xFF5896FD), // Warna gradient ke bawah
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        boxShadow: widget.isActive
            ? [
                BoxShadow(
                  color: Color(0xFF806EF8).withOpacity(1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: widget.image,
            ),
            Text(
              widget.date,
              style: TextStyle(
                  fontSize: 35,
                  fontFamily: 'Poppins',
                  color: widget.isActive ? Color(0xFF806EF8) : Colors.white,
                  fontWeight: FontWeight.bold,
                  height: 1),
            ),
            Text(
              widget.day,
              style: TextStyle(
                fontSize: 15,
                color: widget.isActive ? Color(0xFF806EF8) : Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
                height: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
