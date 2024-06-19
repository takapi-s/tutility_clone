import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:universal_html/controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/class_model.dart';

//データを保存するdart

class ClassProvider with ChangeNotifier {
  //時間割の30要素を持つデータにして何曜日の何限目かでデータの位置を決める
  //火曜日3時限目　1*6 + 3みたいな

  //からの30要素を持つリストにする
  //２次元配列にする
  //List<List<ClassModel>> classModelMatrix = List.generate(9, (i) => List.filled(6, []));

  TimeTableModel timeTable = TimeTableModel();

  List<String> urls = [];
  String url = "";
  WebViewController controller = WebViewController();

  ClassProvider() {
    //初期化
    this.url = 'https://kyomu.office.tut.ac.jp/portal/';
    this.urls = [];
    this.controller = WebViewController()
      ..addJavaScriptChannel("flutterApp", onMessageReceived: (result) async {
        // result.message でJSからのデータを取得可能
        //log(result.message);
        if (result.message != "") {
          urls.add(result.message);
        }
      });
  }

  Future<void> changeUrl(String u) async {
    url = u;
    notifyListeners();
  }

  Future<void> urlsToTimeTable() async {
    bool sw = false;
    for (int i = 0; i < urls.length; i++) {
      log(urls[i]);
      final controller = WindowController();
      await controller.openHttp(uri: Uri.parse(urls[i]));
      var elements = controller.window!.document.querySelectorAll("span");
      for(var e in elements){
        if((e.text! ==  "科目名[英文名]") ||
            (e.text! ==  "区分")||
            (e.text! ==  "開講学期")||
            (e.text! ==  "曜日時限")||
            (e.text! ==  "単位数")||
            (e.text! ==  "担当教員[ローマ字表記]")
        )
        {
          sw = true;
        }else{
          if(sw){
            log(e.text!);
            sw = false;
          }
        }
      }
    }
  }

  Future<void> getHTML() async {
    urls = []; //空にする
    var s = await controller.runJavaScriptReturningResult("""
      var aArray = Array.from(window.document.querySelectorAll('a'));
      var hrefArray = aArray
        .map(a => a.href) // get href attributes
        .filter(href => href.startsWith('https://kyomu.office.tut.ac.jp/Portal/Public/Syllabus/')); // filter by specific URL

      hrefArray.forEach(href => {
      //console.log(href);
      flutterApp.postMessage(href);
      });
      //refArray;
    """);

    await urlsToTimeTable();

    //timeTable.printModel();
  }
}
