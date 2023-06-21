import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../constant/color.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key});

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  XFile? _image;

  Future<void> _openGallery() async {
    var imagePicker = ImagePicker();
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _openCamera() async {
    var imagePicker = ImagePicker();
    var takenImage = await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = takenImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20, color: textColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Your profile have been updated",
                toastLength: Toast.LENGTH_SHORT,
              );
            },
            icon: const Icon(
              Icons.done,
              color: textColor,
              size: 30,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: backgroundColor,
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Column(
                          children: [
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Container(
                                height: 5,
                                width: 80,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: lightGrey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            )),
                            GestureDetector(
                              onTap: _openGallery,
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 35,
                                        left: 20,
                                        right: 10,
                                        bottom: 10),
                                    child: Icon(
                                      Icons.photo_library_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 35,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: Text(
                                      "Select image from gallery",
                                      style: TextStyle(
                                          color: textColor, fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: _openCamera,
                              child: const Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        left: 20,
                                        right: 10,
                                        bottom: 10),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 30,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 15,
                                        left: 0,
                                        right: 10,
                                        bottom: 10),
                                    child: Text(
                                      "Capture image from camera",
                                      style: TextStyle(
                                          color: textColor, fontSize: 18),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: lightGrey),
                  child: Image.asset("assets/images/addprofile.png"),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 30),
              child: TextField(
                decoration: InputDecoration(
                  enabled: false,
                  hintText: "joypatel242001@gmail.com",
                  filled: true,
                  fillColor: trans,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  enabled: false,
                  hintText: "joypatel242001",
                  filled: true,
                  fillColor: trans,
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter your name",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Enter date of birth (dd-mm-yyyy)",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "You are identified as",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add your designation / job",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add your link",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Add your ('state country')",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 10),
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLength: 200,
                maxLines: 7,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: "Add your bio",
                  filled: true,
                  fillColor: trans,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: textColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: companyColor, width: 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
