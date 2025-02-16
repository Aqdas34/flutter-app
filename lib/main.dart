import 'package:flutter/material.dart';
import 'package:only_shef/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'pages/splash/screen/splash_screen.dart';

// import 'package:only_shef/pages/splash/screen/splash_screen.dart';
// import 'package:only_shef/utils/custome_nav_bar.dart';
// import 'package:only_shef/pages/splash/screen/splash_screen.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
