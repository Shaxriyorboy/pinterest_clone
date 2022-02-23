import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pinterest_app/pages/home_page.dart';
import 'package:pinterest_app/pages/home_photo_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pinterest_app/pages/search_page.dart';
import 'package:pinterest_app/pages/splesh_page.dart';
import 'package:pinterest_app/services/db_service.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox(DBService.dbName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) { 
        return MaterialApp(
          title: 'Pinterest',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SpleshPage(),
          debugShowCheckedModeBanner: false,
          routes: {
            HomePhoto.id:(context) => HomePhoto(),
            HomePage.id:(context) => HomePage(),
            SearchPage.id:(context) => SearchPage(),
          },
        );
      },
      valueListenable: DBService.box.listenable(),
    );
  }
}

