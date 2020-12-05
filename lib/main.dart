import 'package:chill_bro/ContactUSPage.dart';
import 'package:chill_bro/HomePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chill_bro/NOTE.dart';
import 'package:admob_flutter/admob_flutter.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            "Loading...",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chill Bro",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        "/contactUs": (BuildContext context) => ContactUSPage(),
        "/note": (BuildContext context) => Note(),
      },
    );
  }
}
