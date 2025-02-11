import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static const String userIdKey = "USERKEY";
  static const String userNameKey = "USERNAMEKEY";
  static const String userEmailKey = "USEREMAILKEY";
  static const String userImageKey = "USERIMAGEKEY";
  static const String userGenderKey = "USERGENDERKEY";

  // Save User ID
  Future<bool> saveUserId(String getUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserId);
  }

  // Save User Name
  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  // Save User Email
  Future<bool> saveUserEmail(String getUserEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userEmailKey, getUserEmail);
  }

  // Save User Image
  Future<bool> saveUserImage(String getUserImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImageKey, getUserImage);
  }
  Future<bool> saveUserGender(String getUserGender) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userGenderKey, getUserGender);
  }
  // Get User ID
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // Get User Name
  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  // Get User Email
  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  // Get User Image
  Future<String?> getUserImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }

  Future<void> saveUserDetails(String name, String gender) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("userName", name);
    prefs.setString("userGender", gender);
  }


  Future<String?> getUserGender() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("userGender");
  }

}