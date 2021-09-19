import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
          'home',
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () {
              print('hello');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.notifications,
            ),
            onPressed: () {
              print("hi");
            },
          ),
          IconButton(
            icon: Icon(
              Icons.accessibility,
            ),
            onPressed: () {
              print('yes');
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 20.0,
      ),
      //  backgroundColor: Colors.lightGreen,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20.0),
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    width: 200.0,
                    height: 200.0,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512_960_720.jpg',
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    width: 200.0,
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
