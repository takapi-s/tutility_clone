import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/class_model.dart';

//データを保存するdart

class ClassProvider with ChangeNotifier {
  //時間割の30要素を持つデータにして何曜日の何限目かでデータの位置を決める
  //火曜日3時限目　1*6 + 3みたいな

  //からの30要素を持つリストにする
  //２次元配列にする
  List<List<ClassModel>> classModelMatrix =
      List.generate(5, (i) => List.filled(6, ClassModel(className: "")));
  var controller = WebViewController();
  String url = "";

  ClassProvider() {
    this.url = 'https://kyomu.office.tut.ac.jp/portal/';
  }

  //追加する関数
  void addClassModelList(String className, int weekNum, int periodNum) {
    ClassModel a = ClassModel(
      className: className,
      // weekNum: weekNum,
      // periodNum: periodNum,
    );
    classModelMatrix[weekNum][periodNum] = a;
    //notifyListeners();
  }

  Future<void> changeUrl(String u) async {
    url = u;
    notifyListeners();
  }

  Future<void> getHTML() async {
    // var spans = await controller.runJavaScriptReturningResult("""
    //
    //
    // window.document.querySelectorAll('span');
    // window.document.querySelectorAll('span').forEach(span => {
    // console.log(span.textContent);
    // });
    // """);

    var spans = await controller.runJavaScriptReturningResult("""
    var spansArray = Array.from(window.document.querySelectorAll('span'));
    spansArray.forEach(span => {
    console.log(span.textContent);
    });
    spansArray;
    
    """);

    print(spans);
  }
}
