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
  static const String photoBackgroundImage = 'assets/images/photo_background.webp';
  static const String errorBackgroundImage = 'assets/images/error_background.jpg';
  static const String buttonSetlistImage = 'assets/images/button_setlist.jpg';
  static const List<String> coverImages = [
    'cover_1.webp',
    'cover_2.webp',
    'cover_3.webp',
    'cover_4.webp',
    'cover_5.webp',
    'cover_6.webp',
    'cover_7.webp',
    'cover_8.webp',
    'cover_9.webp',
    'cover_10.webp',
    'cover_11.webp',
    'cover_12.webp',
    'cover_13.webp',
    'cover_14.webp',
    'cover_15.webp',
    'cover_16.webp',
    'cover_17.webp',
    'cover_18.webp',
    'cover_19.webp',
    'cover_20.webp',
    'cover_21.webp',
    'cover_22.webp',
    'cover_23.webp',
    'cover_24.webp',
    'cover_25.webp',
    'cover_26.webp',
    'cover_27.webp',
    'cover_28.webp',
  ];
  static const String petalFullImage = 'assets/images/petal_full.png';
  static const String petalEmptyImage = 'assets/images/petal_empty.png';


  // Firebase Collection Names
  static const String customDataCollection = 'custom_data';
  static const String photosCollection = 'photos';

  // YouTube Video URL
  static const String defaultYoutubeUrl = 'https://www.youtube.com/watch?v=OlAIUmoR87k';
}
