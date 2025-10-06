import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfAssets {
  static pw.MemoryImage? _logo;

  static Future<pw.MemoryImage> getLogo() async {
    if (_logo == null) {
      final bytes = await rootBundle.load('assets/LOGO_CIP.png');
      _logo = pw.MemoryImage(bytes.buffer.asUint8List());
    }
    return _logo!;
  }
}
