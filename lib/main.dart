import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:generalshops/screens/home_page.dart';
import 'package:generalshops/screens/onboarding/onboarding.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  bool isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();

  if (isSeen == null || !isSeen) {
    homePage = OnBoarding();
  }

  runApp(GeneralShop(homePage));
}

class GeneralShop extends StatelessWidget {
  final Widget homePage;
  GeneralShop(this.homePage);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', 'AE'), // English, no country code
        const Locale('es', ''), // Spanish, no country code
      ],
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(),
        primaryColor: Colors.white,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          headline: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: ScreenUtilities.textColor,
          ),
          subhead: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: ScreenUtilities.textColor,
          ),
          display1: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: ScreenUtilities.darkerGreyText,
          ),
          display2: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.75,
            letterSpacing: 1,
            color: ScreenUtilities.darkerGreyText,
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: ScreenUtilities.textColor,
          ),
          textTheme: TextTheme(
            // ignore: deprecated_member_use
            title: TextStyle(
              color: ScreenUtilities.textColor,
              fontFamily: " Quicksand",
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: ScreenUtilities.textColor,
          labelStyle: TextStyle(
            fontFamily: "Quicksand",
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
          labelPadding:
              EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 14),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: ScreenUtilities.unselected,
          unselectedLabelStyle: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            fontFamily: "Quicksand",
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ScreenUtilities.mainBlue,
        ),
      ),
    );
  }
}
