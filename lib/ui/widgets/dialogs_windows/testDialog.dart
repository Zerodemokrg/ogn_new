import 'dart:html' as html;
import 'dart:ui' as ui;
import 'dart:ui_web';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class QRCodeDialog extends StatelessWidget {
  final String url;

  QRCodeDialog({required this.url}) {
    // Создание уникального идентификатора для viewType
    _viewType = 'iframe-${DateTime.now().millisecondsSinceEpoch}';

    // Регистрация viewFactory (только для Web)
    if (kIsWeb) {
      platformViewRegistry.registerViewFactory(
        _viewType,
            (int viewId) {
          final iframe = html.IFrameElement()
            ..src = url
            ..style.border = 'none'
            ..width = '100%'
            ..height = '100%';
          return iframe;
        },
      );
    }
  }

  late final String _viewType;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: 600,
        height: 400,
        child: kIsWeb
            ? HtmlElementView(
          viewType: _viewType, // Используем зарегистрированный viewType
        )
            : Center(
          child: Text('Iframe is only supported on Web'),
        ),
      ),
    );
  }
}