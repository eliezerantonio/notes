import 'package:share_plus/share_plus.dart';

import 'share_value.dart';

class SharePlugin implements ShareValue {
  @override
  void share(String link, String subject) {
    Share.share(link, subject: subject);
  }
}
