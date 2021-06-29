import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshops/screens/home_page.dart';
import 'package:generalshops/screens/onboarding/onboarding_model.dart';
import 'package:generalshops/screens/onboarding/onboarding_screen.dart';
import 'package:generalshops/screens/utilities/screen_utilities.dart';
import 'package:generalshops/screens/utilities/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  double screenWidth;
  double screenHeight;
  int currentIndex = 0;
  bool lastPage = false;
  PageController _pageController;
  List<OnBoardingModel> screens = [
    OnBoardingModel(
        image: "assets/images/onboarding1.jpg",
        title: "!مرحبا",
        description:
            "هنا تجدون متعة التسوق وسهولة التسوق اطلب منتجك وانت في منزلك "),
    OnBoardingModel(
        image: "assets/images/onboarding2.jpg",
        title: "اطلب منتجك",
        description:
            "يمكنك طلب منتجك وانت في المنزل وسوف يتم توصيل منتجك الي باب منزلك "),
    OnBoardingModel(
        image: "assets/images/onboarding3.jpg",
        title: "متعة التسوق",
        description:
            "يوجد متعة في التسوق بحيث يمكنك اضافة منتجاتك التي تعجبك واضافتها في العربة بكل سهولة وبعد الانتعاء من التسوق يمكنك تنفيذ الطلب مباشرة"),
  ];

  ScreenConfig screenConfig;
  WidgetSize widgetSize;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenConfig = ScreenConfig(context);
    widgetSize = WidgetSize(screenConfig);
    // print(screenConfig.screenType);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double _mt = MediaQuery.of(context).size.height * 0.1;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top: _mt),
              height: screenHeight,
              width: screenWidth,
              color: Colors.white,
              child: PageView.builder(
                controller: _pageController,
                itemCount: screens.length,
                itemBuilder: (BuildContext context, int position) {
                  return SingleOnBoarding(screens[position]);
                },
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                    if (index == (screens.length - 1)) {
                      lastPage = true;
                    } else {
                      lastPage = false;
                    }
                  });
                },
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0, -(screenWidth * 0.22)),
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _drawDots(screens.length),
              ),
            ),
          ),
          (lastPage) ? _showButton() : Container(),
        ],
      ),
    );
  }

  Widget _showButton() {
    return Container(
        child: Transform.translate(
      offset: Offset(0, -(screenHeight * 0.05)),
      child: SizedBox(
        width: screenWidth * 0.75,
        height: widgetSize.buttonHeight,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(34)),
          color: ScreenUtilities.mainBlue,
          onPressed: () async {
            WidgetsFlutterBinding.ensureInitialized();
            var pref = await SharedPreferences.getInstance();
            pref.setBool('is_seen', true);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Text(
            'أبدا التسوق',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: widgetSize.buttonFontSize,
                letterSpacing: 3),
          ),
        ),
      ),
    ));
  }

  List<Widget> _drawDots(int qty) {
    List<Widget> Wigdets = [];
    for (int i = 0; i < qty; i++) {
      Wigdets.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: (i == currentIndex)
                ? ScreenUtilities.mainBlue
                : ScreenUtilities.LightGrey,
          ),
          width: widgetSize.pagerDotsWidth,
          height: widgetSize.pagerDotsHeight,
          margin: (i == qty - 1)
              ? EdgeInsets.only(right: 24)
              : EdgeInsets.only(right: 24),
        ),
      );
    }
    return Wigdets;
  }
}
