import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutility_clone/Provider/ClassProvider.dart';

//homeの時間割画面
class TimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider<T>() で子Widgetにデータを渡す
    // ※ 渡すデータの クラス と <T> は揃えましょう
    return ChangeNotifierProvider<ClassProvider>(
      // 渡すデータ
      create: (context) => ClassProvider(),
      child: Container(
        child: _TimeTableState(),
      ),
    );
  }
}

class _TimeTableState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);
    return ListView.builder(
        
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 20,
            color: Colors.black,
          );
        });

    //height: 120,

    // return Container(
    //   color: Colors.black12,
    //   height: 120 * 6,
    //   width: 70 * 5 + 3 * 6,
    //   child: ListView.builder(
    //     physics: NeverScrollableScrollPhysics(),
    //     scrollDirection: Axis.vertical,
    //     shrinkWrap: true,
    //     itemCount: 6,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Container(
    //         height: 120,
    //         //color: Colors.pink,
    //         child: ListView.builder(
    //             physics: const NeverScrollableScrollPhysics(),
    //             scrollDirection: Axis.horizontal,
    //             shrinkWrap: true,
    //             itemCount: 5,
    //             itemBuilder: (BuildContext, int index) {
    //               return Container(
    //                 width: 70,
    //                 margin: const EdgeInsets.all(3),
    //                 color: Colors.black,
    //                 //child: Text(""),
    //               );
    //             }),
    //       );
    //     },
    //   ),
    // );
  }
}
