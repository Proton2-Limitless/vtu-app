import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtu_client/model/user_profile.dart';

class TokenPersistence {
  static const _tokenKey = "token";
  static const _refreshTokenKey = "refreshtoken";
  static const _emailKey = "email";
  static const _otp = "otp";
  static const _profileKey = "otp";
  static const _isBiometricAuth = "bio";

  Future<SharedPreferences> _prefs() async =>
      await SharedPreferences.getInstance();

  Future<void> setBioAuth(bool bio) async {
    final prefs = await _prefs();
    prefs.setBool(_isBiometricAuth, bio);
  }

  Future<bool?> getBioAuth() async {
    final prefs = await _prefs();
    return prefs.getBool(_isBiometricAuth);
  }

  Future<void> setToken(String token) async {
    final prefs = await _prefs();
    prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await _prefs();
    return prefs.getString(_tokenKey);
  }

  Future<void> setrefreshToken(String token) async {
    final prefs = await _prefs();
    prefs.setString(_refreshTokenKey, token);
  }

  Future<String?> getrefreshToken() async {
    final prefs = await _prefs();
    return prefs.getString(_refreshTokenKey);
  }

  Future<void> setEmail(String email) async {
    final prefs = await _prefs();
    prefs.setString(_emailKey, email);
  }

  Future<String?> getEmail() async {
    final prefs = await _prefs();
    return prefs.getString(_emailKey);
  }

  Future<void> setOtpVerification(String otp) async {
    final prefs = await _prefs();
    prefs.setString(_otp, otp);
  }

  Future<String?> getOtpVerification() async {
    final prefs = await _prefs();
    return prefs.getString(_otp);
  }

  Future<void> setProfile(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_profileKey, jsonEncode(profile.toJson()));
  }

  Future<UserProfile?> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString(_profileKey);
    if (profileString == null) return null;
    return UserProfile.fromJson(jsonDecode(profileString));
  }

  Future<void> clearTokens() async {
    final prefs = await _prefs();
    prefs.remove(_tokenKey);
    prefs.remove(_refreshTokenKey);
    prefs.remove(_emailKey);
    prefs.remove(_otp);
    prefs.remove(_profileKey);
  }

  Future<void> signOut() async {
    final prefs = await _prefs();
    prefs.remove(_tokenKey);
    prefs.remove(_refreshTokenKey);
  }
}
