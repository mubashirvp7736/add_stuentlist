import 'dart:io';

import 'package:flutter/material.dart';



class ViewStudentScreen extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String clas;
  final String image;

  const ViewStudentScreen({
    required this.name,
    required this.age,
    required this.place,
    required this.clas,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 56, 56, 58),
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        ),
        backgroundColor: Colors.transparent,
        title: Text('PrOfIlE'),
        centerTitle: true,
      ),
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover
          )
          ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.lightBlue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 15,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.transparent,
                    backgroundImage: FileImage(File(image)),
                  ),
                ),
                SizedBox(height: 30),
                CardItem(
                  title: 'Name',
                  content: name,
                  isAlternate: false,
                ),
                CardItem(
                  title: 'Age',
                  content: age,
                  isAlternate: true,
                ),
                CardItem(
                  title: 'Education',
                  content: place,
                  isAlternate: false,
                ),
                CardItem(
                  title: 'Address',
                  content: clas,
                  isAlternate: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String title;
  final String content;
  final bool isAlternate;

  const CardItem({
    required this.title,
    required this.content,
    required this.isAlternate,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isAlternate ? Colors.white : Colors.lightBlue;
    final textColor =
        isAlternate ?Colors.lightBlue : Colors.white;

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: bgColor,
      child: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}