// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:student_list/db/functions/functions.dart';
// import 'package:student_list/db/functions/model/model.dart';
// import 'package:student_list/home/add_student.dart';
// import 'package:student_list/home/edit.dart';
// import 'package:student_list/home/search.dart';
// // import 'package:student_list/screens/edit.dart';

// class MyWidget extends StatefulWidget {
//   final Key? key;

//   const MyWidget({this.key}) : super(key: key);

//   @override
//   State<MyWidget> createState() => _MyWidgetState();
// }

// class _MyWidgetState extends State<MyWidget> {
//   @override
//   Widget build(BuildContext context) {
//     getAllStudents();
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.red[300],
//           appBar: AppBar(
//             title: Text("STUDENT LIST"),
//             backgroundColor: Colors.green[400],
//             actions: [IconButton(onPressed: () {
//              Navigator.push(context, MaterialPageRoute(builder:(context) => Search(), ));

//             }, icon: Icon(Icons.search))],
//           ),
//           body: ValueListenableBuilder(
//             valueListenable: studentListNotifier,
//             builder: (BuildContext ctx, List<StudentModel> studentList,
//                 Widget? child) {
//               return ListView.separated(
//                   itemBuilder: (ctx, index) {
//                     final data = studentList[index];
//                     return ListTile(
//                       leading:CircleAvatar(
//                         radius:30,
//                         backgroundImage:data.image !=null
//                         ?FileImage(File(data.image!)):AssetImage('asset/facebook.jpg') as ImageProvider
//                       ),
//                       title: Text(data.name),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(data.age),
//                           Text(data.clas),
//                           Text(data.address),
//                         ],
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (context) => Editscreen(
//                                         index: index,
                                        
//                                            name: data.name,
//                                            age: data.age,
//                                           clas: data.clas,
//                                            place: data.address,
//                                            image: data.image!,
//                                            )));
//                             },
//                             icon: const Icon(
//                               Icons.edit,
//                               color: Colors.blue,
//                             ),
//                           ),
//                           SizedBox(width: 16), // Add some space between icons
//                           IconButton(
//                             onPressed: () {
//                               if (data.index != null) {
//                                 deleteStudent(data.index!);
//                               } else {
//                                 print("Student id is null. Unable to delete");
//                               }
//                             },
//                             icon:  Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                   separatorBuilder: (ctx, index) {
//                     return const Divider();
//                   },
//                   itemCount: studentList.length);
//             },
//           ),
//           floatingActionButton: FloatingActionButton.extended(
//               backgroundColor: Colors.green[400],
//               onPressed: () {
                
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: ((context) => ScreenList())));
//               },
//               label: Text("ADD STUDENT"),
//               icon: Icon(Icons.person_add))),
//     );
//   }
// }
import 'dart:io';
import 'package:student_list/db/functions/functions.dart';
import 'package:student_list/db/functions/model/model.dart';
import 'package:student_list/home/add_student.dart';
import 'package:student_list/home/edit.dart';
// import 'package:/screens/screen_home.dart';


import 'package:flutter/material.dart';
import 'package:student_list/home/screen.dart';

class ListStudentWidget extends StatefulWidget {
  const ListStudentWidget({super.key});

  @override
  State<ListStudentWidget> createState() => _ListStudentWidgetState();
}

class _ListStudentWidgetState extends State<ListStudentWidget> {
  
  // --------------------------------
  String _search = '';
  List<StudentModel> searchedlist = [];
  List<StudentModel> studentList =[];
  // ---------------------------------------------
  loadstudent() async {
  final allstudent = await getAllStudents();

  studentListNotifier.value =studentList;
}

  @override
  void initState() {
 
    super.initState();
    searchResult();
    loadstudent();
  }

  void searchResult() {
    setState(() {
      searchedlist = studentListNotifier.value
          .where((StudentModel) =>
              StudentModel.name.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    });
  }

  // --------------------------------------

  @override
  Widget build(BuildContext context) {
    // getAllStudents();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student List'),

        backgroundColor: Colors.amber[300],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(0))),
       

        actions: [
          IconButton(
              onPressed: () {
                
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenList()));
              },
              icon: Icon(Icons.group_add_rounded))
        ],
      ),
    
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/image (2).webp'),
            fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextFormField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(75),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(
                        color: Colors.lightBlue, width: 2, ),
                  ),
                ),
                onChanged: (value) {
      
                  // ----------------------
                  setState(() {
                    _search = value;
                  });
                  searchResult();
      
                  // ---------------------
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: studentListNotifier,
                builder: (BuildContext ctx, List<StudentModel> studentList,
                    Widget? child) {
                      final displayedStudents = searchedlist.isNotEmpty ? searchedlist : studentList;
                  return ListView.separated(
                    itemBuilder: (ctx, index) {
                      final data =displayedStudents[index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Card(
                          color: Colors.transparent,elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ViewStudentScreen(
                                    
                                    name: data.name,
                                    age: data.age,
                                      clas: data.clas,
                                    place: data.address,
                                    image: data.image ?? "",
                                  ),
                                ),
                              );
                            },
                            textColor: Colors.white,
                            title: Text(data.name),
                            subtitle: Text(data.age),
                            leading: CircleAvatar(
                                backgroundImage: data.image != null
                                    ? FileImage(File(data.image!))
                                    : AssetImage("asset/facebook.jpg")
                                        as ImageProvider),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>Editscreen (
                                            index: index,
                                            name: data.name,
                                            age: data.age,
                                            clas: data.clas,
                                            place: data.address,
                                            image: data.image!),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      deleteStudent(index);
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Color.fromARGB(255, 255, 17, 0))),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, index) {
                      return const Divider();
                    },
                    itemCount: displayedStudents.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}