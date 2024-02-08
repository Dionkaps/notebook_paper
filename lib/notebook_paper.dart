/// A Flutter package that provides a customizable notebook paper widget for creating notebook-like interfaces.
/// This widget mimics the appearance of a notebook paper, including horizontal and vertical lines, with support for adding text content.
library notebook_paper;

import 'package:flutter/material.dart';

/// The NotebookPaper widget represents a piece of notebook paper.
/// It allows customization of various properties such as font size, text content, and colors.
class NotebookPaper extends StatelessWidget {
  // Properties for customization
  final double fontSize;
  final String entireText;
  final String title;
  final double rowHeight;
  final double width;
  final bool pageTitle;
  final Color paperColor;
  final Color horizontalLinesColor;
  final Color verticalLinesColor;

  /// Constructs a NotebookPaper widget with the given parameters.
  const NotebookPaper({
    required this.entireText,
    this.title = '',
    this.fontSize = 20.0,
    this.rowHeight = 1.0,
    this.width = 1.0,
    this.paperColor = const Color.fromARGB(255, 227, 212, 150),
    this.horizontalLinesColor = Colors.blueGrey,
    this.verticalLinesColor = Colors.pink,
    this.pageTitle = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calculate screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Return CustomPaint widget to draw the notebook paper
    return CustomPaint(
      foregroundPainter: PagePainter(
        fontSize: fontSize,
        entireText: entireText,
        title: title,
        paperColor: paperColor,
        horizontalLinesColor: horizontalLinesColor,
        verticalLinesColor: verticalLinesColor,
        pageTitle: pageTitle,
      ),
      child: SizedBox(
        width: screenWidth * width,
        height: screenHeight *
            rowHeight *
            0.06 *
            ((entireText.length / (screenWidth * 1.7 / 20)).ceilToDouble() + 1),
      ),
    );
  }
}

/// The PagePainter class is responsible for painting the notebook paper on the canvas.
/// It draws horizontal and vertical lines, along with the text content.
class PagePainter extends CustomPainter {
  // Properties for customization
  double? fontSize;
  double textLength = 0.0;
  double lines = 0.0;
  String entireText;
  String title;
  bool? pageTitle = true;
  Color? paperColor;
  Color? horizontalLinesColor;
  Color? verticalLinesColor;

  /// Constructs a PagePainter with the given parameters.
  PagePainter({
    required this.entireText,
    required this.title,
    this.fontSize,
    this.paperColor,
    this.pageTitle,
    this.horizontalLinesColor,
    this.verticalLinesColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Paint the background with grey color
    final paintgrey = Paint()..color = const Color.fromARGB(110, 158, 158, 158);
    var rrectRed = RRect.fromLTRBR(
        0, 0, size.width, size.height, const Radius.circular(8.0));
    canvas.drawRRect(rrectRed, paintgrey);

    // Paint the paper with white color
    final paintWhite = Paint()..color = paperColor!;
    var rrectWhite = RRect.fromLTRBR(
        5, 0, size.width, size.height, const Radius.circular(8.0));
    canvas.drawRRect(rrectWhite, paintWhite);

    // Paint horizontal lines with dark grey color
    final paintDarkgrey = Paint()
      ..color = horizontalLinesColor!
      ..strokeWidth = 1.0;

    // Paint vertical lines with pink color
    final paintPink = Paint()
      ..color = verticalLinesColor!
      ..strokeWidth = 2.5;
    canvas.drawLine(Offset(size.width * .1, 0),
        Offset(size.width * .1, size.height), paintPink);

    // New code to draw text
    textLength = size.width * 1.7 / fontSize!;
    lines = entireText.length / textLength;
    lines = lines.ceilToDouble() + 1;

    if (entireText.contains('\n')) {
      lines = lines + 2;
    }

    // Split the entireText into words
    List<String> words = entireText.split(' ');

    // Draw lines and text
    int wordIndex = 0;
    for (int i = 0; i < lines; i++) {
      double heightFraction = i / lines;

      // Skip drawing the dark grey line for the first iteration
      if (i != 0) {
        canvas.drawLine(Offset(0, size.height * heightFraction),
            Offset(size.width, size.height * heightFraction), paintDarkgrey);
      }

      // Add words to the paragraph until the total length exceeds textLength
      String paragraphText = '';
      double currentFontSize = fontSize!;
      if (i == 0 && pageTitle!) {
        paragraphText = title;
        currentFontSize += 2; // Increase the font size for the title
      } else {
        while (wordIndex < words.length &&
            (paragraphText.length + words[wordIndex].length) <= textLength) {
          paragraphText += '${words[wordIndex]} ';
          wordIndex++;
        }
      }

      // Create a TextSpan with the paragraphText
      final textSpan = TextSpan(
        text: paragraphText,
        style: TextStyle(
          color: Colors.black,
          fontSize: currentFontSize,
          fontWeight:
              i == 0 ? FontWeight.bold : FontWeight.w500, // Make the title bold
        ),
      );

      // Create a TextPainter with the TextSpan
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end, // Align the text to the start
      );

      textPainter.layout(maxWidth: size.width);
      double textHeight = textPainter.height;
      double offsetHeight = (size.height / lines - textHeight) / 2;
      double offsetWidth =
          size.width * .1; // Set offsetWidth to the red line's x-coordinate
      textPainter.paint(
          canvas, Offset(offsetWidth, size.height * i / lines + offsetHeight));
    }
  }

  @override
  bool shouldRepaint(PagePainter oldDelegate) {
    return oldDelegate.entireText != entireText || oldDelegate.title != title;
  }
}
