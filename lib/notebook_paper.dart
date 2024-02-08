library notebook_paper;

import 'package:flutter/material.dart';
export 'notebook_paper.dart';

/// The NotebookPaper widget represents a piece of notebook paper.
/// It allows customization of various properties such as font size, text content, and colors.
class NotebookPaper extends StatelessWidget {
  /// The entire text content to be displayed on the notebook paper.
  final String entireText;

  /// The title to be displayed at the top of the notebook paper.
  final String title;

  /// The font size of the text content on the notebook paper.
  final double fontSize;

  /// The height of each row on the notebook paper.
  final double rowHeight;

  /// The width of the notebook paper.
  final double width;

  /// A flag indicating whether to display a title at the top of the notebook paper.
  final bool pageTitle;

  /// The background color of the notebook paper.
  final Color paperColor;

  /// The color of the horizontal lines on the notebook paper.
  final Color horizontalLinesColor;

  /// The color of the vertical lines on the notebook paper.
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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
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
  /// The font size of the text content on the notebook paper.
  final double? fontSize;

  /// The length of text displayed on each line.
  double textLength = 0.0;

  /// The number of lines needed to display the entire text content.
  double lines = 0.0;

  /// The entire text content to be displayed on the notebook paper.
  final String entireText;

  /// The title to be displayed at the top of the notebook paper.
  final String title;

  /// A flag indicating whether to display a title at the top of the notebook paper.
  final bool? pageTitle;

  /// The background color of the notebook paper.
  final Color? paperColor;

  /// The color of the horizontal lines on the notebook paper.
  final Color? horizontalLinesColor;

  /// The color of the vertical lines on the notebook paper.
  final Color? verticalLinesColor;

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
    final paintgrey = Paint()..color = const Color.fromARGB(110, 158, 158, 158);
    var rrectRed = RRect.fromLTRBR(
        0, 0, size.width, size.height, const Radius.circular(8.0));
    canvas.drawRRect(rrectRed, paintgrey);

    final paintWhite = Paint()..color = paperColor!;
    var rrectWhite = RRect.fromLTRBR(
        5, 0, size.width, size.height, const Radius.circular(8.0));
    canvas.drawRRect(rrectWhite, paintWhite);

    final paintDarkgrey = Paint()
      ..color = horizontalLinesColor!
      ..strokeWidth = 1.0;

    final paintPink = Paint()
      ..color = verticalLinesColor!
      ..strokeWidth = 2.5;
    canvas.drawLine(Offset(size.width * .1, 0),
        Offset(size.width * .1, size.height), paintPink);

    textLength = size.width * 1.7 / fontSize!;
    lines = entireText.length / textLength;
    lines = lines.ceilToDouble() + 1;

    if (entireText.contains('\n')) {
      lines = lines + 2;
    }

    List<String> words = entireText.split(' ');

    int wordIndex = 0;
    for (int i = 0; i < lines; i++) {
      double heightFraction = i / lines;

      if (i != 0) {
        canvas.drawLine(Offset(0, size.height * heightFraction),
            Offset(size.width, size.height * heightFraction), paintDarkgrey);
      }

      String paragraphText = '';
      double currentFontSize = fontSize!;
      if (i == 0 && pageTitle!) {
        paragraphText = title;
        currentFontSize += 2;
      } else {
        while (wordIndex < words.length &&
            (paragraphText.length + words[wordIndex].length) <= textLength) {
          paragraphText += words[wordIndex] + ' ';
          wordIndex++;
        }
      }

      final textSpan = TextSpan(
        text: paragraphText,
        style: TextStyle(
          color: Colors.black,
          fontSize: currentFontSize,
          fontWeight: i == 0 ? FontWeight.bold : FontWeight.w500,
        ),
      );

      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.end,
      );

      textPainter.layout(maxWidth: size.width);
      double textHeight = textPainter.height;
      double offsetHeight = (size.height / lines - textHeight) / 2;
      double offsetWidth = size.width * .1;
      textPainter.paint(
          canvas, Offset(offsetWidth, size.height * i / lines + offsetHeight));
    }
  }

  @override
  bool shouldRepaint(PagePainter oldDelegate) {
    return oldDelegate.entireText != entireText || oldDelegate.title != title;
  }
}
