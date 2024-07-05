import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worktime/screens/splashScreen.dart';
import 'package:worktime/screens/color_provider.dart';
import 'package:worktime/screens/login.dart';
import 'package:worktime/screens/bottonbar.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ColorProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Splashscreen(),
        routes: {
          '/login': (context) => const Login(),
          '/bottombar': (context) => const BottonBar(),
        },
      ),
    );
  }
}
  