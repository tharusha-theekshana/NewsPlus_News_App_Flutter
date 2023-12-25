import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newsapp/View/screens/home_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newsapp/View/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NewsPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: box.read("theme") == null || box.read("theme") != "dark"
          ? ThemeMode.light
          : ThemeMode.dark,
      home: SplashScreen(),
    );
  }
}
