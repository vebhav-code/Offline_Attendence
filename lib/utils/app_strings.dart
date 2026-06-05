class AppStrings {
  static const Map<String, Map<String, String>> strings = {
    'en': {
      'app_name': 'Saksham Attendance',
      'home': 'Home',
      'members': 'Members',
      'profile': 'Profile',
      'mark_attendance': 'Mark Attendance',
      'take_selfie': 'Take selfie to mark present',
      'present': 'Present',
      'absent': 'Absent',
      'total_members': 'Total Members',
      'offline_ready': 'Offline Ready',
      'add_member': 'Add Member',
      'search_members': 'Search Members',
    },
    'hi': {
      'app_name': 'सक्षम अटेंडेंस',
      'home': 'होम',
      'members': 'सदस्य',
      'profile': 'प्रोफाइल',
      'mark_attendance': 'हाजिरी दर्ज करें',
      'take_selfie': 'सेल्फी लेकर हाजिरी दर्ज करें',
      'present': 'उपस्थित',
      'absent': 'अनुपस्थित',
      'total_members': 'कुल सदस्य',
      'offline_ready': 'ऑफलाइन तैयार',
      'add_member': 'सदस्य जोड़ें',
      'search_members': 'सदस्य खोजें',
    }
  };

  static String get(String key, String lang) {
    return strings[lang]?[key] ??
        strings['en']?[key] ??
        key;
  }
}
