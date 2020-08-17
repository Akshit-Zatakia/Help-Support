import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'dart:typed_data';

class Url {
  //static final String URL = "http://10.0.2.2/akk/";
  //static final String URL = "http://192.168.43.222/akk/";
  static final String URL = "http://iplextechnologies.esy.es/akk/";
  static int count = 0;
  static bool session = false;
  static List<Color> colorList = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];

  static void shareApp() async {
    var request = await HttpClient().getUrl(Uri.parse(
        "http://iplextechnologies.esy.es/helpSupport/Help%20Support.jpg"));
    var response = await request.close();
    Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    try {
      WcFlutterShare.share(
        sharePopupTitle: "Share App",
        subject: 'Help Support App',
        text:
            'Download Help Support\n\nApp Link : https://play.google.com/store/apps/details?id=com.akshit.help_support\n\nHelp Support is a mobile application developed by Akshit Zatakia to connect essential Health services with the people and Live news around the World. The app is aimed at augmenting live news updates and health related information.\n\nIt proactively reaches out to and informs the users of the app regarding risks, best practices and relevant advisories pertaining to the containment of current situation going on in The World.\n\nDeveloped by : Akshit Zatakia (9375126826)\nWebsite : http://iplextechnologies.ml/',
        fileName: "Help Support.png",
        bytesOfFile: bytes.buffer.asUint8List(),
        mimeType: 'text/plain',
      );
    } catch (e) {
      print(e);
    }
  }
}
