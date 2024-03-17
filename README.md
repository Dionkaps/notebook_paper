<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->
![notebook image](https://github.com/Dionkaps/notebook_paper/assets/46134991/d02f2657-5364-439c-962e-d78848682a43)

# Notebook Paper

Craft beautiful notebook-like interfaces in Flutter with ease using Notebook Paper, a customizable widget package.

## Features

- Mimics the appearance of notebook paper.
- Customizable properties such as font size, text content, and colors.
- Easy integration into Flutter projects.


## Usage

import 'package:notebook_paper/notebook_paper.dart';

Use the NotebookPaper widget to create notebook-like interfaces:

NotebookPaper(
  entireText: 'Your text here',
  title: 'Notebook Title',
  fontSize: 20.0,
  rowHeight: 1.0,
  width: 1.0,
  paperColor: Colors.white,
  horizontalLinesColor: Colors.grey,
  verticalLinesColor: Colors.black,
  pageTitle: true,
)


## Installation

Add the following line to your `pubspec.yaml` file:

```yaml
dependencies:
  notebook_paper: ^1.0.0

