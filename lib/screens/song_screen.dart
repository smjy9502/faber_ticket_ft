import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/services/youtube_service.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';

class SongScreen extends StatelessWidget {
  final List<String> songTitles = List.generate(10, (index) => 'Song ${index + 1}');

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
                          ...songTitles.map((title) => TextButton(
                            child: Text(title),
                            onPressed: () {
                              YoutubeService().playVideo("https://www.youtube.com/watch?v=OlAIUmoR87k", context);
                            },
                          )).toList(),
                          CustomButton(
                            image: 'assets/images/button_setlist.jpg',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
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
