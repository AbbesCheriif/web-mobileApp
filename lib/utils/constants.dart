import 'package:flutter/material.dart';

class AppConstants {
  // Firebase Keys
  static const String firebaseApiKey = 'YOUR_FIREBASE_API_KEY';
  static const String firebaseAppId = 'YOUR_FIREBASE_APP_ID';
  static const String firebaseMessagingSenderId = 'YOUR_FIREBASE_MESSAGING_SENDER_ID';
  static const String firebaseProjectId = 'YOUR_FIREBASE_PROJECT_ID';

  // App Strings
  static const String appName = 'Nephro Service';
  static const String welcomeMessage = 'Welcome to Nephro Service';
  static const String loginMessage = 'Please login to continue';

  // Colors
  static const Color primaryColor = Color(0xFF0A0E21);
  static const Color accentColor = Color(0xFFEB1555);
  static const Color backgroundColor = Color(0xFFF3F4F6);
  static const Color textColor = Color(0xFF8D8E98);

  // Text Styles
  static const TextStyle headingTextStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: primaryColor,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontSize: 18.0,
    color: textColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // Padding and Margin
  static const double defaultPadding = 16.0;
  static const double defaultMargin = 16.0;

  // Button Sizes
  static const double buttonHeight = 50.0;
  static const double buttonWidth = double.infinity;

  // API Endpoints
  static const String baseUrl = 'https://api.yourapp.com';
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String userProfileEndpoint = '$baseUrl/user/profile';

  // Other Constants
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
}
