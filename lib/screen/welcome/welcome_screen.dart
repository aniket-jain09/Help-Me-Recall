import 'package:flutter/material.dart';
import 'package:flutter_medical/constant.dart';
import 'package:flutter_medical/locator.dart';
import 'package:flutter_medical/screen/reserve/reserve_screen.dart';
import 'package:flutter_medical/widget/header_logo.dart';
import 'package:flutter_medical/widget/menu_card.dart';
import 'package:flutter_medical/widget/my_header.dart';
import 'package:geolocator/geolocator.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool loading = false;
  Position position;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? CircularProgressIndicator()
          : Column(
              children: <Widget>[
                MyHeader(
                  height: 333,
                  imageUrl: 'assets/images/welcome.png',
                  child: Column(
                    children: <Widget>[
                      HeaderLogo(),
                      Text(
                        ' ',
                        style: TextStyle(
                          fontSize: 28,
                          color: mTitleTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Though those with alzheimer's might forget us, we as a society must remeber them",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 36,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [mBackgroundColor, mSecondBackgroundColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Our Services',
                                style: TextStyle(
                                  color: mTitleTextColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.menu,
                                color: mSecondBackgroundColor,
                                size: 36,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MenuCard(
                              imageUrl: 'assets/images/general_practice.png',
                              title: 'Reminder',
                              press: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return ReserveScreen();
                                    },
                                  ),
                                );
                              },
                            ),
                            MenuCard(
                              imageUrl: 'assets/images/specialist.png',
                              title: 'Upload Documents',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            MenuCard(
                              imageUrl: 'assets/images/sexual_health.png',
                              title: 'Meals',
                            ),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });

                                position =
                                    await AppLocation.determinePosition();

                                print(position.latitude);
                                print(position.longitude);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return Scaffold(
                                      appBar: AppBar(
                                        title: const Text('Second Route'),
                                      ),
                                      body: Center(
                                          child: Column(
                                        children: [
                                          Text("Longitude: " +
                                              position.latitude.toString()),
                                          Text("Latitude: " +
                                              position.latitude.toString()),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              // Navigate back to first route when tapped.
                                            },
                                            child: const Text('Go back!'),
                                          ),
                                        ],
                                      )),
                                    );
                                  }),
                                );

                                setState(() {
                                  loading = false;
                                });
                              },
                              child: MenuCard(
                                imageUrl: 'assets/images/immunisation.png',
                                title: 'Track my location',
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
