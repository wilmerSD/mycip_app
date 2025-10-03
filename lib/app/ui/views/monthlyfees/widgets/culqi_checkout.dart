import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CulqiCheckout extends StatefulWidget {
  final String publicKey;
  final int amount;
  final String currency;
  final String email;

  const CulqiCheckout({
    super.key,
    required this.publicKey,
    required this.amount,
    required this.currency,
    required this.email,
  });

  @override
  State<CulqiCheckout> createState() => _CulqiCheckoutState();
}

class _CulqiCheckoutState extends State<CulqiCheckout> {
  WebViewController? controller;

  @override
  void initState() {
    super.initState();

    String culqiHtml(String publicKey, int amount, String currency) {
      return '''
        <!DOCTYPE html>
        <html>
          <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="https://checkout.culqi.com/js/v4"></script>
            <script>
              function openCulqiCheckout() {
                Culqi.publicKey = "$publicKey";
                Culqi.settings({
                  title: "MiCip",
                  currency: "$currency",
                  amount: $amount,
                });
                Culqi.options({ lang: "es", installments: false });
                Culqi.open();
              }

              function getCulqiToken() {
                window.culqi = function() {
                  if (Culqi.token) {
                    CulqiChannel.postMessage(Culqi.token.id);
                  } else {
                    console.error("Error en Culqi:", Culqi.error);
                  }
                  Culqi.close();
                }
              }

              window.onload = function() {
                openCulqiCheckout();
                getCulqiToken();
              }
            </script>
          </head>
          <body></body>
        </html>
      ''';
    }

    final c = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        "CulqiChannel",
        onMessageReceived: (msg) {
          // 📌 Aquí llega el token desde JS
          Navigator.of(context).pop(msg.message);
        },
      )
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (_) => debugPrint("Página cargada"),
      ))
      ..loadHtmlString(
        culqiHtml(widget.publicKey, widget.amount, widget.currency),
      );

    controller = c;
  }

  @override
  Widget build(BuildContext context) {
    return controller == null
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              SizedBox(
                  width: 400.0,
                  height: 690.0,
                  child: WebViewWidget(controller: controller!)),
              Positioned(
                right: 10,
                top: 19,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.black,
                    height: 40,
                    width: 40,
                    child: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              )
            ],
          );
  }
}
