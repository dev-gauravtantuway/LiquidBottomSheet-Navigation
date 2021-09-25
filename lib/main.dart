import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'liquid_navigation/liquid_nav_custom_painter.dart';
import 'screen/bnb.dart';
import 'liquid_navigation/custom_page_route.dart';
import 'screen/home_page.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Liquid Bottom Sheet',
      home: MyHomePage(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  // FIRST SHEET

  late AnimationController firstSheetBumpCon;
  late AnimationController firstAniCon;

  late Animation firstAni;
  late Animation firstAniBump;

  double firstBumpHeight = 120;
  double firstBumpPointerLocation = 0;
  double firstBumpPointerLocationSec = 1;
  int firstIconPadding = 25;

  bool isFirstSheetClosed = true;
  bool hasFirstSheetPassedHalf = false;
  bool firstBumpIconOpac = true;

  // SECOND SHEET

  late AnimationController secondSheetCon;
  late AnimationController secondSheetBumpCon;
  late AnimationController secondBumpCon;

  late Animation secondBumpAni;
  late Animation secondSheetAni;
  late Animation secondBumpAniSec;

  double secondBumpHeight = 120;
  double secondBumpPointerLocation = 0;
  double secondBumpPointerLocationSec = 1;

  bool isSecondSheetClosed = true;
  bool secondBumpIconOpac = true;
  bool secondSheetBlursFirstSheet = true;
  bool hasSecondSheetPassedHalf = false;
  bool secondBump = false;

  // THIRD SHEET

  late AnimationController thirdSheetCon;
  late AnimationController thirdSheetBumpCon;
  late AnimationController thirdBumpCon;

  late Animation thirdBumpAni;
  late Animation thirdSheetAni;
  late Animation thirdBumpAniSec;

  double thirdBumpHeight = 120;
  double thirdBumpPointerLocation = 0;
  double thirdBumpPointerLocationSec = 1;

  bool thirdSheetBlursFirstSheet = true;
  bool hasThirdSheetPassedHalf = false;
  bool thirdBump = false;

  @override
  void initState() {

    // INITIALIZING FIRST SHEET

    firstAniCon = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 500),
    );

    firstAni = Tween<double>(begin: 0.741, end: 0).animate(
      CurvedAnimation(
          parent: firstAniCon,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondBumpCon.forward();
          isFirstSheetClosed = false;
        } else if (status == AnimationStatus.dismissed) {
          isFirstSheetClosed = true;
          firstBumpPointerLocation = 0;
          firstBumpPointerLocationSec = 1;
          firstIconPadding = 25;
        } else if (status == AnimationStatus.forward) {
          firstBumpIconOpac = false;
          firstIconPadding = 0;
          firstSheetBumpCon.forward().whenComplete(() {
            hasFirstSheetPassedHalf = true;
          });
        } else if (status == AnimationStatus.reverse) {
          secondBumpCon.reverse();
          firstSheetBumpCon.reset();
          firstBumpIconOpac = true;
          hasFirstSheetPassedHalf = false;
          secondBump = false;
        }
      });

    firstAniBump = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: firstAniCon,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    firstSheetBumpCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 105),
    );

    // INITIALIZING SECOND SHEET

    secondSheetCon = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(milliseconds: 500),
    );

    secondSheetAni = Tween<double>(begin: .741, end: 0).animate(
      CurvedAnimation(
        parent: secondSheetCon,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInCubic,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          thirdBumpCon.forward();
          isSecondSheetClosed = false;
          secondSheetBlursFirstSheet = false;
          secondBumpPointerLocationSec = 1;
        } else if (status == AnimationStatus.dismissed) {
          isSecondSheetClosed = true;
          secondSheetBlursFirstSheet = true;
          secondBumpPointerLocation = 0;
          secondBumpPointerLocationSec = 1;
        } else if (status == AnimationStatus.forward) {
          secondBumpIconOpac = false;
          secondSheetBumpCon.forward().whenComplete(() {
            hasSecondSheetPassedHalf = true;
          });
        } else if (status == AnimationStatus.reverse) {
          secondBumpIconOpac = true;
          thirdBumpCon.reverse();
          thirdSheetCon.reverse();
          secondSheetBumpCon.reset();
          thirdBump = false;
          hasSecondSheetPassedHalf = false;
        }
      });

    secondBumpAniSec = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: secondSheetCon,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    secondBumpCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    secondBumpAni = Tween<double>(begin: .8505, end: .741).animate(
      CurvedAnimation(
        parent: secondBumpCon,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInCubic,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondBump = true;
        }
      });

    secondSheetBumpCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 105),
    );

    // INITIALIZING THIRD SHEET

    thirdSheetCon = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    thirdSheetAni = Tween<double>(begin: .462, end: -1).animate(
      CurvedAnimation(
        parent: thirdSheetCon,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInCubic,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.forward) {
          Navigator.pushAndRemoveUntil(
            context,
            pageTransition(),
            (e) => false,
          );
          thirdSheetBumpCon.forward().whenComplete(() {
              hasThirdSheetPassedHalf = true;
          });
        }
      });

    thirdBumpCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    thirdBumpAni = Tween<double>(begin: .5705, end: .462).animate(
      CurvedAnimation(
        parent: thirdBumpCon,
        curve: Curves.easeOutQuart,
        reverseCurve: Curves.easeInCubic,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
            thirdBump = true;
        }
      });

    thirdSheetBumpCon = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );

    thirdBumpAniSec = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: thirdSheetCon,
        curve: Curves.elasticOut,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    firstSheetBumpCon.dispose();
    firstAniCon.dispose();
    secondBumpCon.dispose();
    secondSheetBumpCon.dispose();
    secondSheetCon.dispose();
    thirdBumpCon.dispose();
    thirdSheetBumpCon.dispose();
    thirdSheetCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [

          // HOME PAGE

          AnimatedBuilder(
            animation: firstAniCon,
            builder: (BuildContext context, Widget? child) {
              return ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: isFirstSheetClosed == true
                      ? 5 * firstBumpPointerLocation
                      : 5 * firstAniCon.value,
                  sigmaY: isFirstSheetClosed == true
                      ? 5 * firstBumpPointerLocation
                      : 5 * firstAniCon.value,
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // home page
                    const HomeScreen(),

                    // // bnb
                    const MyBottomNavigationBar(),

                    // darkness
                    IgnorePointer(
                      ignoring: true,
                      child: Container(
                        height: size.height,
                        width: size.width,
                        color: Colors.black.withOpacity(
                          isFirstSheetClosed == true
                              ? 0.3 * firstBumpPointerLocation
                              : 0.3 * firstAniCon.value,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // FIRST SHEET

          AnimatedBuilder(
              animation: secondSheetCon,
              builder: (context, child) {
                return ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: secondSheetBlursFirstSheet == true
                        ? 5 * secondBumpPointerLocation
                        : 5 * secondSheetCon.value,
                    sigmaY: secondSheetBlursFirstSheet == true
                        ? 5 * secondBumpPointerLocation
                        : 5 * secondSheetCon.value,
                  ),
                  child: AnimatedBuilder(
                    animation: firstAniCon,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, size.height * firstAni.value),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //
                              GestureDetector(
                                onVerticalDragUpdate: (details) {
                                  setState(() {
                                    isFirstSheetClosed == true
                                        ? firstBumpHeight = size.height -
                                            details.globalPosition.dy
                                        : null;
                                    firstBumpPointerLocation = (details.localPosition.dy
                                            .abs()
                                            .clamp(0, 123) /
                                        123);
                                    firstBumpPointerLocationSec =
                                        ((details.globalPosition.dy - 503)
                                                .clamp(0, 126) /
                                            126);
                                  });
                                },
                                onVerticalDragDown: (details) {
                                  isFirstSheetClosed == false
                                      ? firstAniCon.reverse()
                                      : null;
                                },
                                onVerticalDragEnd: (details) {
                                  setState(() {
                                    firstBumpHeight = 120;
                                  });
                                  isFirstSheetClosed == true
                                      ? firstAniCon.forward()
                                      : null;
                                },
                                behavior: HitTestBehavior.translucent,
                                //
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.elasticOut,
                                  height: firstBumpHeight.clamp(120, 200),
                                  width: size.width,
                                  child: CustomPaint(
                                    painter: MyCustomPainter(
                                      firstAniBump.value,
                                      hasFirstSheetPassedHalf,
                                      Colors.black,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topCenter,
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 700),
                                        curve: Curves.ease,
                                        margin: const EdgeInsets.only(top: 17),
                                        padding: EdgeInsets.only(
                                          top: firstIconPadding * firstBumpPointerLocation,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          size: 28,
                                          color: Colors.white.withOpacity(
                                            firstBumpIconOpac == true
                                                ? isFirstSheetClosed == true
                                                    ? 0.9 *
                                                        firstBumpPointerLocationSec
                                                    : 0.9 *
                                                        lerpDouble(
                                                                1,
                                                                0,
                                                                firstAniCon
                                                                    .value)!
                                                            .toDouble()
                                                : 0.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              //
                              //
                              Container(
                                width: double.infinity,
                                height: size.height * .68,
                                color: Colors.black,
                                child: child,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -37),
                          child: Column(
                            children: [
                              Container(
                                height: 4,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.only(bottom: 16),
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.black,
                                alignment: Alignment.center,
                                child: const Text(
                                  'New Post',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 12,
                              ),
                              width: double.infinity,
                              // height: 280,
                              height: size.height * .3998,
                              decoration: BoxDecoration(
                                color: const Color(0xffFED976),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Row(
                              children: const [
                                SizedBox(width: 25),
                                Text(
                                  'Recent',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.white,
                                ),
                                // SizedBox(height: 20),
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: size.height * .212,
                              child: GridView.builder(
                                itemCount: 6,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10,
                                ),
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 7,
                                  mainAxisSpacing: 7,
                                ),
                                itemBuilder: (context, index) => Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffE0FDFD),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

          // SECOND SHEET

          ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: thirdSheetBlursFirstSheet == true
                  ? 5 * thirdBumpPointerLocation
                  : 5 * thirdSheetCon.value,
              sigmaY: thirdSheetBlursFirstSheet == true
                  ? 5 * thirdBumpPointerLocation
                  : 5 * thirdSheetCon.value,
            ),
            child: AnimatedBuilder(
              animation: secondBumpCon,
              builder: (BuildContext context, Widget? child) {
                return AnimatedBuilder(
                  animation: secondSheetCon,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        secondBump == true
                            ? size.height * secondSheetAni.value
                            : size.height * secondBumpAni.value,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onVerticalDragUpdate: (details) {
                                setState(() {
                                  secondBumpHeight =
                                      size.height - details.globalPosition.dy;
                                  secondBumpPointerLocation = (details
                                          .localPosition.dy
                                          .abs()
                                          .clamp(0, 123) /
                                      123);
                                  secondBumpPointerLocationSec =
                                      ((details.globalPosition.dy - 503)
                                              .clamp(0, 126) /
                                          126);
                                });
                              },
                              onVerticalDragDown: (details) {
                                isSecondSheetClosed == false
                                    ? secondSheetCon.reverse()
                                    : null;
                              },
                              onVerticalDragEnd: (details) {
                                setState(() {
                                  secondBumpHeight = 120;
                                });
                                isSecondSheetClosed == true
                                    ? secondSheetCon.forward()
                                    : null;
                              },
                              behavior: HitTestBehavior.translucent,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.elasticOut,
                                height: secondBumpHeight.clamp(120, 200),
                                width: size.width,
                                child: CustomPaint(
                                  painter: MyCustomPainter(
                                    secondBumpAniSec.value,
                                    hasSecondSheetPassedHalf,
                                    Colors.black,
                                  ),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 700),
                                      curve: Curves.ease,
                                      margin: const EdgeInsets.only(top: 17),
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(
                                              secondBumpIconOpac == true ?
                                              secondSheetBlursFirstSheet == true
                                                  ? 0.9 *
                                                      secondBumpPointerLocationSec
                                                  : 0.9 *
                                                      lerpDouble(
                                                              1,
                                                              0,
                                                              secondSheetCon
                                                                  .value)!
                                                          .toDouble() : 0.0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: size.height * .68,
                              color: Colors.black,
                              child: child,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white.withOpacity(.9),
                                size: 19,
                              ),
                            ),
                            Text(
                              'Post',
                              style: TextStyle(
                                color: Colors.white.withOpacity(.9),
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            )
                          ],
                        ),
                      ),
                      //
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20),
                                width: size.width * .32,
                                height: size.width * .32,
                                decoration: BoxDecoration(
                                  color: const Color(0xffFED976),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(13),
                                width: size.width * .85,
                                height: size.width * .32,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Text(
                                  'Describe your post',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 20),
                                padding: const EdgeInsets.all(13),
                                width: size.width * .85,
                                height: size.width * .32,
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              CupertinoIcons.hand_raised_fill,
                                              color: Colors.yellow,
                                              size: 25,
                                            ),
                                            Text(
                                              'Allow comments',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        CupertinoSwitch(
                                          value: false,
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(
                                              Icons.sd_card,
                                              color: Colors.grey,
                                              size: 25,
                                            ),
                                            Text(
                                              'Save to device',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                        CupertinoSwitch(
                                          value: false,
                                          onChanged: (value) {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 100),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // THIRD SHEET

          AnimatedBuilder(
            animation: thirdBumpCon,
            builder: (BuildContext context, Widget? child) {
              return AnimatedBuilder(
                animation: thirdSheetCon,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      thirdBump == true
                          ? size.height * thirdSheetAni.value
                          : size.height * thirdBumpAni.value,
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onVerticalDragUpdate: (details) {
                              setState(() {
                                thirdBumpHeight =
                                    size.height - details.globalPosition.dy;
                                thirdBumpPointerLocation = (details
                                        .localPosition.dy
                                        .abs()
                                        .clamp(0, 123) /
                                    123);
                                thirdBumpPointerLocationSec =
                                    ((details.globalPosition.dy - 503)
                                            .clamp(0, 126) /
                                        126);
                              });
                            },
                            onVerticalDragEnd: (details) {
                              setState(() {
                                thirdBumpHeight = 120;
                              });
                              thirdSheetCon.forward();
                            },
                            behavior: HitTestBehavior.translucent,
                            child: AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              curve: Curves.elasticOut,
                              height: thirdBumpHeight.clamp(120, 200),
                              width: size.width,
                              child: CustomPaint(
                                painter: MyCustomPainter(
                                  thirdBumpAniSec.value,
                                  hasThirdSheetPassedHalf,
                                  Colors.white,
                                ),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.ease,
                                    margin: const EdgeInsets.only(top: 17),
                                    child: Text(
                                      'Share',
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(
                                          thirdSheetBlursFirstSheet == true
                                              ? 1.0 *
                                                  thirdBumpPointerLocationSec
                                              : 1.0 *
                                                  lerpDouble(
                                                      1,
                                                      0,
                                                      thirdSheetCon.value
                                                          .toDouble())!,
                                        ),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: size.height * .4,
                            color: Colors.white,
                            alignment: Alignment.topCenter,
                            child: child,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: size.height * .14,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  decoration: BoxDecoration(
                    color: const Color(0xffF2EBD8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      Container(
                        width: size.height * .08,
                        height: size.height * .08,
                        decoration: BoxDecoration(
                          color: const Color(0xffF5CD73),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(width: 25),
                      const Text(
                        'Posting...',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
