
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:universe2024/Utiles/app_styles.dart';
import 'package:gap/gap.dart';
import 'package:universe2024/org/1.dart';
import 'package:universe2024/org/add.dart';
import 'package:universe2024/org/home.dart';
import 'package:universe2024/pages/Eventdetails.dart';
import 'package:universe2024/pages/Homepage.dart';
import 'package:universe2024/pages/Userpage.dart';

import 'package:universe2024/pages/chatbot.dart';

import 'package:universe2024/pages/profile.dart';
import 'package:universe2024/pages/qrcode.dart';
import 'package:universe2024/pages/search.dart';
import 'package:universe2024/pages/search1.dart';
import 'package:universe2024/pages/ticket.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  CollectionReference _reference =
  FirebaseFirestore.instance.collection('event');

  late Stream<QuerySnapshot> _stream;

  static List<Widget> _widgetOptions = <Widget>[
    searchpage1(),
    searchpage(),
    profile(),

    // Replace this with your search page widget // Replace this with your chatbot page widget
    // Replace this with your profile page widget
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index != 5) {
        _selectedIndex = index;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => searchpage1()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _stream = _reference.snapshots();
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: Stack(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: _stream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Some error'));
              }
              if (snapshot.hasData) {
                QuerySnapshot querySnapshot = snapshot.data!;
                List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                List<Map> items = documents.map((e) {
                  return {
                    'eventName': e['eventName'],
                    'eventDate': e['eventDate'],
                    'eventLocation': e['eventLocation'],
                    'eventPrice': e['eventPrice'],
                    'eventtype': e['eventtype'],

                  };
                }).toList();

                return HomeContent(items: items);
              }
              return Center(child: CircularProgressIndicator());
              // Return a widget here, even if it's just a placeholder
              // Placeholder widget
            },
          ),
          _widgetOptions.elementAt(_selectedIndex),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Styles.blueColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => chat()),
          );
        },
        child: Icon(Icons.chat,color: Styles.blueColor,),
        backgroundColor: Styles.yellowColor,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<Map> items;

  const HomeContent({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Align(
              alignment: const AlignmentDirectional(20, -1.2),
              child: Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.yellowColor,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-2.7, -1.2),
              child: Container(
                height: MediaQuery.of(context).size.width / 1.3,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.blueColor,
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(2.7, -1.2),
              child: Container(
                height: MediaQuery.of(context).size.width / 1.3,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Styles.lblueColor,
                ),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
              child: Container(),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logowhite.png',
                      width: 200,
                      height: 100,
                    ),
                    Text(
                      "UniVerse",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Events",
                                    style: TextStyle(
                                      fontSize: 21.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Gap(10),
                                  // Add posters and event names here
                                  SizedBox(
                                    height: 250, // Adjust poster height
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5, // Example itemCount
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 0,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                'assets/3.jpeg',
                                                height: 210,
                                              ),
                                              Text('Event ${index + 1}',style: TextStyle(fontSize: 18),),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Upcoming Events",
                                    style: TextStyle(
                                      fontSize: 21.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const Gap(10),
                                  // Add registration cards with posters for upcoming events here
                                  SizedBox(
                                    height: 325, // Adjust card height
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: items.length,
                                      itemBuilder: (context, index) {
                                        Map event = items[index];
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          width: 220, // Adjust card width
                                          child: Card(
                                            elevation: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/2.jpeg',
                                                        height: 135,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Text(
                                                        event['eventName'],
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Text(
                                                        'Date: ${event['eventDate']}\nEvent Type: ${event['eventtype']}\nPrice: ${event['eventPrice']}',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDetails()),
                                                    );
                                                  },
                                                  child: Text('Register',style: TextStyle(fontSize: 18),),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}