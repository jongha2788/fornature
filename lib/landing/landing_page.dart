import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fornature/auth/login/login.dart';
import 'package:fornature/auth/register/register.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // main logo
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Align(
            //   alignment: Alignment.center,
            Center(
              // padding: const EdgeInsets.only(left: 10.0),
              child: Image.asset(
                'assets/images/logo.png',
                height: 150.0,
                width: 150.0,
                fit: BoxFit.cover,
              ),
            ),
            // ),
            SizedBox(height: 10.0),
            Text(
              '초록 행성을 위한 길',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.w900,
                fontFamily: 'SangSangFlowerRoad',
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (_) => Login(),
                    ),
                  );
                },
                // LOGIN buttion
                child: Container(
                  height: 45.0,
                  width: 150.0,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   border: Border.all(color: Colors.black, width: 2.0),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [
                  //     Theme.of(context).accentColor,
                  //     Color(0xff597FDB),
                  //   ],
                  // ),
                  // ),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontFamily: 'NanumSquare_acEB',
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      CupertinoPageRoute(builder: (_) => Register()));
                },
                // SIGN UP button
                child: Container(
                  height: 45.0,
                  width: 150.0,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   border: Border.all(color: Colors.black, width: 2.0),
                  // gradient: LinearGradient(
                  //   begin: Alignment.topRight,
                  //   end: Alignment.bottomLeft,
                  //   colors: [
                  //     Theme.of(context).accentColor,
                  //     Color(0xff597FDB),
                  //   ],
                  // ),
                  // ),
                  child: Center(
                    child: Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontFamily: 'NanumSquare_acEB',
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
