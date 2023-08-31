// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// class datapage extends StatelessWidget {
//   const datapage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('صفحه دوم'),
//       ),
//       body: FutureBuilder(
//         future: _getWeatherDataFromHive(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return const Center(child: Text('خطا در بارگذاری اطلاعات'));
//             } else {
//               var weatherData = snapshot.data;
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('دما: ${weatherData!['temp']}'),
//                     Text('وضعیت هوا: ${weatherData['description']}'),
//                     // دیگر اطلاعات مورد نیاز
//                   ],
//                 ),
//               );
//             }
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }

//   Future<Map<String, dynamic>> _getWeatherDataFromHive() async {
//     final weatherBox = Hive.box('weatherBox');
//     var weatherData = weatherBox.get('weatherData');
//     if (weatherData == null) {
//       return {};
//     }
//     return Map<String, dynamic>.from(weatherData);
//   }
// }

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class WeatherHistory {
//  final DateTime time;
  final dynamic temperature;

  WeatherHistory({required this.temperature});
}

class _SecondPageState extends State<SecondPage> {
  final List<WeatherHistory> weatherHistoryList = [];

  @override
  void initState() {
    super.initState();
    _initializeHive();
    _loadWeatherHistory();
  }

  Future<void> _initializeHive() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    await Hive.openBox('weatherBox');
  }

  void _loadWeatherHistory() async {
    final weatherBox = Hive.box('weatherBox');
    for (var key in weatherBox.keys) {
      final weatherData = weatherBox.get(key);
      if (weatherData != null) {
        //  final DateTime time = weatherData['time'];
        final temperature = weatherData['temp'];
        final weatherHistory = WeatherHistory(temperature: temperature);
        weatherHistoryList.add(weatherHistory);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تاریخچه فراخوانی ها'),
      ),
      body: ListView.builder(
        itemCount: weatherHistoryList.length,
        itemBuilder: (context, index) {
          final WeatherHistory weatherHistory = weatherHistoryList[index];
          return ListTile(
            // title: Text(
            //   'تاریخ و ساعت: ${weatherHistory.time.toLocal()}',
            //   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            subtitle: Text(
              'دما: ${weatherHistory.temperature.toString()}',
              style: const TextStyle(fontSize: 14),
            ),
          );
        },
      ),
    );
  }
}
