import 'dart:developer';
import 'dart:io';
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

  //TimeTableModel timeTable = TimeTableModel();

  List<ClassModel> timeTable = [];

  List<String> urls = [];
  String url = "";
  WebViewController controller = WebViewController();

  ClassProvider() {
    log("ClassProvide inicialize");
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

    this.timeTable = [];
  }


  Future<void> changeUrl(String u) async {
    url = u;
    notifyListeners();
  }

  Future<void> urlsToTimeTable() async {
    bool sw = false;
    for (int i = 0; i < urls.length; i++) {
      //log(urls[i]);
      final controller = WindowController();
      await controller.openHttp(uri: Uri.parse(urls[i]));
      var elements = controller.window!.document.querySelectorAll("span");

      List<String> elementList = [];
      for (var e in elements) {
        if ((e.text! == "科目名[英文名]") ||
            (e.text! == "区分") ||
            (e.text! == "選択必須") ||
            (e.text! == "開講学期") ||
            (e.text! == "曜日時限") ||
            (e.text! == "単位数") ||
            (e.text! == "担当教員[ローマ字表記]")) {
          sw = true;
        } else {
          if (sw) {
            //log(e.text!);
            elementList.add(e.text!);
            sw = false;
          }
        }
      }
      String weekday = elementList[4].substring(0, 1); //水5~5
      int startTime = int.parse(elementList[4].substring(1, 2)); // String から int に変換
      int endTime = int.parse(elementList[4].substring(3, 4)); //水5~5

      int weekNum = 0;
      switch (weekday) {
        case "月":
          weekNum = 0;
          break;
        case "火":
          weekNum = 1;
          break;
        case "水":
          weekNum = 2;
          break;
        case "木":
          weekNum = 3;
          break;
        case "金":
          weekNum = 4;
          break;
        case "土":
          weekNum = 5;
          break;
      }

      ClassModel cc = ClassModel();
      for (int time = startTime - 1; time < endTime; time++) {
        cc.setClass(
            elementList[0],
            elementList[1],
            elementList[2],
            elementList[3],
            elementList[5],
            elementList[6],
            weekNum,
            time);

        timeTable.add(cc);
      }
    }

    for(int kk = 0; kk < timeTable.length ; kk++){

      log(timeTable[kk].className);
    }

    notifyListeners();

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

  ClassModel? getModel(int weekNum, int time) {
    for (int k = 0; k < timeTable.length; k++) {
      if ((timeTable[k].weekNum == weekNum) & (timeTable[k].time == time)) {
        return timeTable[k];
      }
    }
    return null;
  }
}
