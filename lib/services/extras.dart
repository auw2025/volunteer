import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent_plus/android_intent.dart';

Future<void> LaunchUrl(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

void setReminder(String reminderText) {
  AndroidIntent intent = AndroidIntent(
    action: 'android.intent.action.VOICE_ASSIST',
    arguments: {'query': 'set a reminder $reminderText'},
  );
  intent.launch();
}
