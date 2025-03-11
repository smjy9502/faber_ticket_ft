import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/youtube_service.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'custom_screen.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final List<String> songTitles = [
    '1. Best Part', '2. Better Better', '3. Healer', '4. 한 페이지가 될 수 있게', '5. 그녀가 웃었다', '6. How to love', '7. 쏟아진다', '8. Say Wow', '9. 예뻤어', '10. I loved You',
    '11. 놓아 놓아 놓아 (reboot ver.)', '12. Congratulations', '13. 어떻게 말해', '14. 아 왜 (I Wait)', '15. Love me or Leave me', '16. Shoot Me', '17. 괴물', '18. Zombie', '19. 녹아내려요', '20. HAPPY',
    '21. 바래', '22. 도와줘요 Rock&Roll', '23. 망겜', '24. DANCE DANCE', '25. Free하게', '26. My day', '27. First Time', '28. Welcome to the Show'
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => CustomScreen()),
            );
          },
        ),
      ),
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
                                style: TextStyle(fontSize: 24),
                              ),
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
