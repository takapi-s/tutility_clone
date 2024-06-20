import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutility_clone/Provider/ClassProvider.dart';
import 'package:tutility_clone/model/class_model.dart';

//homeの時間割画面
class TimeTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider<T>() で子Widgetにデータを渡す
    // ※ 渡すデータの クラス と <T> は揃えましょう
    return ChangeNotifierProvider(
      // 渡すデータ
      create: (context) => ClassProvider(),
      child: _TimeTableState(),
    );
  }
}

class _TimeTableState extends StatelessWidget {
  var card_w = 75.0;
  var card_h = 110.0;

  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);
    return Column(
      children: [
        Container(
          color: Colors.blue,
          child: Row(
            children: [
              Text("月"),
              Text("月"),
              Text("月"),
              Text("月"),
            ],
          ),
        ),
        Row(
          children: [
            Column(
              children: [
                Text("8:50\n   1\n10:20"),
                Text("10:30\n  2\n12:00"),
                Text("13:00\n   3\n14:30"),
                Text("14:40\n   4\n16:10"),
                Text("16:20\n   5\n17:50"),
                Text("18:00\n   6\n19:30"),
              ],
            ),
            Consumer<ClassProvider>(builder: (context, model, child) {
              return Container(
                color: Colors.yellow,
                width: card_w * 5 + 4 * 3,
                height: card_h * 6 + 6 * 3,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  //padding: const EdgeInsets.all(3), //4辺すべて同じ値の余白
                  itemCount: 30,
                  //要素の数　表示するデータ数の最大値（texts　listの最大値）
                  // GridViewを設定する引数を指定
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 3, //ボックス左右間のスペース
                    mainAxisSpacing: 3, //ボックス上下間のスペース
                    crossAxisCount: 5, //ボックスを横に並べる数
                    childAspectRatio: 75 / 110, //注意
                  ),
                  //指定した要素の数分を生成
                  itemBuilder: (context, index) {
                    int weekNum = index % 5;
                    int time = index ~/ 5;
                    ClassModel? classModel = model.getModel(weekNum, time);
                    return Container(
                      height: 120,
                      color: Colors.black12,
                      child:
                          Text(classModel != null ? classModel.className : "a"),
                      //child: ,
                    );
                  },
                ),
              );
            },


            )
          ],
        ),
      ],
    );
  }
}
