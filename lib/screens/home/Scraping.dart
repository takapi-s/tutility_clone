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


  @override
  Widget build(BuildContext context) {
    final ClassProvider data = Provider.of<ClassProvider>(context);

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
            // if (url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Top.aspx") {
            //   const redirectURL = "https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx";
            //   await _controller.loadRequest(Uri.parse(redirectURL));
            //   getHTML();
            //   await data.getHtmlData(html);
            //   log('page finished: $url');
            //
            // }

            if (url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Top.aspx") {
              var u = url;
              log("req1: $u");
              data.controller.runJavaScript(
                  "document.getElementById('ctl00_bhHeader_ctl16_lnk').click();"
              );
              //await data.changeUrl("https://kyomu.office.tut.ac.jp/portal/StudentApp/Blank.aspx#regist_results");
              //<a id="ctl00_bhHeader_ctl16_lnk" href="javascript:__doPostBack('ctl00$bhHeader$ctl16$lnk','')">履修・成績情報<br><span style="line-height:100%;">Course grades</span></a>

              sleep(const Duration(seconds: 1));
            }else if(url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Blank.aspx#regist_results"){
              //urlを押す処理を追加する
              log("dd");
              data.controller.runJavaScript(
                  "document.getElementById('ctl00_bhHeader_ctl30_lnk').click();"
              );
              //await data.changeUrl("https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx");
              sleep(const Duration(seconds: 1));
            }else if(url == "https://kyomu.office.tut.ac.jp/portal/StudentApp/Regist/RegistList.aspx"){
              log("ff: $url");
              data.getHTML();
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
