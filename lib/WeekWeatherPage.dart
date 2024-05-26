import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutterapp/custom_widget/HorizontalSquareWithDate.dart';
import 'package:weather_flutterapp/custom_widget/LongRoundedWithDate.dart';
import 'package:weather_flutterapp/custom_widget/NavbarIcon.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutterapp/custom_widget/SquareForecastDesc.dart';

class WeekWeatherPage extends StatefulWidget {
  final List<dynamic> todayForecastData;
  final Map<String, dynamic> currentForecastData;
  final String currentHour;
  final String choosedCity;
  final String formattedCondition;
  final String timeOfDay;

  const WeekWeatherPage({
    super.key,
    required this.todayForecastData,
    required this.currentForecastData,
    required this.currentHour,
    required this.choosedCity,
    required this.formattedCondition,
    required this.timeOfDay,
  });

  @override
  State<WeekWeatherPage> createState() => _WeekWeatherPageState();
}

class _WeekWeatherPageState extends State<WeekWeatherPage> {
  List<dynamic> _weekForecastData = [];
  List<Map<String, dynamic>> _weekList = [];

  @override
  void initState() {
    super.initState();
    // Memanggil fungsi untuk mengambil data dari API saat widget pertama kali dibuat
    fetchData(widget.choosedCity);
  }

  int getFutureTimestamp() {
    DateTime futureDate = DateTime.now().add(Duration(days: 7));
    return (futureDate.millisecondsSinceEpoch ~/
        1000); // Dibagi 1000 untuk mengonversi ke detik
  }

  Future<void> fetchData(chossedCity) async {
    await dotenv.load();
    String city = chossedCity;
    int futureTimestamp = getFutureTimestamp();

    final response = await http.get(Uri.parse(
        '${dotenv.env['BASE_URL']}?key=${dotenv.env['API_KEY']}&q=${city}&days=7&aqi=no&alerts=no&unixend_dt=${futureTimestamp}'));
    if (response.statusCode == 200) {
      print(response.body);
      setState(() {
        _weekForecastData =
            jsonDecode(response.body)['forecast']['forecastday'];
        _weekList = _weekForecastData.map((item) {
          DateTime date = DateTime.parse(item['date']);
          String day = DateFormat('EEEE').format(date).substring(0, 3);
          return {
            'icon': item['day']['condition']['icon'],
            'date': item['date'].split('-')[2],
            'day': day,
          };
        }).toList();
        print(_weekList);
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: const Color(0xFF5896FD),
          // padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavbarIcon(
                            icon: Icons.arrow_back_ios_rounded,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                        const Text(
                          "Next 7 Days",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'ITC',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        NavbarIcon(
                            icon: Icons.person,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    // controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _weekList.map((item) {
                        String currentDay = DateTime.now().day.toString();

                        return LongRoundedWithDate(
                          image: Image.network("https:${item['icon']}"),
                          date: item['date'],
                          day: item['day'],
                          isActive: currentDay == item['date'],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60.0), // Atas kiri
                      topRight: Radius.circular(60.0), // Atas kanan
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.75,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 325,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFFAECDFF).withOpacity(0.7),
                                  blurRadius: 20,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 15),
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFAECDFF), // Warna gradient dari atas
                                  Color(0xFF5896FD), // Warna gradient ke bawah
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30))),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(
                                          "https:${widget.currentForecastData['current']['condition']['icon']}",
                                          width: 140,
                                          height: 140,
                                          fit: BoxFit.cover,
                                        ),
                                        Text(
                                          widget.formattedCondition,
                                          style: TextStyle(
                                              fontSize: 30,
                                              color: Colors.white,
                                              letterSpacing: 0,
                                              height: 1,
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w700),
                                        ),
                                        Text(
                                          widget.timeOfDay,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              height: 2.5,
                                              fontFamily: "ITC",
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ShaderMask(
                                          shaderCallback: (Rect bounds) {
                                            return const LinearGradient(
                                              colors: [
                                                Colors.white,
                                                Color(0xFFAECDFF),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              stops: [0.0, 1.0],
                                            ).createShader(bounds);
                                          },

                                          //temperature Text
                                          child: Text(
                                            "${widget.currentForecastData['current']['temp_c'].toStringAsFixed(0)}°",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 80,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600,
                                                height: 1),
                                          ),
                                        ),

                                        Text(
                                          "Feels like${widget.currentForecastData['current']['feelslike_c'].toStringAsFixed(0)} °",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontFamily: "ITC",
                                            height: 1,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SquareForecastDesc(
                                      text:
                                          "${widget.currentForecastData['current']['wind_kph'].toStringAsFixed(0)} kph",
                                      image: Image.asset("assets/windSpeed.png"),
                                      textColor: Colors.white,
                                    ),
                                    SquareForecastDesc(
                                      text:
                                          "${widget.currentForecastData['current']['cloud'].toStringAsFixed(0)}%",
                                      image: Image.asset("assets/cloud.png"),
                                      textColor: Colors.white,
                                    ),
                                    SquareForecastDesc(
                                      text:
                                          "${widget.currentForecastData['current']['wind_dir']}",
                                      image:
                                          Image.asset("assets/windDirection.png"),
                                      textColor: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            Column(
                              children: _weekList.map((item) {
                                return HorizontalSquareWithDate(

                                );
                              }).toList(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
