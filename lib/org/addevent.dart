import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:firebase_storage/firebase_storage.dart';

import 'package:gap/gap.dart';
import 'package:universe2024/Utiles/app_styles.dart';
import 'package:universe2024/pages/firebase.dart';
import 'package:universe2024/pages/loginpage.dart';

class add extends StatefulWidget {
  const add({Key? key});

  @override
  State<add> createState() => _SignupPageState();
}

class _SignupPageState extends State<add> {
  String imageUrl = '';
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _eventNameController = TextEditingController();
  TextEditingController _eventDateController = TextEditingController();
  TextEditingController _eventLocationController = TextEditingController();
  TextEditingController _eventPriceController = TextEditingController();

  String _errorText = '';
  File? _image; // Selected image file

  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventDateController.dispose();
    _eventLocationController.dispose();
    _eventPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.bgColor,
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
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
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/logowhite.png',
                          width: 200,
                          height: 100,
                        ),
                        const Gap(10),
                        Text(
                          "Sign-Up",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildTextField(
                            "Name of the Event", _eventNameController),
                        const Gap(10),
                        _buildTextField(
                            "Date of the Event", _eventDateController),
                        const Gap(10),
                        _buildTextField(
                            "Event Location", _eventLocationController),
                        const Gap(10),
                        _buildTextField("Event Price", _eventPriceController),
                        const Gap(10),
                        _buildImagePicker(),
                        const Gap(20),
                        ElevatedButton(
                          onPressed: _signUp,
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.blueColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(2, 2),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Event Poster',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 150,
          margin: EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: Offset(2, 2),
              )
            ],
          ),
          child: _image == null
              ? Center(child: Text('No image selected'))
              : Image.file(_image!),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            selectImage(); // Call function to pick image
          },
          child: Text('Pick Image'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Styles.blueColor,
          ),
        ),
      ],
    );
  }

  void selectImage() async {
    try {
      final ImagePicker _imagePicker = ImagePicker();
      XFile? file = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (file == null) return;

      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImage = referenceRoot.child('images');
      Reference referenceImageToUpload = referenceDirImage.child(filename);

      // Upload image file to Firebase Storage
      await referenceImageToUpload.putFile(File(file.path));

      // Get the download URL for the uploaded image
      imageUrl = await referenceImageToUpload.getDownloadURL();

      // Update the UI or do other tasks after the URL is obtained
      setState(() {
        // For example, you can update a UI element with the imageUrl
      });
    } catch (error) {
      print("Error uploading image: $error");
      // Handle error gracefully, maybe show a message to the user
    }
  }



  void _signUp() async {
    String eventName = _eventNameController.text;
    String eventDate = _eventDateController.text;
    String eventLocation = _eventLocationController.text;
    String eventPrice = _eventPriceController.text;

    // Check if any of the fields are empty
    if (eventName.isEmpty ||
        eventDate.isEmpty ||
        eventLocation.isEmpty ||
        eventPrice.isEmpty ||
        _image == null) {
      // Update error message
      setState(() {
        _errorText = 'All fields are required';
      });
      return;
    }

    await FirebaseFirestore.instance.collection('events').doc().set({
      'eventName': eventName,
      'eventDate': eventDate,
      'eventLocation': eventLocation,
      'eventPrice': eventPrice,
      'imageUrl': imageUrl,
    });
  }
}
