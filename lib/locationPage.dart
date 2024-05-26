import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Add this import statement

const List<String> _list = [
  'Developer',
  'Designer',
  'Consultant',
  'Student',
];

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _selectedItem = 'Option 1';
  late List<String> _list;

  String _authToken = "";
  List<String> _countryList = ['Select Country'];
  List<String> _stateList = ['Select State'];
  List<String> _cityList = ['Select City'];
  String _choosedCountry = "";
  String _choosedState = "";
  String _choosedCity = "";

  @override
  void initState() {
    super.initState();
    // Call the fetchData method when the widget is first created
    fetchToken();

    // Initialize _list
    _list = ['Developer', 'Designer', 'Consultant', 'Student'];
  }

  Future <void> fetchToken() async{
    await dotenv.load();

    var url = Uri.parse("https://www.universal-tutorial.com/api/getaccesstoken");

    var headers = {
      "Accept": "application/json",
      "api-token": '${dotenv.env['API_KEY_LOCATION']}',
      "user-email": "pradanaaldi17@gmail.com"
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Successfully got response
      var responseBody = jsonDecode(response.body);
      _authToken = responseBody['auth_token'];
      fetchCountry();
      // Process response here
    } else {
      // Failed to get response
      // print('Failed to fetch data: ${response.reasonPhrase}');
    }

  }

  Future<List<String>> fetchCountry() async {
    await dotenv.load();

    var url = Uri.parse("https://www.universal-tutorial.com/api/countries/");

    var headers = {
      "Authorization": "Bearer $_authToken",
      "Accept": "application/json"
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Successfully got response
      var countries = jsonDecode(response.body); // Parse response body

      for (var country in countries) {
        // Iterate through each country object
        String countryName = country['country_name']; // Get country name
        _countryList.add(countryName); // Add country name to the list

      }
      return _countryList; // Return the list of country names

    } else {
      // Failed to get response
      // print('Failed to fetch data: ${response.reasonPhrase}');
      return []; // Return an empty list if there's an error
    }
  }

  Future<List<String>> fetchState() async {
    await dotenv.load();

    var url = Uri.parse('${dotenv.env['BASE_URL_STATE']}/${_choosedCountry}');

    var headers = {
      "Authorization": "Bearer $_authToken",
      "Accept": "application/json"
    };

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Successfully got response
      var states = jsonDecode(response.body); // Parse response body

      _stateList.clear();
      for (var state in states) {
        // Iterate through each country object
        String stateName = state['state_name']; // Get country name
        _stateList.add(stateName); // Add country name to the list
      }
      return _stateList;

    } else {
      // Failed to get response
      // print('Failed to fetch data: ${response.reasonPhrase}');
      return []; // Return an empty list if there's an error
    }
  }

  Future<List<String>> fetchCity() async {
    await dotenv.load();

    var url = Uri.parse('${dotenv.env['BASE_URL_CITY']}/${_choosedState}');
    print(url);
    var headers = {
      "Authorization": "Bearer $_authToken",
      "Accept": "application/json"
    };

    var response = await http.get(url, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      // Successfully got response
      var cities = jsonDecode(response.body); // Parse response body

      _cityList.clear();
      for (var city in cities) {
        // Iterate through each country object
        String cityName = city['city_name']; // Get country name
        _cityList.add(cityName); // Add country name to the list

      }
      print(_cityList);
      return _cityList; // Return the list of country names

    } else {
      // Failed to get response
      // print('Failed to fetch data: ${response.reasonPhrase}');
      return []; // Return an empty list if there's an error
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
          ),
          SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:
                              Icon(Icons.keyboard_arrow_left_rounded, size: 40),
                        ),
                        Center(
                          child: Image.asset(
                            "assets/Maps.png",
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        // color: Colors.blueAccent,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFAECDFF).withOpacity(1),
                                blurRadius: 40,
                                spreadRadius: 1,
                                offset: const Offset(0, -2),
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF5896FD), // Warna gradient ke bawah
                                Color(0xFFAECDFF), // Warna gradient dari atas
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                child: Text(
                                  "CHOOSE LOCATION",
                                  style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: -1),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Country",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "ITC"),
                                  ),
                                  CustomDropdown<String>(
                                    hintText: 'Select job role',
                                    items: _countryList,
                                    initialItem: _countryList[0],
                                    onChanged: (value) {
                                      setState(() {
                                        _choosedCountry = value;
                                        fetchState();
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "State",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "ITC"),
                                  ),
                                  CustomDropdown<String>(
                                    hintText: 'Select job role',
                                    items: _stateList,
                                    initialItem: _stateList[0],
                                    onChanged: (value) {
                                      setState(() {
                                        _choosedState = value;
                                        fetchCity();
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    "City",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "ITC"),
                                  ),
                                  CustomDropdown<String>(
                                    hintText: 'Select job role',
                                    items: _cityList,
                                    initialItem: _cityList[0],
                                    onChanged: (value) {
                                      print('changing value to: $value');
                                      _choosedCity = value;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Center(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all<
                                                    EdgeInsetsGeometry>(
                                                const EdgeInsets.fromLTRB(
                                                    30, 15, 30, 15)),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              const Color(0xFF806EF8),
                                            )),
                                        onPressed: () {
                                          Navigator.pop(context, _choosedCity);
                                        },
                                        child: const Text(
                                          "Track It On",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins",
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
