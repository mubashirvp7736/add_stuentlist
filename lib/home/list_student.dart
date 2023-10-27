import 'package:flutter/material.dart';
import 'package:student_list/db/functions/functions.dart';
import 'package:student_list/db/functions/model/model.dart';
import 'package:student_list/home/add_student.dart';
import 'package:student_list/home/edit.dart';
// import 'package:student_list/screens/edit.dart';

class MyWidget extends StatefulWidget {
  final Key? key;

  const MyWidget({this.key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red[300],
          appBar: AppBar(
            title: Text("STUDENT LIST"),
            backgroundColor: Colors.green[400],
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          ),
          body: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (BuildContext ctx, List<StudentModel> studentList,
                Widget? child) {
              return ListView.separated(
                  itemBuilder: (ctx, index) {
                    final data = studentList[index];
                    return ListTile(
                      title: Text(data.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data.age),
                          Text(data.clas),
                          Text(data.address),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) => Editscreen(
                                        index: index,
                                        
                                           name: data.name,
                                           age: data.age,
                                          clas: data.clas,
                                           place: data.address )));
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 16), // Add some space between icons
                          IconButton(
                            onPressed: () {
                              if (data.index != null) {
                                deleteStudent(data.index!);
                              } else {
                                print("Student id is null. Unable to delete");
                              }
                            },
                            icon:  Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider();
                  },
                  itemCount: studentList.length);
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.green[400],
              onPressed: () {
                
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ScreenList())));
              },
              label: Text("ADD STUDENT"),
              icon: Icon(Icons.person_add))),
    );
  }
}