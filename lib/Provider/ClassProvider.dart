
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
    final controller = WindowController();
    await controller.openHttp(uri: Uri.parse(url));
    //final elements = controller.window!.document.querySelectorAll("article > h2 > a");

    //await controller.openHttp(uri: Uri.parse(url));

    // 各要素のテキスト内容を取得
    final Document document = controller.window!.document;
    String lectureCode = document.querySelector("#ctl00_phContents_rrMain_ttTable_lctMon1_ctl00_lblLctCd")?.text ?? "";
    String credit = document.querySelector("#ctl00_phContents_rrMain_ttTable_lctMon1_ctl00_lblCredit")?.text?.trim() ?? "";
    String termName = document.querySelector("#ctl00_phContents_rrMain_ttTable_lctMon1_ctl00_lblTermName")?.text ?? "";
    String subjectDivName = document.querySelector("#ctl00_phContents_rrMain_ttTable_lctMon1_ctl00_lblSbjDivName")?.text ?? "";
    String subjectName = document.querySelector("#ctl00_phContents_rrMain_ttTable_lctMon1_ctl00_lblSbjName a")?.text ?? "";
    String staffName = document.querySelector("#ctl00_phContents_rrMain_ttTable_lctMon1_ctl00_lblStaffName")?.text ?? "";

    // 結果を表示
    print("Lecture Code: $lectureCode");
    print("Credit: $credit");
    print("Term Name: $termName");
    print("Subject Division Name: $subjectDivName");
    print("Subject Name: $subjectName");
    print("Staff Name: $staffName");
  }
}



