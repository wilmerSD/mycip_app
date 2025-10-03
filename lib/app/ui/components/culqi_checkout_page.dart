import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CulqiCheckoutPage extends StatefulWidget {
  final String checkoutUrl;

  const CulqiCheckoutPage({super.key, required this.checkoutUrl});

  @override
  State<CulqiCheckoutPage> createState() => _CulqiCheckoutPageState();
}

class _CulqiCheckoutPageState extends State<CulqiCheckoutPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (url.contains("success")) {
              Navigator.pop(context, "Pago aprobado");
            } else if (url.contains("cancel")) {
              Navigator.pop(context, "Pago cancelado");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pagar con Culqi")),
      body: WebViewWidget(controller: _controller),
    );
  }
}