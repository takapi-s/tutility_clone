import "dart:developer";
import "dart:io";
import "package:provider/provider.dart";

import '../../Provider/ClassProvider.dart';
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";


class ScrapingScreen extends StatelessWidget {
  @override
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
  int c = 0;
  // Future<void> getHTML() async {
  //   html = await _controller.runJavaScriptReturningResult("""
  //   window.document.querySelectorAll('span');
  //   window.document.querySelectorAll('span').forEach(span => {
  //   console.log(span.textContent);
  //   });
  //   """);
  // }

  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);

    final controller = data.controller
      ..loadRequest(Uri.parse(data.url))
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
          onPageFinished: (String url) async {
            // if (url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Top.aspx") {
            //   const redirectURL = "https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx";
            //   await _controller.loadRequest(Uri.parse(redirectURL));
            //   getHTML();
            //   await data.getHtmlData(html);
            //   log('page finished: $url');
            //
            // }

            if ((url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Top.aspx") & (c == 0)) {
              var u = url;
              log("req1: $u");
              data.changeUrl("https://kyomu.office.tut.ac.jp/portal/StudentApp/Blank.aspx#regist_results");
              c = 1;
              sleep(Duration(seconds: 1));
            }else{
              log("dd");
              data.changeUrl("https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx");
              sleep(Duration(seconds: 1));
            }
          },
          onWebResourceError: (WebResourceError error) {
            log('error: $error');
          },
          onNavigationRequest: (NavigationRequest request){

            return NavigationDecision.navigate;
          },
        ),
      );

    return Scaffold(
      appBar: AppBar(
        title: const Text("TimeTable get"),
      ),
      body: Container(
        child: WebViewWidget(
          controller: data.controller,
        ),
      ),
    );
  }
}
