import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/youtube_service.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final List<String> songTitles = [
    'Best Part', 'Better Better', 'Healer', '한 페이지가 될 수 있게', '그녀가 웃었다', 'How to love', '쏟아진다', 'Say Wow', '예뻤어', 'I loved You',
    '놓아 놓아 놓아 (reboot ver.)', 'Congratulations', '어떻게 말해', '아 왜 (I Wait)', 'Love me or Leave me', 'Shoot Me', '괴물', 'Zombie', '녹아내려요', 'HAPPY',
    '바래', '도와줘요 Rock&Roll', '망겜', 'DANCE DANCE', 'Free하게', 'My day', 'First Time', 'Welcome to the Show'
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: AspectRatio(
                  aspectRatio: 9 / 16,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Constants.setlistBackgroundImage),
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    child: SafeArea(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: SizedBox()),
                          Image.asset('assets/images/setlist_player.gif'),
                          Expanded(child: SizedBox()),
                          GestureDetector(
                            onPanUpdate: (details) {
                              if (details.delta.dx > 0) {
                                setState(() {
                                  _currentIndex = (_currentIndex - 1 + songTitles.length) % songTitles.length;
                                });
                              } else if (details.delta.dx < 0) {
                                setState(() {
                                  _currentIndex = (_currentIndex + 1) % songTitles.length;
                                });
                              }
                            },
                            child: Text(
                              songTitles[_currentIndex],
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Expanded(child: SizedBox()),
                          CustomButton(
                            image: Constants.buttonSetlistImage,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            width: 100,
                            height: 30,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
