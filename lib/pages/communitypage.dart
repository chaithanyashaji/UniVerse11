import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import 'package:gap/gap.dart';

import 'package:universe2024/Utiles/app_styles.dart';
import 'package:universe2024/pages/loginpage.dart';


class communitypage extends StatelessWidget {
  const communitypage({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 240,
                  child: Stack(
                      children:[
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25)),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            decoration: BoxDecoration(
                              image:DecorationImage(
                                  image: AssetImage('assets/ieeebanner.jpeg'),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 115,
                          left: 120,
                          child: Container(
                            width: 300,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Styles.yellowColor, // Specify the border color
                                width: 2,
                              ),
                            ),
                            child: Center(child: Text("COMMUNITY NAME",style: TextStyle(color:Styles.blueColor,fontSize: 18,fontWeight: FontWeight.bold),)),
                          ),
                        ),
                        Positioned(
                            top: 90,
                            left: 50,
                            child:Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle, // This ensures the Container has a circular shape
                                border: Border.all(
                                  color:Styles.yellowColor, // Specify the border color
                                  width: 2, // Specify the border width
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 60, // Adjust the radius as needed
                                backgroundImage: AssetImage('assets/ieeeprofile.jpeg'), // Optional: Set a background image// Optional: Set a background color
                                // child: Icon(Icons.person), // Optional: Add an icon or text as a child
                              ),
                            )

                        ),
                      ]
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 50.0),
                        width: 200,
                        height: 35,
                        child: ElevatedButton(
                          onPressed: (){
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.blueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                            ),
                          ),
                          child: Text(
                            'Follow Community',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      Gap(30),
                      Container(
                        child:Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                              const EdgeInsets.only(left: 27.0),
                              // Adjust the left margin as needed
                              child: Icon(
                                Icons.note_alt_outlined,
                                color: Styles.blueColor,
                              ),
                            ),
                            Gap(3),
                            Text(
                              'About us',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Styles.blueColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 27.0),
                        width: 450,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Styles.yellowColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            'Community Name  :  John Doe',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Styles
                                                    .blueColor),
                                          ),
                                          Gap(5),
                                          Text(
                                            'Email  :  john.doe@example.com',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Styles
                                                    .blueColor),
                                          ),
                                          Gap(5),
                                          Text(
                                            'Phone Number  :  +1234567890',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Styles
                                                    .blueColor),
                                          ),
                                          Gap(5),
                                          Text(
                                            'College Name  :  XYZ University',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Styles
                                                    .blueColor),
                                          ),
                                        ])
                                  ]
                              ),

                            ],
                          ),
                        ),
                      ),
                      Gap(30),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 29.0),
                        child:
                        Text(
                          'Upcoming Events',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Styles.blueColor,
                          ),
                        ),
                      ),
                      Gap(10),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 27.0),
                        width: 450,
                        height: 290,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Styles.yellowColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: SizedBox(
                          height: 280, // Adjust card height
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5),
                                width: 200, // Adjust card width
                                child: Card(
                                  margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                                  elevation: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/2.jpeg',
                                              height: 125,
                                            ),
                                            const SizedBox(
                                                height: 10),
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Date: \nLocation:\nPrice:',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(30),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 29.0),
                        child:
                        Text(
                          'All Events',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Styles.blueColor,
                          ),
                        ),
                      ),
                      Gap(10),
                      Container(
                        margin:
                        const EdgeInsets.only(left: 27.0),
                        width: 450,
                        height: 290,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Styles.yellowColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: SizedBox(
                          height: 280, // Adjust card height
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5),
                                width: 200, // Adjust card width
                                child: Card(
                                  margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                                  elevation: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              'assets/2.jpeg',
                                              height: 125,
                                            ),
                                            const SizedBox(
                                                height: 10),
                                            Text(
                                              'Name',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              'Date: \nLocation:\nPrice:',
                                              style: TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Gap(30)
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}