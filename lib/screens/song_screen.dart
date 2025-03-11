import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final List<String> songTitles = [
    'Best Part', 'Better Better', 'Healer', '한 페이지가 될 수 있게', '그녀가 웃었다',
    'How to love', '쏟아진다', 'Say Wow', '예뻤어', 'I loved You',
    '놓아 놓아 놓아 (reboot ver.)', 'Congratulations', '어떻게 말해',
    '아 왜 (I Wait)', 'Love me or Leave me', 'Shoot Me', '괴물',
    'Zombie', '녹아내려요', 'HAPPY', '바래', '도와줘요 Rock&Roll',
    '망겜', 'DANCE DANCE', 'Free하게', 'My day', 'First Time',
    'Welcome to the Show'
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.setlistBackgroundImage),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => CustomScreen()),
                );
              },
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: SizedBox()),
                Image.asset('assets/images/setlist_player.gif'),
                Expanded(child: SizedBox()),
                GestureDetector(
                  onPanEnd: (details) {
                    if (details.velocity.pixelsPerSecond.dx > 0) {
                      setState(() {
                        if (_currentIndex > 0) {
                          _currentIndex--;
                        } else {
                          _currentIndex = songTitles.length - 1;
                        }
                      });
                    } else if (details.velocity.pixelsPerSecond.dx < 0) {
                      setState(() {
                        if (_currentIndex < songTitles.length - 1) {
                          _currentIndex++;
                        } else {
                          _currentIndex = 0;
                        }
                      });
                    }
                  },
                  child: GestureDetector(
                    onTap: () async {
                      final url = 'https://www.youtube.com/watch?v=i_xKWvhGV90';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url));
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      songTitles[_currentIndex],
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
