import 'package:flutter/material.dart';
import 'package:flutter_application_0/const/route_argument.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WebViewArgument argument = ModalRoute.of(context)!.settings.arguments as WebViewArgument;
    return Scaffold(
      appBar: AppBar(
        title: Text(argument.title),
      ),
      body: WebView(
        initialUrl: argument.url,
      ),
    );
  }
}
