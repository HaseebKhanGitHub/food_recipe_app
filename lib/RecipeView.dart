import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {

  final String appurl;

  RecipeView({required this.appurl});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {

  late String finalUrl;
  @override
  void initState() {
    if(widget.appurl.toString().contains('http://')){
      finalUrl = widget.appurl.toString().replaceAll('http://', 'https://');
    } else {
      finalUrl = widget.appurl;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // Initialize the WebViewController
    final WebViewController webcontroller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(finalUrl));

    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe'),
      ),
      body: WebViewWidget(controller: webcontroller),
    );
  }
}
