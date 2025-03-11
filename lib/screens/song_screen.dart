import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SongScreen extends StatefulWidget {
  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  final List<SongInfo> songInfos = [
    SongInfo('Best Part', 'The Book of Us : Gravity', 'https://youtu.be/a-UfQfufkgU?si=f-Y4YeKPxz3DcH3F', 0),
    SongInfo('Better Better', 'MOONRISE', 'https://youtu.be/7qkznpWePpY?si=uLTEa8pLwNL0yhMA', 1),
    SongInfo('Healer', 'The Book of Us : Negentropy', 'https://youtu.be/HXEG0fqrViM?si=PY5WUHkY5mT9dqcd', 2),
    SongInfo('한 페이지가 될 수 있게', 'The Book of Us : Gravity', 'https://youtu.be/vnS_jn2uibs?si=YliqloRK12WZ2TI8', 3),
    SongInfo('그녀가 웃었다', 'Band Aid', 'https://youtu.be/09ig852MsMg?si=BcedZECKDmA--r1A', 4),
    SongInfo('How to love', 'The Book of Us : Gravity', 'https://youtu.be/qCZm8abq8Co?si=X0FxVgmSdX6FRDZs', 5),
    SongInfo('쏟아진다', 'Every DAY6 November', 'https://youtu.be/IUGSKW12lHY?si=7OnG_f8a1uA8L5FW', 6),
    SongInfo('Say Wow', 'Every DAY6 April', 'https://youtu.be/8meVwcHtoQk?si=367m1l71yl-pHc7G', 7),
    SongInfo('예뻤어', 'Every DAY6 February', 'https://youtu.be/BS7tz2rAOSA?si=VlL4d6vbNMfxsckJ', 8),
    SongInfo('I Loved You', 'Every DAY6 September', 'https://youtu.be/EwLMA5XYnKI?si=mq92l0YXcGxyRCKM', 9),
    SongInfo('놓아 놓아 놓아(Reboot Ver.)', 'SUNRISE', 'https://youtu.be/EErj6GjObew?si=kUBKP6xbkkJUyTyp', 10),
    SongInfo('Congratulations', 'The Day', 'https://youtu.be/x3sFsHrUyLQ?si=TeUX-eDmwA4nc3jT', 11),
    SongInfo('어떻게 말해', 'Every DAY6 March', 'https://youtu.be/dwywhL1PenQ?si=hKei7L5tjC82mIym', 12),
    SongInfo('아 왜(I Wait)', 'Every DAY6 January', 'https://youtu.be/O3nFopIjmjI?si=HcEP9tc_KkSmUDnL', 13),
    SongInfo('Love me or Leave me', 'The Book of Us : The Demon', 'https://youtu.be/LlFcvjDBSCU?si=DZtWQ4AXgxDgfqCY', 14),
    SongInfo('Shoot Me', 'Shoot Me : Youth Part 1', 'https://youtu.be/g2X2LdJAIpU?si=eg5BzkO4Ny5Xdj7p', 15),
    SongInfo('괴물', 'Band Aid', 'https://youtu.be/QPsJrZGB_gc?si=2JzpeS7sxO9I0ig1', 16),
    SongInfo('Zombie', 'The Book of Us : The Demon', 'https://youtu.be/k8gx-C7GCGU?si=LIo3wR3IrFOofJYZ', 17),
    SongInfo('녹아내려요', 'Band Aid', 'https://youtu.be/yss4rIrHl6o?si=Og2YWJXS1gW64Wq2', 18),
    SongInfo('HAPPY', 'Fourever', 'https://youtu.be/2dFwndi4ung?si=qHm7I9HkY5mT9mSfX', 19),
    SongInfo('바래', 'DAYDREAM', 'https://youtu.be/agNEwhiVj7Y?si=4d3Rp2UKL9i9mSfX', 20),
    SongInfo('도와줘요 Rock&Roll', 'Band Aid', 'https://youtu.be/LCpEVQ9yvVk?si=vkf_QKcvPDf6tWd7', 21),
    SongInfo('망겜', 'Band Aid', 'https://youtu.be/mqxDy2_GVLU?si=BkRmNspF4yj-Z-JY', 22),
    SongInfo('DANCE DANCE', 'Every DAY6 May', 'https://youtu.be/NAW0idSQ6Zs?si=FghTVnopQ1cQspae', 23),
    SongInfo('Free하게', 'The Day', 'https://youtu.be/SujoDZYCMCs?si=XVBGscEJQ3z9CFIX', 24),
    SongInfo('My Day', 'Every DAY6 February', 'https://youtu.be/hA5v5zqKX3s?si=Sx_41E4TkheD6fGg', 25),
    SongInfo('First Time', 'DAYDREAM', 'https://youtu.be/6bFj0cu4UJ8?si=2PXUoPDHh4pl-74A', 26),
    SongInfo('Welcome to the Show', 'Fourever', 'https://youtu.be/RowlrvmyFEk?si=7IQyAJQeL8oL9acK', 27),
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
            top: 5,
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
                Expanded(flex: 2, child: SizedBox()), // 위쪽 여백 늘리기
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Opacity(
                      opacity: 0.5,
                      child: Transform.rotate(
                        angle: -0.1, // 왼쪽으로 살짝 기울임
                      child: Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/${Constants.coverImages[(_currentIndex - 1 + songInfos.length) % songInfos.length]}',
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              songInfos[(_currentIndex - 1 + songInfos.length) % songInfos.length].albumTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              songInfos[(_currentIndex - 1 + songInfos.length) % songInfos.length].songTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                     ),
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              final url = songInfos[_currentIndex].youtubeLink;
                              if (await canLaunchUrl(Uri.parse(url))) {
                                await launchUrl(Uri.parse(url));
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                            child: Image.asset(
                              'assets/images/${Constants.coverImages[_currentIndex]}',
                              width: 250,
                              height: 250,
                            ),
                          ),
                          Text(
                            songInfos[_currentIndex].albumTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            songInfos[_currentIndex].songTitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Opacity(
                      opacity: 0.5,
                      child: Transform.rotate(
                        angle: 0.1, // 오른쪽으로 살짝 기울임
                      child: Container(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/${Constants.coverImages[(_currentIndex + 1) % songInfos.length]}',
                              width: 50,
                              height: 50,
                            ),
                            Text(
                              songInfos[(_currentIndex + 1) % songInfos.length].albumTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              songInfos[(_currentIndex + 1) % songInfos.length].songTitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                     ),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()), // 아래쪽 여백 늘리기
              ],
            ),
          ),
          GestureDetector(
            onPanEnd: (details) {
              if (details.velocity.pixelsPerSecond.dx > 0) {
                setState(() {
                  _currentIndex = (_currentIndex - 1 + songInfos.length) % songInfos.length;
                });
              } else if (details.velocity.pixelsPerSecond.dx < 0) {
                setState(() {
                  _currentIndex = (_currentIndex + 1) % songInfos.length;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class SongInfo {
  final String songTitle;
  final String albumTitle;
  final String youtubeLink;
  final int index;

  SongInfo(this.songTitle, this.albumTitle, this.youtubeLink, this.index);
}
