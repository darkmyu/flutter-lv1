import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final homeUri = Uri.parse('https://blog.codefactory.ai');

class HomeScreen extends StatelessWidget {
  WebViewController controller = WebViewController()..loadRequest(homeUri);

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Code Factory'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.loadRequest(homeUri);
            },
            icon: const Icon(
              Icons.home,
            ),
          ),
        ],
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
