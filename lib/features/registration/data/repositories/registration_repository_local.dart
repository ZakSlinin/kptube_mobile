import 'package:shared_preferences/shared_preferences.dart';

class RegistrationLocalData {
  Future<void> saveRegistrationData(
    String name,
    String password,
    String User_ID,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('password', password);
    await prefs.setString('User_ID', User_ID);
    // from me: its not security method, do not use in projects!
  }
}
