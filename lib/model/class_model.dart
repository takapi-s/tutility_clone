



import 'package:universal_html/html.dart';

class ClassModel {//授業クラス
  String credit = "";
  String category = "";
  String kind = "";
  String semester = "";
  String className = ""; //授業名
  String cancelName = "";
  String teacher = "";

  int weekNum = -1;
  int time = -1;

  ClassModel();


  void setClass( String className,String category, String kind, String credit, String semester,   String teacher, int weekNum, int time){
    this.className = className;
    this.category = category;
    this.kind = kind;
    this.semester = semester;
    this.credit = credit;
    this.teacher = teacher;

    this.weekNum = weekNum;
    this.time = time;
  }

  bool isEmpty(){
    if(this.className == ""){
      return true;
    }
    return false;
  }

}