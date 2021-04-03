import 'package:flutter/material.dart';
import 'package:hypervolt_ble/providers/ble.dart';
import 'package:hypervolt_ble/providers/themeChanger.dart';
import 'package:hypervolt_ble/routeGenerator.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => BLENotifier()),
        ChangeNotifierProvider(create: (ctx) => ThemeChanger()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      title: 'Bluetooth Scanner',
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: TextTheme(
            bodyText1: GoogleFonts.montserrat(color: Colors.white),
            subtitle1: GoogleFonts.montserrat(color: Colors.white),
          ),
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.black),
      themeMode: themeChanger.getTheme,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        textTheme: TextTheme(
          bodyText1: GoogleFonts.montserrat(color: Colors.black87),
          subtitle1: GoogleFonts.montserrat(color: Colors.black87),
        ),
      ),
      initialRoute: '/scan',
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
