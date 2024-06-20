import "dart:developer";
import "dart:io";
import "package:provider/provider.dart";

import '../../Provider/ClassProvider.dart';
import "package:flutter/material.dart";
import "package:webview_flutter/webview_flutter.dart";


class ScrapingScreen extends StatelessWidget {
  const ScrapingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider<T>() で子Widgetにデータを渡す
    // ※ 渡すデータの クラス と <T> は揃えましょう
    return ChangeNotifierProvider(
      // 渡すデータ
      create: (context) => ClassProvider(),
      child: _ScrapingScreenState(),

    );
  }
}

class _ScrapingScreenState extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);
    bool sw1 = true;
    bool sw2 = true;
    bool sw3 = true;


    //data.changeUrl( 'https://kyomu.office.tut.ac.jp/portal/');

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

            if ((url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Top.aspx") & (sw1 == true)) {
              log("ll");
              sw1 = false;
              sleep(Duration(seconds: 1));
              await data.controller.runJavaScript(
                  "document.getElementById('ctl00_bhHeader_ctl16_lnk').click();"
              );

            }else if((url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Blank.aspx#regist_results")& (sw2 == true)){
              //urlを押す処理を追加する
              log("dd");
              sw2 = false;
              sleep(Duration(seconds: 1));

              await data.controller.runJavaScript(
                  "document.getElementById('ctl00_bhHeader_ctl30_lnk').click();"
              );
              //await data.changeUrl("https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx")& (sw1 == true));

            }else if((url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx")& (sw3 == true)){
              sw3 = false;
              log("ff");
              sleep(Duration(seconds: 1));
              await data.getHTML();

              Navigator.of(context).pop();
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
          controller: controller,
        ),
      ),
    );
  }
}
