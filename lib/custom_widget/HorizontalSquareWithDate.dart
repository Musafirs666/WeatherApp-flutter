import 'package:flutter/material.dart';

class HorizontalSquareWithDate extends StatefulWidget {
  const HorizontalSquareWithDate({super.key});

  @override
  State<HorizontalSquareWithDate> createState() => _HorizontalSquareWithDateState();
}

class _HorizontalSquareWithDateState extends State<HorizontalSquareWithDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 35,
            spreadRadius: 3,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      child: const Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "09 May, Monday",
            style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          Text(
            "22°",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 30,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud,
                color: Colors.blue,
              ),
              Text(
                "Cloudly",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600),
              )
            ],
          )
        ],
      ),
    );
  }
}
