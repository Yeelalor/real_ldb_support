import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testflutter/provider/login_provider.dart';
import 'package:testflutter/screens/home_screen.dart';
import 'package:testflutter/screens/splash.dart';
import './screens/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => login_provider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Listener(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFF3C98CE),
            Color(0xFF2171A1),
            Color(0xFF144D70),
          ]),
        ),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              bottomSheetTheme:
                  const BottomSheetThemeData(backgroundColor: Colors.white),
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.transparent,
              backgroundColor: const Color(0xff246ab2),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'NotoSans',
              focusColor: const Color(0xff246ab2),
              appBarTheme: const AppBarTheme(
                color: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
                titleTextStyle: TextStyle(
                    fontSize: 20,
                    fontFamily: 'NotoSans',
                    fontWeight: FontWeight.normal),
                centerTitle: true,
                // systemOverlayStyle: SystemUiOverlayStyle.light
              ),
            ),
            // home: const Login()),
            home: const SplashPage()),
      ),
    );
  }
}
