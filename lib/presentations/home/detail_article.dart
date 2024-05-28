import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:testing/domain/server/server_app.dart';
import 'package:testing/utils/ColorAsset.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({super.key});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final data = Get.arguments['data'];
  bool isLoading = true;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        titleSpacing: 0,
        backgroundColor: ColorAsset.GREEN,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          isLoading ? const LinearProgressIndicator() : Container(),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url:
                    Uri.parse('${ServerApp.BASE_URL}article/${data.id}/detail'),
                // url: Uri.parse('${ServerApp.BASE_URL}article/${data.id}/detail'),
              ),
              initialOptions: options,
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  isLoading = true;
                });
                print('START : ${url.toString()}');
              },
              onLoadStop: (controller, url) {
                setState(() {
                  isLoading = false;
                });
                print('STOP : ${url.toString()}');
              },
              onConsoleMessage: (controller, consoleMessage) {
                print('CONSOLE : ${consoleMessage.toJson()}');
              },
            ),
          ),
        ],
      ),
    );
  }
}
