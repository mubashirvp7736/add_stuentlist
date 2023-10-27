import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/db/functions/functions.dart';
import 'package:student_list/db/functions/functions.dart';
import 'package:student_list/db/functions/model/model.dart';
import 'package:student_list/home/add_student.dart';
import 'package:student_list/screens/home/add.dart';

class EditScreen extends StatefulWidget {
  const EditScreen(
    StudentModel updated, {
    super.key,
    required this.name,
    required this.age,
    required this.clas,
    required this.address,
    //required this.image,
  });
  final String name;
  final String age;
  final String clas;
  final String address;
  //final dynamic image;

  @override
  State<EditScreen> createState() => _edit();
}

class _edit extends State<EditScreen> {
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();
  final TextEditingController classcontroller = TextEditingController();
  final TextEditingController addressController = TextEditingController();

 // File? selectedimage;

  @override
  void initState() {
    namecontroller.text = widget.name;
    agecontroller.text = widget.age;
    classcontroller.text = widget.clas;
    addressController.text = widget.address;

    //selectedimage = widget.image != null ? File(widget.image) : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 80, 0, 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'S T U D E N T',
                      style: TextStyle(
                        color: Colors.green[400],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // CircleAvatar(
                      //     radius: 100,
                      //     backgroundImage: selectedimage != null
                      //         ? FileImage(selectedimage!)
                      //         : AssetImage("assets/images/profile.png")
                      //             as ImageProvider),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green[400])),
                              onPressed: () {
                                // fromgallery();
                              },
                              child: Text('GALLERY')),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.green[400])),
                              onPressed: () {
                                // fromcam();
                              },
                              child: Text('CAMERA')),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'NAME',
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: agecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'AGE',
                          ),
                          maxLength: 3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: classcontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'CLASS',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: addressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'PLACE',
                          ),
                          
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                    Colors.green[400])),
                            onPressed: () {
                              update();
                            },
                            child: Text('UPDATE'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  update() async {
    final edited_name = namecontroller.text.trim();
    final edited_age = agecontroller.text.trim();
    final edited_clas = classcontroller.text.trim();
    final edited_address = addressController.text.trim();

    //final edited_image = selectedimage?.path;

    if (edited_name.isEmpty|| 
        edited_age.isEmpty|| 
        edited_clas.isEmpty ||
        edited_address.isEmpty) {
      return;
    }
    final updated = StudentModel(
      name: edited_name,
      age: edited_age,
      clas: edited_clas,
      address: edited_address,
      // image: edited_image!
    );

    EditScreen(
      updated,
      name: '',
      address: '',
      age: '',
      clas: '',
      // image: '',
    );

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Updated Successfully'),
      behavior: SnackBarBehavior.floating,
    ));
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ScreenList(),
    ));
  }

  // fromgallery() async {
  //   final returnedimage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     selectedimage = File(returnedimage!.path);
  //   });
  // }

  // fromcam() async {
  //   final returnedimage =
  //       await ImagePicker().pickImage(source: ImageSource.camera);
  //   setState(() {
  //     selectedimage = File(returnedimage!.path);
  //   });
  // }
}