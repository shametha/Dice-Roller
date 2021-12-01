import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static const _primaryColor = Color(0xff052890);
  final themeElement = ThemeData.light().copyWith(
      primaryColor: _primaryColor,
      accentColor: _primaryColor,
      backgroundColor: Colors.white,
      textTheme: TextTheme(
          button: TextStyle(
        fontSize: 24.0,
        letterSpacing: 2.4,
        color: Colors.white,
      )));
  late int pickARandomFace;
  late String dieFaceAssetString;
  late AnimationController animationController;
  late ThemeData _currentTheme;

  @override
  void initState() {
    super.initState();
    _currentTheme = themeElement;
    pickARandomFace = Random().nextInt(5) + 1;
    dieFaceAssetString = 'assets/die_face_$pickARandomFace.svg';
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0,
      upperBound: 1,
    )..addListener(() {
        this.setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Roll The Die',
        theme: _currentTheme,
        home: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.blueAccent,
            title: Text(
              'LET\'S ROLL IT',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  letterSpacing: 1.6,
                  color: Color(0xff052890)),
            ),
            centerTitle: true,
            backgroundColor: _currentTheme.backgroundColor,
            elevation: 10,
          ),
          body: Container(
            color: _currentTheme.accentColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  onTap: changeDieFace,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.white.withAlpha(55),
                          blurRadius: 24.0,
                          offset: Offset(0, 8))
                    ]),
                    child: RotationTransition(
                        turns: animationController,
                        child: SvgPicture.asset(dieFaceAssetString)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 48.0, right: 48.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: buildRaisedButton(),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget buildRaisedButton() {
    return RaisedButton(
      color: _currentTheme.backgroundColor,
      splashColor: Colors.white,
      elevation: 16.0,
      highlightElevation: 24.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
      child: Text("ROLL IT", style: _currentTheme.textTheme.caption),
      onPressed: () {
        changeDieFace();
      },
    );
  }

  void changeDieFace() {
    return setState(() {
      animationController.forward(from: 0);
      dieFaceAssetString = 'assets/die_face_${Random().nextInt(6) + 1}.svg';
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
