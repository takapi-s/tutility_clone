import "dart:developer";
import "package:provider/provider.dart";

import '../../Provider/ClassProvider.dart';
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";

class ScrapingScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    // Provider<T>() で子Widgetにデータを渡す
    // ※ 渡すデータの クラス と <T> は揃えましょう
    return ChangeNotifierProvider<ClassProvider>(
      // 渡すデータ
      create: (context) => ClassProvider(),
      child: Container(
        child: _ScrapingScreenState(),
      ),
    );
  }
}

class _ScrapingScreenState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);

    final controller = WebViewController()
      ..loadRequest(Uri.parse(
          'https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx'))
      //https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            log('progress: $progress');
          },
          onPageStarted: (String url) {
            log('page started: $url');

          },
          onPageFinished: (String url) {
            log('page finished: $url');
            data.getHtmlData(url);
            Navigator.pop(context);
          },
          onWebResourceError: (WebResourceError error) {
            log('error: $error');
          },

        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text("TimeTable get"),
      ),
      body: Container(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}
