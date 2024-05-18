import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:universe2024/pages/Eventdetails.dart';
import 'package:universe2024/pages/communitypage.dart';
import '../Utiles/app_styles.dart';

class searchpage extends StatefulWidget {
  const searchpage({Key? key}) : super(key: key);

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  late String searchQuery;

  @override
  void initState() {
    super.initState();
    searchQuery = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Colors.white, // Set the AppBar background color
          flexibleSpace: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(12), // Curved edges
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Styles.blueColor,
                  Styles.lblueColor,
                  Styles.yellowColor
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(23),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white70,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Search",
                      hintStyle: TextStyle(fontSize: 20.0), // Set hint text size
                      prefixIcon: Icon(Icons.search, size: 30.0), // Set icon size
                      prefixIconColor: Colors.black38,
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                    ),
                    onChanged: (val) {
                      setState(() {
                        searchQuery = val;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildSearchResults('users'),
          ),
          Expanded(
            child: _buildSearchResults('event'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(String collectionName) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(collectionName).snapshots(),
      builder: (context, snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          final filteredData = snapshots.data!.docs.where((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return data['name']
                .toString()
                .toLowerCase()
                .contains(searchQuery.toLowerCase());
          }).toList();

          return ListView.builder(
            itemCount: filteredData.length,
            itemBuilder: (context, index) {
              final data = filteredData[index].data() as Map<String, dynamic>;

              return GestureDetector(
                onTap: () {
                  if (collectionName == 'event') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventDetails()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => communitypage()),
                    );
                  }
                },
                child: ListTile(
                  title: Text(
                    collectionName == 'users'
                        ? (data['roll'] == "Community" ? data['name'] : '')
                        : data['eventName'], // Adjust this based on your data structure
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    collectionName == 'event' ? data['eventLocation'] : (data['roll'] == "Community" ? data['collegeName'] : ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}

