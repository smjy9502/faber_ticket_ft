import 'package:faber_ticket_ft/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/screens/custom_screen.dart';
import 'package:faber_ticket_ft/screens/song_screen.dart';
import 'package:faber_ticket_ft/widgets/custom_button.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! < 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CustomScreen()),
            );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Constants.ticketFrontImage),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: SizedBox()),
                    CustomButton(
                      image: Constants.buttonSetlistImage,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SongScreen()),
                        );
                      },
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 50,
                    ),
                    SizedBox(height: Constants.paddingLarge),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
