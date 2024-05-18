import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gap/gap.dart';

import 'package:universe2024/Utiles/app_styles.dart';
import 'package:universe2024/pages/loginpage.dart';


class orgprofile extends StatefulWidget {
  const orgprofile({Key? key});

  @override
  State<orgprofile> createState() => _orgprofileState();
}

class _orgprofileState extends State<orgprofile> {
  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    super.initState();
    final currentUserUid = FirebaseAuth.instance.currentUser?.uid;
    _stream = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserUid)
        .snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Styles.yellowColor,
                        Styles.lblueColor,
                        Styles.blueColor
                      ])),
            ),
            title: Text(
              'Community Profile',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            leading: SizedBox(
              width: 800, // Set the desired width
              height: double.infinity,
              child: Image.asset(
                'assets/logowhite.png',
                fit: BoxFit.fitHeight, // Adjust the fit as needed
              ),
            ),
            backgroundColor: Styles.blueColor),

        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
    child: StreamBuilder<DocumentSnapshot>(
    stream: _stream,
    builder: (BuildContext context,
    AsyncSnapshot<DocumentSnapshot> snapshot) {
      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      final userData = snapshot.data?.data() as Map<String, dynamic>;
      final collegeName = userData['collegeName'] ?? '';
      final email = userData['email'] ?? '';
      final mobileNumber = userData['mobileNumber'] ?? '';
      final name = userData['name'] ?? '';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 240,
            child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
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
                      child: Center(child: Text( '$name' ,
                        style: TextStyle(color: Styles.blueColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  Positioned(
                      top: 90,
                      left: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // This ensures the Container has a circular shape
                          border: Border.all(
                            color: Styles.yellowColor,
                            // Specify the border color
                            width: 2, // Specify the border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 60, // Adjust the radius as needed
                          backgroundImage: AssetImage(
                              'assets/ieeeprofile.jpeg'), // Optional: Set a background image// Optional: Set a background color
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
                  child: Row(
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
                  height: 205,
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
                                      'Community Name  :  $name',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Styles
                                              .blueColor),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Email  :  $email',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Styles
                                              .blueColor),
                                    ),
                                    Gap(5),
                                    Text(
                                      'Phone Number  : $mobileNumber',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Styles
                                              .blueColor),
                                    ),
                                    Gap(5),
                                    Text(
                                      'College Name  :  $collegeName',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Styles
                                              .blueColor),
                                    ),
                                  ])
                            ]
                        ),
                        const Gap(20),
                        Row(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    // Call function to pick image
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add, color: Styles.blueColor,),
                                      Text('Edit Details', style: TextStyle
                                        (color: Styles.blueColor,
                                          fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                ),
                              ),
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
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
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
                            margin: EdgeInsets.only(
                                left: 10, right: 10, top: 15, bottom: 15),
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
                Center(
                  child: Container(
                    width: 150,
                    height: 40,
                    child: Material(
                        elevation: 8,
                        // Adjust the elevation as needed
                        borderRadius: BorderRadius.circular(25),
                        // Set the same border radius as the button
                        child: SizedBox(
                          // Adjust the width here
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to the signup page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        loginpage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.blueColor,
                            ),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                ),
                Gap(30)
              ],
            ),
          )
        ],
      );
    }
        )
                    )
    );
  }
}