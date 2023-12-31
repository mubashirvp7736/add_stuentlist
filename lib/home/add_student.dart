import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_list/db/functions/functions.dart';
import 'package:student_list/db/functions/model/model.dart';
import 'package:student_list/home/list_student.dart';
import 'package:image_picker/image_picker.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({super.key});

  @override
  State<ScreenList> createState() => _ScreenState();
}

class _ScreenState extends State<ScreenList> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _classController = TextEditingController();
  final _addressController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
 File? _selectedImage;
   
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      backgroundColor: Colors.amber[200],
        appBar: AppBar(
          title: Text("ADD DETAILS"),
          backgroundColor: Colors.green[400],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 80,
                       backgroundImage:_selectedImage !=null ? FileImage(_selectedImage! ): 
                     const  AssetImage('asset/facebook.jpg') as ImageProvider,
                    ),
                    onTap: () {
                  _pickimage();
                    
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.green[900],
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'NAME',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "value is empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.calendar_month, color: Colors.blue),
                        border: OutlineInputBorder(),
                        hintText: 'AGE'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "value is empty";
                      } else {
                        return null;
                      }
                    },
                    
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _classController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.school,
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'CLASS'),
                    validator: (value) {if (value == null || value.isEmpty) {
                        return "value is empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.location_on, color: Colors.red[900]),
                        border: OutlineInputBorder(),
                        hintText: 'PLACE'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "value is empty";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          onAddStudentBtn();
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ListStudentWidget()));
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      label: Text("ADD STUDENT"),
                      icon: Icon(Icons.add))
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> onAddStudentBtn() async {
    final _name = _nameController.text.trim();
    final _age = _ageController.text.trim();
    final _class = _classController.text.trim();
    final _address = _addressController.text.trim();
    if (_name.isEmpty || _age.isEmpty || _class.isEmpty || _address.isEmpty) {
      return;
    }
    // print('$_name $_age $_class $_address');

    final _student =
        StudentModel(name: _name, age: _age, clas: _class, address: _address,image:_selectedImage!.path);
    addStudent(_student);
  }
    void _pickimage()async{
      final returnImage =await ImagePicker().pickImage(source: ImageSource.gallery);
      if(returnImage == null){
        return;
      }else{
        setState(() {
          _selectedImage=File(returnImage.path);
        });
  
      }
    }
}






                    