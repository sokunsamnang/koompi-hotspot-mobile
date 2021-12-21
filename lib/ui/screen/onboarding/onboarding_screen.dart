import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:koompi_hotspot/all_export.dart';
import 'package:koompi_hotspot/ui/screen/login/login_phone.dart';
import 'package:koompi_hotspot/ui/screen/onboarding/styles.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = <Slide>[];

  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        title: 'Connect people\naround the world',
        styleTitle: kTitleStyle,
        description: 'KOOMPI Fi-Fi is accessable and affordable',
        styleDescription: kSubtitleStyle,
        pathImage: "assets/images/onboarding0.png",
      ),
    );
    slides.add(
      new Slide(
        title: 'Live your life smarter with us!',
        styleTitle: kTitleStyle,
        description: 'For everyone and KOOMPI\'s school partner',
        styleDescription: kSubtitleStyle,
        pathImage: "assets/images/onboarding1.png",
      ),
    );
    slides.add(
      new Slide(
        title: 'Get a new experience of imagination',
        styleTitle: kTitleStyle,
        description:
            'We all are connected by the internet, like neurons in a giant brain',
        styleDescription: kSubtitleStyle,
        pathImage: "assets/images/onboarding2.png",
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: LoginPhone(),
      ),
      ModalRoute.withName('/loginPhone'),
    );
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Color(0xFFFFFFFF),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Color(0xFFFFFFFF),
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Color(0xFFFFFFFF),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = <Widget>[];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  child: Text(
                    currentSlide.description,
                    style: currentSlide.styleDescription,
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                  margin: EdgeInsets.only(top: 20.0),
                ),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      // slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      colorSkipBtn: Color(0xFF4563DB),
      highlightColorSkipBtn: Color(0xFF5036D5),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      colorDoneBtn: Color(0xFF4563DB),
      highlightColorDoneBtn: Color(0xFF5036D5),

      // Dot indicator
      colorDot: Color(0xFFFFFFFF),
      sizeDot: 13.0,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Color(0xFF5036D5),
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: BouncingScrollPhysics(),

      // Show or hide status bar
      hideStatusBar: false,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
