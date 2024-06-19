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
  List<String> spans = [];
  String url = "";
  WebViewController controller = WebViewController();


  ClassProvider() {
    //初期化
    this.url = 'https://kyomu.office.tut.ac.jp/portal/';
    this.spans = [];
    this.controller = WebViewController()
      ..addJavaScriptChannel("flutterApp",
          onMessageReceived: (result) async {
            // result.message でJSからのデータを取得可能

            if((result.message != "")||(result.message != "当選")){
              spans.add(result.message);
            }
          }
      );
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
    var spans = await controller.runJavaScriptReturningResult("""
    var spansArray = Array.from(window.document.querySelectorAll('span'));
    spansArray.forEach(span => {
      //console.log(span.textContent);
      flutterApp.postMessage(span.textContent);
    });
    spansArray;
    """);
  }
}
