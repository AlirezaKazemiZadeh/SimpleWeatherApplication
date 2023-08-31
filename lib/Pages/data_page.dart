import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class datapage extends StatelessWidget {
  const datapage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحه دوم'),
      ),
      body: FutureBuilder(
        future: _getWeatherDataFromHive(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(child: Text('خطا در بارگذاری اطلاعات'));
            } else {
              var weatherData = snapshot.data;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('دما: ${weatherData!['temp']}'),
                    Text('وضعیت هوا: ${weatherData['description']}'),
                    // دیگر اطلاعات مورد نیاز
                  ],
                ),
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Map<String, dynamic>> _getWeatherDataFromHive() async {
    final weatherBox = Hive.box('weatherBox');
    var weatherData = weatherBox.get('weatherData');
    if (weatherData == null) {
      return {};
    }
    return Map<String, dynamic>.from(weatherData);
  }
}
