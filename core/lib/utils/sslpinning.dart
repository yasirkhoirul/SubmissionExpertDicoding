import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

Future<IOClient> getSSLPinningClient() async {
  final sslCert = await rootBundle.load(
    'certificate/themoviedb-org.pem',
  ); // Sesuaikan path

  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  HttpClient client = HttpClient(context: securityContext);

  // Pastikan callback ini return false (artinya: tolak jika sertifikat salah)
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;

  return IOClient(client);
}
