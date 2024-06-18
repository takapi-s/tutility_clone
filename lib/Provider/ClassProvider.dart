
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart';
import '../model/class_model.dart';
import "package:universal_html/controller.dart";


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
    //notifyListeners();
  }

  Future<void> getHtmlData(String url) async {
    log('get: $url');
    final controller = WindowController();
    await controller.openHttp(uri: Uri.parse(url));
    final elements = controller.window!.document.querySelectorAll("span");
    log("fff");
    if(elements.isEmpty){
      log("ee");
    }
    for(final element in elements){
      log('element: $element');
    }
    log("ff");
  }
}



