import 'package:perkey/core/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._internal();

  factory UserInfo() => _instance;

  UserInfo._internal();

  // User info fields
  String? username;
  String? email;
  String? type;

  /// Initialize and load data from SharedPreferences
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString(SharedPreferencesConstants.kUsernameKey);
    email = prefs.getString(SharedPreferencesConstants.kUserEmailKey);
    type = prefs.getString(SharedPreferencesConstants.kUserTypeKey);
  }

  /// Save user data to SharedPreferences
  Future<void> saveUserInfo({
    required String username,
    required String email,
    required String type,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesConstants.kUsernameKey, username);
    await prefs.setString(SharedPreferencesConstants.kUserEmailKey, email);
    await prefs.setString(SharedPreferencesConstants.kUserTypeKey, type);

    // Update current instance
    this.username = username;
    this.email = email;
    this.type = type;
  }

  /// Clear user info
  Future<void> clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(SharedPreferencesConstants.kUsernameKey);
    await prefs.remove(SharedPreferencesConstants.kUserEmailKey);
    await prefs.remove(SharedPreferencesConstants.kUserTypeKey);

    username = null;
    email = null;
    type = null;
  }

  /// Check if user is logged in (i.e., all fields are non-null)
  bool get isLoggedIn => username != null && email != null && type != null;
}
