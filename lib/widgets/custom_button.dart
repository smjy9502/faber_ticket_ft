import 'package:flutter/material.dart';
import 'package:faber_ticket_ft/utils/constants.dart';

class CustomButton extends StatelessWidget {
  final String image;
  final VoidCallback onPressed;
  final double width;
  final double height;

  const CustomButton({
    Key? key,
    required this.image,
    required this.onPressed,
    this.width = 200,
    this.height = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
        ),
      ),
    );
  }
}
