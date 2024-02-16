import 'dart:convert';
import 'dart:html';

class ResumeLastPage {
  final bool resumeLastPage;

  ResumeLastPage(this.resumeLastPage);

  Map<String, dynamic> toMap() {
    return {
      'resumeLastPage': resumeLastPage,
    };
  }

  factory ResumeLastPage.fromMap(Map<String, dynamic> map) {
    return ResumeLastPage(map['resumeLastPage']);
  }
}

class LocalStorageManagerLastPage {
  static const String KEY_RESUME_LAST_PAGE = 'resume_last_page';

  static void saveResumeLastPage(ResumeLastPage resumeLastPage) {
    final Map<String, dynamic> map = resumeLastPage.toMap();
    final String jsonString = json.encode(map);
    window.localStorage[KEY_RESUME_LAST_PAGE] = jsonString;
  }

  static bool getResumeLastPage() {
    final String? jsonString = window.localStorage[KEY_RESUME_LAST_PAGE];
    if (jsonString != null) {
      if (jsonString.toLowerCase().contains('true')) {
        return true;
      }
    }
    return false;
  }
}
