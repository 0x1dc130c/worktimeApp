import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:worktime/firebase_options.dart';
import 'package:worktime/screens/splashScreen.dart';
import 'package:worktime/screens/color_provider.dart';
import 'package:worktime/screens/login.dart';
import 'package:worktime/screens/bottonbar.dart';
import 'package:worktime/screens/editHistory.dart';
import 'package:worktime/repository/user_repository/user_repository.dart';

Future <void> main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Get.put(UserRepository());
  
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
          // '/editHistory': (context) => EditHistory(),
        },
      ),
    );
  }
}
  