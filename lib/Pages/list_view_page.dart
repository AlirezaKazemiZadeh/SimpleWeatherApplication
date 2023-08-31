import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/Locations/Iran_Ardabil.dart';
import 'package:flutter_application_2/Locations/Iran_Bushehr.dart';
import 'package:flutter_application_2/Locations/Iran_Gilan.dart';
import 'package:flutter_application_2/Locations/Iran_Golestan.dart';
import 'package:flutter_application_2/Locations/Iran_Hamadan.dart';
import 'package:flutter_application_2/Locations/Iran_Hormozgan.dart';
import 'package:flutter_application_2/Locations/Iran_Ilam.dart';
import 'package:flutter_application_2/Locations/Iran_Isfahan.dart';
import 'package:flutter_application_2/Locations/Iran_Mazandaran.dart';
import 'package:flutter_application_2/Locations/Iran_Shiraz.dart';
import 'package:flutter_application_2/Locations/Iran_Yazd.dart';
import 'package:flutter_application_2/Pages/weather_page.dart';

import '../Locations/Iran_Alborz.dart';
import '../Locations/Iran_Birjand.dart';
import '../Locations/Iran_Bojnord.dart';
import '../Locations/Iran_Chaharmahal.dart';
import '../Locations/Iran_Kordestan.dart';
import '../Locations/Iran_Lorestan.dart';
import '../Locations/Iran_Markazi.dart';
import '../Locations/Iran_Mashhad.dart';
import '../Locations/Iran_Qazvin.dart';
import '../Locations/Iran_Semnan.dart';
import '../Locations/Iran_Sistan.dart';
import '../Locations/Iran_Tabriz.dart';
import '../Locations/Iran_Urmia.dart';
import '../Locations/Iran_Yasoj.dart';
import '../Locations/Iran_Zanjan.dart';
import '../Locations/Iran_qom.dart';
import '../Locations/Khozestan.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class CityImage {
  final String cityName;
  final String imagePath;

  CityImage({required this.cityName, required this.imagePath});
}

List<CityImage> cityImages = [
  CityImage(cityName: 'تهران', imagePath: 'assets/images/tehran3.png'),
  CityImage(cityName: 'اصفهان', imagePath: 'assets/images/Isfahan3.png'),
  CityImage(cityName: 'شیراز', imagePath: 'assets/images/shiraz3.png'),
  CityImage(cityName: 'اردبیل', imagePath: 'assets/images/ardabil3.png'),
  CityImage(cityName: 'بوشهر', imagePath: 'assets/images/busherhr3.png'),
  CityImage(cityName: 'گیلان', imagePath: 'assets/images/gilan3.png'),
  CityImage(cityName: 'گلستان', imagePath: 'assets/images/golestan3.png'),
  CityImage(cityName: 'همدان', imagePath: 'assets/images/hamedan3.png'),
  CityImage(cityName: 'هرمزگان', imagePath: 'assets/images/hormozgan3.png'),
  CityImage(cityName: 'ایلام', imagePath: 'assets/images/ilam3.png'),
  CityImage(cityName: 'تبریز', imagePath: 'assets/images/tabriz3.png'),
  CityImage(cityName: 'ارومیه', imagePath: 'assets/images/Uromia3.png'),
  CityImage(cityName: 'البرز', imagePath: 'assets/images/alborz3.png'),
  CityImage(
      cityName: 'چهار محال و بختیاری',
      imagePath: 'assets/images/charmahal3.png'),
  CityImage(
      cityName: 'خراسان جنوبی', imagePath: 'assets/images/khorasanjonobi3.png'),
  CityImage(cityName: 'مشهد', imagePath: 'assets/images/mashhad3.png'),
  CityImage(
      cityName: 'خراسان شمالی',
      imagePath: 'assets/images/khorasanshomali3.png'),
  CityImage(cityName: 'خوزستان', imagePath: 'assets/images/khozestan3.png'),
  CityImage(cityName: 'زنجان', imagePath: 'assets/images/zanjan3.png'),
  CityImage(cityName: 'سمنان', imagePath: 'assets/images/semnan3.png'),
  CityImage(
      cityName: 'سیستان و بلوچستان', imagePath: 'assets/images/sistan3.png'),
  CityImage(cityName: 'قزوین', imagePath: 'assets/images/qazvin3.png'),
  CityImage(cityName: 'قم', imagePath: 'assets/images/qom3.png'),
  CityImage(cityName: 'کردستان', imagePath: 'assets/images/kordestan3.png'),
  CityImage(
      cityName: 'کهگیلویه و بویراحمد',
      imagePath: 'assets/images/kohkiloie3.png'),
  CityImage(cityName: 'لرستان', imagePath: 'assets/images/lorestan3.png'),
  CityImage(cityName: 'مازندران', imagePath: 'assets/images/mazandaran3.png'),
  CityImage(cityName: 'مرکزی', imagePath: 'assets/images/markazi3.png'),
  CityImage(cityName: 'یزد', imagePath: 'assets/images/yazd3.png'),
];

class _ListViewPageState extends State<ListViewPage> {
  // List<String> items = [
  //   'شیراز',
  //   'اردبیل',
  //   'بوشهر',
  //   'گیلان',
  //   'گلستان',
  //   'همدان',
  //   'هرمزگان',
  //   'ایلام',
  //   'تبریز',
  //   'ارومیه',
  //   'البرز',
  //   'چهار محال و بختیاری',
  //   'خراسان جنوبی',
  //   'مشهد',
  //   'خراسان شمالی',
  //   'خوزستان',
  //   'زنجان',
  //   'سمنان',
  //   'سیستان و بلوچستان',
  //   'قزوین',
  //   'قم',
  //   'کردستان',
  //   'کهگیلویه و بویراحمد',
  //   'لرستان',
  //   'مازندران',
  //   'مرکزی',
  //   'یزد',
  // ];

//reorder method

  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      //تغیر مورد نیاز برای جابهجایی از بالا به پایین
      if (oldIndex < newIndex) {
        newIndex--;
      }

      //get the tile we are moving
      final tile = cityImages.removeAt(oldIndex);

      //place the tile in the new position
      cityImages.insert(newIndex, tile);
    });
  }

  //Color tileColor = Colors.white;
  // sing user out
  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // برگشت به صفحه قبلی
    }
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => LoginOrRegisterPage()), // صفحه ورود کاربر
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 242),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: signUserOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
        ],
        title: const Text('استان مورد نظر را انتخاب کنید'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 104, 166, 169),
        titleTextStyle: const TextStyle(
            fontFamily: 'Vazir',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )),
      ),
      body: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        // color: Color.fromARGB(255, 221, 244, 255),
        margin: const EdgeInsetsDirectional.all(10),
        color: const Color.fromARGB(255, 240, 240, 242),
        child: ReorderableListView(
          children: [
            for (final tile in cityImages)
              ListTile(
                key: ValueKey(tile),
                title: RichText(
                  text: TextSpan(
                    text: tile.cityName,
                    style: const TextStyle(
                      fontFamily: 'Sahel',
                      fontSize: 16,
                      color: Color.fromARGB(255, 13, 15, 68),
                    ),
                  ),
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage(tile.imagePath),
                ),
                //isThreeLine: true,

                shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 255, 255, 255))),
                contentPadding: const EdgeInsets.all(10),
                subtitle: const Text('Iran'),
                tileColor: const Color.fromARGB(255, 146, 173, 199),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 13, 15, 68),
                ),
                dense: true,
                onTap: () {
                  if (tile.cityName == 'تهران') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WeatherPage()),
                    );
                  }
                  if (tile.cityName == 'اصفهان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IsfahanPage()),
                    );
                  }
                  if (tile.cityName == 'شیراز') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShirazPage()),
                    );
                  }
                  if (tile.cityName == 'اردبیل') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ArdabilPage()),
                    );
                  }
                  if (tile.cityName == 'بوشهر') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BushehrPage()),
                    );
                  }
                  if (tile.cityName == 'گیلان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GilanPage()),
                    );
                  }
                  if (tile.cityName == 'گلستان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GolestanPage()),
                    );
                  }
                  if (tile.cityName == 'همدان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HamadanPage()),
                    );
                  }
                  if (tile.cityName == 'هرمزگان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HormozganPage()),
                    );
                  }
                  if (tile.cityName == 'ایلام') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IlamPage()),
                    );
                  }
                  if (tile.cityName == 'تبریز') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TabrizPage()),
                    );
                  }
                  if (tile.cityName == 'ارومیه') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UrmiaPage()),
                    );
                  }
                  if (tile.cityName == 'البرز') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AlborzPage()),
                    );
                  }
                  if (tile.cityName == 'چهار محال و بختیاری') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChaharmahalPage()),
                    );
                  }
                  if (tile.cityName == 'خراسان جنوبی') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BirjandPage()),
                    );
                  }
                  if (tile.cityName == 'مشهد') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MashhadPage()),
                    );
                  }
                  if (tile.cityName == 'خراسان شمالی') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BojnordPage()),
                    );
                  }
                  if (tile.cityName == 'خوزستان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KhozestanPage()),
                    );
                  }
                  if (tile.cityName == 'زنجان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ZanjanPage()),
                    );
                  }
                  if (tile.cityName == 'سمنان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Semnanpage()),
                    );
                  }
                  if (tile.cityName == 'سیستان و بلوچستان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SistanPage()),
                    );
                  }
                  if (tile.cityName == 'قزوین') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QazvinPage()),
                    );
                  }
                  if (tile.cityName == 'قم') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => QomPage()),
                    );
                  }
                  if (tile.cityName == 'کردستان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KordestanPage()),
                    );
                  }
                  if (tile.cityName == 'کهگیلویه و بویراحمد') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YasojPage()),
                    );
                  }
                  if (tile.cityName == 'لرستان') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LorestanPage()),
                    );
                  }
                  if (tile.cityName == 'مازندران') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MazandaranPage()),
                    );
                  }
                  if (tile.cityName == 'مرکزی') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MarkaziPage()),
                    );
                  }
                  if (tile.cityName == 'یزد') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YazdPage()),
                    );
                  }
                },
              ),
          ],
          onReorder: (oldIndex, newIndex) => updateMyTiles(oldIndex, newIndex),
        ),
      ),
    );
  }
}
