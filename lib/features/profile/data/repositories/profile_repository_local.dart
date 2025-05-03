import 'package:shared_preferences/shared_preferences.dart';

class ProfileLocalData {
  Future<String?> getMyProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString('name');
    return name;
  }
}