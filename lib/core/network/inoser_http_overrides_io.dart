import 'dart:io';

import 'package:crypto/crypto.dart';

/// inoser-education.com currently presents a self-signed Bitnami default cert
/// (CN=www.example.com). Dart will reject it unless we pin this fingerprint.
/// When the server gets a public CA cert, verification succeeds and this
/// callback is never used.
const _pinnedSha256 =
    '7174aa71f6a0118fd4d6e9c71fa113615d61fb66ab0ad3070fc475a25b354a09';

bool _isInoserHost(String host) {
  final h = host.toLowerCase();
  return h == 'inoser-education.com' || h.endsWith('.inoser-education.com');
}

class InoserHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) {
      if (!_isInoserHost(host)) {
        return false;
      }
      final fingerprint = sha256.convert(cert.der).toString();
      return fingerprint == _pinnedSha256;
    };
    return client;
  }
}

void installInoserHttps() {
  HttpOverrides.global = InoserHttpOverrides();
}
