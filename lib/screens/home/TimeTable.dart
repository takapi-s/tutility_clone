
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutility_clone/Provider/ClassProvider.dart';
//homeの時間割画面
class TimeTable extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Provider<T>() で子Widgetにデータを渡す
    // ※ 渡すデータの クラス と <T> は揃えましょう
    return ChangeNotifierProvider<ClassProvider>(
      // 渡すデータ
      create: (context) => ClassProvider(),
      child: Container(
        child: _TimeTableState(),
      ),
    );
  }
}

class _TimeTableState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);
    return const Placeholder();
  }
}
