import 'package:url_launcher/url_launcher.dart';

class Urls {
  static String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.danielscholte.arrow_log';
  static String appStoreUrl = 'https://apps.apple.com/us/app/arrowlog/id1503041139';
  static String githubUrl = 'https://github.com/DanielScholte/ArrowLog';
  static String emailUrl = 'mailto:danielscholte@outlook.com?SUBJECT=Arrowlog%20feedback';

  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}