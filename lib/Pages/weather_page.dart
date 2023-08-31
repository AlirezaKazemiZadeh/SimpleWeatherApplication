import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Pages/data_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  static const API_key = '5360942d4f43add177f84f37183adf4d';

  const WeatherPage({super.key});
  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

// int SIngOutCheck = 0;
// void SingUserOut() {
//   if (SIngOutCheck == 0) {
//     Fluttertoast.showToast(
//         msg: "برای خروج دوباره بازگشت را بزنید",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.SNACKBAR,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Color.fromARGB(255, 255, 255, 255),
//         textColor: Color.fromARGB(255, 0, 0, 0),
//         fontSize: 16.0);
//     SIngOutCheck++;
//   } else if (SIngOutCheck == 1) {
//     FirebaseAuth.instance.signOut();
//     SIngOutCheck = 0;
//   }
// }

class _WeatherPageState extends State<WeatherPage> {
  var temp;
  var discription;
  var currently;
  var humidity;
  var windspeed;

  Future<bool> _checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  Future<void> _fetchAndSaveWeatherData() async {
    try {
      Uri url = Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=Tehran&units=metric&appid=${WeatherPage.API_key}');
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        setState(() {
          temp = result['main']['temp'];
          discription = result['weather'][0]['description'];
          currently = result['weather'][0]['main'];
          humidity = result['main']['humidity'];
          windspeed = result['wind']['speed'];
        });
        await _saveWeatherDataToHive();
      } else {
        await _loadWeatherDataFromHive();
      }
    } catch (e) {
      await _loadWeatherDataFromHive();
    }
  }

  Future<void> _saveWeatherDataToHive() async {
    final weatherBox = Hive.box('weatherBox');
    var weatherData = {
      'temp': temp,
      'description': discription,
      'currently': currently,
      'humidity': humidity,
      'windspeed': windspeed,
    };
    await weatherBox.put('weatherData', weatherData);
  }

  Future<void> _loadWeatherDataFromHive() async {
    final weatherBox = Hive.box('weatherBox');
    var weatherData = weatherBox.get('weatherData');
    if (weatherData != null) {
      setState(() {
        temp = weatherData['temp'];
        discription = weatherData['description'];
        currently = weatherData['currently'];
        humidity = weatherData['humidity'];
        windspeed = weatherData['windspeed'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // getWeather();
    _initializeData();
  }

  void _initializeData() async {
    bool hasInternetConnection = await _checkInternetConnection();

    if (hasInternetConnection) {
      await _fetchAndSaveWeatherData();
    } else {
      await _loadWeatherDataFromHive();
    }
  }

  Widget _getWeatherImage(String? currently) {
    switch (currently) {
      case 'Clouds':
        return Lottie.asset('assets/animation/cloud.json',
            height: 110, width: 200);
      case 'Clear':
        return Lottie.asset('assets/animation/clear.json',
            height: 100, width: 200);
      case 'Drizzle':
        return Lottie.asset('assets/animation/drizzle.json',
            height: 100, width: 200);
      case 'Thunderstorm':
        return Lottie.asset('assets/animation/thunderstorm.json',
            height: 110, width: 200);
      case 'Snow':
        return Lottie.asset('assets/animation/snow.json',
            height: 100, width: 200);
      case 'Mist':
        return Lottie.asset('assets/animation/mist.json',
            height: 100, width: 200);
      case 'Fog':
        return Lottie.asset('assets/animation/mist.json',
            height: 110, width: 200);
      case 'Smoke':
        return Lottie.asset('assets/animation/mist.json',
            height: 100, width: 200);
      case 'Haze':
        return Lottie.asset('assets/animation/mist.json',
            height: 100, width: 200);
      case 'Dust':
        return Lottie.asset('assets/animation/mist.json',
            height: 110, width: 200);
      case 'Sand':
        return Lottie.asset('assets/animation/squall.json',
            height: 100, width: 200);
      case 'Ash':
        return Lottie.asset('assets/animation/fog.json',
            height: 100, width: 200);
      case 'Squall':
        return Lottie.asset('assets/animation/squall.json',
            height: 110, width: 200);
      case 'Tornado':
        return Lottie.asset('assets/animation/tornado.json',
            height: 100, width: 200);
      case 'Rain':
        return Lottie.asset('assets/animation/rain.json',
            height: 100, width: 200);
      default:
        return Lottie.asset('assets/animation/defualt.json',
            height: 100, width: 200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 244, 255),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 62, 213, 226),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            "دمای کنونی هوا در تهران",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Sahel',
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          temp != null ? "$temp\u00B0" : "در حال بارگذاری",
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: currently != null
                              ? _getWeatherImage(currently)
                              : const Text("در حال بارگذاری"),
                        ),
                      ]),
                ),
              ),
            ],
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.thermometerHalf),
                  title: const Text(
                    "Tempreture:",
                    style: TextStyle(),
                  ),
                  trailing:
                      Text(temp != null ? "$temp\u00B0" : "در حال بارگذاری"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.cloud),
                  title: const Text(
                    "Weather:",
                    style: TextStyle(),
                  ),
                  trailing: Text(discription != null
                      ? discription.toString()
                      : "در حال بارگذاری"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.sun),
                  title: const Text(
                    "temperature humidity:",
                    style: TextStyle(),
                  ),
                  trailing: Text(humidity != null
                      ? humidity.toString()
                      : "در حال بارگذاری"),
                ),
                ListTile(
                  leading: const FaIcon(FontAwesomeIcons.wind),
                  title: const Text(
                    "Wind Speed:",
                    style: TextStyle(),
                  ),
                  trailing: Text(windspeed != null
                      ? windspeed.toString()
                      : "در حال بارگذاری"),
                ),
                ElevatedButton(
                  onPressed: () {
                    //   _saveWeatherDataToHive();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const datapage()),
                    );
                  },
                  child: const Text('ذخیره اطلاعات'),
                ),
              ],
            ),
          ))
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromARGB(255, 221, 244, 255),
        color: const Color.fromARGB(255, 104, 166, 169),
        height: 50,
        animationDuration: const Duration(milliseconds: 500),
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
            //  SIngOutCheck = 0;
          }
          if (index == 1) {
            //  getWeather();
            _initializeData();
            //  SIngOutCheck = 0;
            Fluttertoast.showToast(
                msg: "بارگذاری اطلاعات جدید..",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                textColor: const Color.fromARGB(255, 0, 0, 0),
                fontSize: 16.0);
          }
        },
        items: const [
          Icon(Icons.last_page, color: Color.fromARGB(255, 221, 244, 255)),
          Icon(Icons.refresh, color: Color.fromARGB(255, 221, 244, 255)),
        ],
      ),
    );
  }
}
