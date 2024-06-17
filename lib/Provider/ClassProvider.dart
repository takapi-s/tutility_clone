
import 'package:flutter/material.dart';
import '../model/class_model.dart';

//データを保存するdart

class ClassProvider with ChangeNotifier{
  //時間割の30要素を持つデータにして何曜日の何限目かでデータの位置を決める
  //火曜日3時限目　1*6 + 3みたいな

  //からの30要素を持つリストにする
  //２次元配列にする
  List<List<ClassModel>> classModelMatrix = List.generate(5, (i) => List.filled(6, ClassModel(className: "")));
  //追加する関数
  void addClassModelList(String className, int weekNum, int periodNum){
    ClassModel a = ClassModel(
      className: className,
      // weekNum: weekNum,
      // periodNum: periodNum,
    );
    classModelMatrix[weekNum][periodNum] = a;
    notifyListeners();
  }
}



