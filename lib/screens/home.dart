//時間割の画面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutility_clone/screens/home/TimeTable.dart';
import 'package:tutility_clone/screens/home/Top.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(right: 8,left:8,top:50),
      child: Column(
        children: [
          const Top(),
          TimeTable()
        ],
      ),

    );
  }
}

