import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String? blogUrl; // Make it final to comply with best practices
  ArticleView({super.key, this.blogUrl});

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    // Initialize the controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // Allow JavaScript if needed
      ..loadRequest(Uri.parse(widget.blogUrl ?? '')); // Use a default URL or handle null
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter"),
            Text(
              ' News',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
          ],
        ),
        elevation: 0.3,
      ),
      body: SafeArea(
        child: WebViewWidget(controller: controller),
      ),
    );
  }
}
