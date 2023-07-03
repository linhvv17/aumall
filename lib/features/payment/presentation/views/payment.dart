import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aumall/core/utilities/routes.dart';
import 'package:aumall/core/utilities/strings.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../generated/l10n.dart';
import '../bloc/payment_bloc.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        WebView(
          
          initialUrl:
              "https://accept.paymob.com/api/acceptance/iframes/390170?payment_token=${BlocProvider.of<PaymentBloc>(context).FINAL_TOKEN_CARD}",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
        Positioned(
          top: 40,
          right: 10,
          child: ElevatedButton.icon(
              onPressed: () {
                
                Navigator.pushReplacementNamed(context, AppRoutes.success);
              },
              icon: const Icon(Icons.navigate_next),
              label:  Text(S.current.next)),
        ),
      ]),
    );
  }
}

JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
  return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      });
}
