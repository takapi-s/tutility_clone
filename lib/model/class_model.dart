



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

  // int weekNum = -1;//授業ある曜日　月から金　0-4
  // int periodNum = -1;//次元　0-5
  // chromium(12031): [INFO:CONSOLE(3)] " ", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] "B13610150", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] " ", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] " 2単位", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] "前期", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] "[必修]", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] "離散数学論", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] " ", source:  (3)
  // I/chromium(12031): [INFO:CONSOLE(3)] "石田　好輝", source:  (3)

  ClassModel();


  void setClass( String className,String category, String kind, String credit, String semester,   String teacher, int weekNum, int time){
    // [log] 英語 Reading & Writing Ⅲ
    // [log] 外国語科目
    // [log] 選択
    // [log] 前期
    // [log] 金2〜2
    // [log] 1
    // [log] 大木  ひろみ
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

class PeriodModel {//表示する１コマのクラス
  ClassModel classModel1 = ClassModel();
  ClassModel classModel2 = ClassModel();

  PeriodModel();


  int setPeriod(ClassModel classModel){
    if((classModel.semester == "前期")||(classModel.semester == "後期")||(classModel.semester == "通年")){
      classModel1 = classModel;
      classModel2 = classModel;
      return 0;
    }else if((classModel.semester == "前期１")||(classModel.semester == "後期１")){
      classModel1 = classModel;
      return 1;
    }else if((classModel.semester == "前期２")||(classModel.semester == "後期２")){
      classModel2 = classModel;
      return 2;
    }else{
      return 3;
    }


  }

  ClassModel getPeriod(bool id){
    if(id){//idがtrueならclassmodel1を返す
      return classModel1;
    }else{
      return classModel2;
    }

  }

}

class TimeTableModel {
  List<List<PeriodModel>> timeTable =  List.generate(9, (i) => List.filled(6, PeriodModel()));
  //9は時限は曜日

  TimeTableModel();

  int setPeriod(ClassModel classModel, int i, int j){// 0が帰ってきたら全て埋めた、1がかえってきたら前期1、後期２　２が返ってきたら前期２、後期２ , 3はerror
    return timeTable[i][j].setPeriod(classModel);
  }


  void printModel(){
    for(int i = 0;i < 9;i++){
      for(int j = 0;j < 6;j++){
        print(timeTable[i][j].getPeriod(true).className);
      }
    }
  }



}

