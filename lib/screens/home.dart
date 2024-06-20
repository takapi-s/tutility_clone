//時間割の画面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutility_clone/screens/home/TimeTable.dart';
import 'package:tutility_clone/screens/home/Top.dart';

import 'home/Scraping.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Top(),
              TimeTable(),
            ],
          ),
        ),
      ),
    );


  }
}

