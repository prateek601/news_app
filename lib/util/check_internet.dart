import 'dart:io';

typedef void InternetConnected();
typedef void InternetNotConnected();

Future<void> checkInternet({
  required InternetConnected internetConnected,
  required InternetNotConnected internetNotConnected
}) async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      internetConnected();
    }
  } on SocketException catch (_) {
    print('not connected');
    internetNotConnected();
  }
}