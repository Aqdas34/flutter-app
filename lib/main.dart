import 'package:flutter/material.dart';
import 'package:only_shef/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'pages/splash/screen/splash_screen.dart';

// import 'package:only_shef/pages/splash/screen/splash_screen.dart';
// import 'package:only_shef/utils/custome_nav_bar.dart';
// import 'package:only_shef/pages/splash/screen/splash_screen.dart';
var screen_height;
var screen_width;

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    screen_height = MediaQuery.of(context).size.height;
    screen_width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [routeObserver],
      home: SplashScreen(),
    );
  }
}
