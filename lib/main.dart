import 'package:flutter/material.dart';

void main() => runApp(const App());

String _imageUri(int i) {
  final w = 1920 - i;
  return 'https://images.unsplash.com/photo-1595278724653-ef410db08d76?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=$w&q=80';
}

final _messureResults = [];
final items = List<ImageItem>.generate(
  100,
  (i) => ImageItem(
    imgPath: _imageUri(i),
  ),
);

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridView.count(
        crossAxisCount: 10,
        children: items,
      ),
    );
  }
}
// MaterialApp(home: ListView(children: items));

class ImageItem extends StatefulWidget {
  final String imgPath;

  ImageItem({required this.imgPath, Key? key}) : super(key: key);

  @override
  _ImageItemState createState() => _ImageItemState();
}

class _ImageItemState extends State<ImageItem> {
  final stopwatch = Stopwatch();
  @override
  Widget build(BuildContext context) {
    stopwatch.start();
    return Image.network(
      widget.imgPath,
      frameBuilder: (_, child, frame, __) {
        if (frame == 0) {
          _resetStopWatch();
          return child;
        }

        return child;
      },
    );
  }

  void _resetStopWatch() {
    _messureResults.add(stopwatch.elapsed.inMilliseconds);
    print('${stopwatch.elapsed.inMilliseconds}ms');
    stopwatch.stop();
    stopwatch.reset();
  }

  void _computeResults() {
    final sum = _messureResults.reduce((current, next) => current + next);
    _messureResults.sort();
    final max = _messureResults.last;
    final min = _messureResults.first;
    final avarage = sum / _messureResults.length;
    final deviation = (max - min) / 2;
    print('Average: $avarage ms, +/- $deviation ms, Max: $max ms');
  }
}
