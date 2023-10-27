import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_list/db/functions/functions.dart';
import 'package:student_list/db/functions/model/model.dart';
import 'package:student_list/home/list_student.dart';

class Editscreen extends StatefulWidget {
  final String name;
  final String age;
  final String clas;
  final String place;
  final int index;

  const Editscreen({super.key, required this.name, required this.age, required this.clas, required this.place, required this.index});

  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {

  final _nameController=TextEditingController();
  final _ageController=TextEditingController();
  final _classController=TextEditingController();
  final _placecontroller=TextEditingController();
    final _formkey = GlobalKey<FormState>();


  @override
  void initState() {
    

    super.initState();

    _nameController.text=widget.name;
    _ageController.text=widget.age;
    _classController.text=widget.clas;
    _placecontroller.text=widget.place;
  }
  Future<void> updatestudent(int index)async{
      final studentDB=await Hive.openBox<StudentModel>('student_db');

    if(index >=0 && index<studentDB.length){
      final updatestudent =StudentModel(name:_nameController.text , age:_ageController.text, clas: _classController.text, address:_placecontroller.text);
       await studentDB.putAt(index, updatestudent);
       getAllStudents();
       Navigator.push(context, MaterialPageRoute(builder: (context) => MyWidget(),));
    }

   
  }
  
  @override
  Widget build(BuildContext context) {
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
                       backgroundImage:      //_image!=null? FileImage(_image);
                        NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4CS3kONPRvBZ8Q_Ju-h3RaxKKQpP83FjGZw'),
                     ),
                    onTap: () {
                  // pickimage();
                    
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
                    controller: _placecontroller,
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
                          updatestudent(widget.index);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyWidget()));
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
}