import 'package:flutter/material.dart';

class Constants {
  // Colors
  static const Color primaryColor = Color(0xFF3F51B5);
  static const Color accentColor = Color(0xFFFF4081);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.black87,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.black54,
  );

  // Dimensions
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Asset Paths
  static const String ticketFrontImage = 'assets/images/ticket_front.webp';
  static const String ticketBackImage = 'assets/images/ticket_back.webp';
  static const String setlistBackgroundImage = 'assets/images/setlist_background.webp';
  static const String errorBackgroundImage = 'assets/images/error_background.jpg';
  static const String buttonSetlistImage = 'assets/images/button_setlist.jpg';
  static const String photoBackgroundImage = 'assets/images/photo_background.webp';

  // Firebase Collection Names
  static const String customDataCollection = 'custom_data';
  static const String photosCollection = 'photos';

  // YouTube Video URL
  static const String defaultYoutubeUrl = 'https://www.youtube.com/watch?v=OlAIUmoR87k';
}
