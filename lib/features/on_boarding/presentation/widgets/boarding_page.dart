import 'package:fitness_app/features/on_boarding/presentation/widgets/footer.dart';
import 'package:flutter/material.dart';

class BoardingPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final void Function(int)? onDotTap;
  final Widget button;
  const BoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    required this.onDotTap,
    required this.button,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenSize.height * 0.66,
              width: double.infinity,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ],
        ),
        Footer(
          title: title,
          onDotTap: onDotTap,
          description: description,
          buttton: button,
        ),
      ],
    );
  }
}
