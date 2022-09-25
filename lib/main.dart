import 'package:color_gen/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final RandomColorGenerator _colorGenerator = RandomColorGenerator();
  HSVColor _color = HSVColor.fromColor(Colors.red);
  Color _textColor = Colors.white;

  void _generateNewColor() {
    HapticFeedback.selectionClick();

    setState(() {
      _color = _colorGenerator.newColor();
      _textColor = _color.toColor().computeLuminance() > 0.5
          ? Colors.black
          : Colors.white;
    });
  }

  void _copyColor() {
    HapticFeedback.selectionClick();

    Color color = _color.toColor();
    int red = color.red;
    int green = color.green;
    int blue = color.blue;
    Clipboard.setData(ClipboardData(text: "$red, $green, $blue"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                      color: _color.toColor(),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  GestureDetector(
                    onTap: _copyColor,
                    child: Container(
                      width: 150.0,
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                        color: _color.toColor(),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.color_lens,
                            color: _textColor,
                          ),
                          Text(
                            _color.toColor().red.toString(),
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                color: _textColor),
                          ),
                          Text(
                            _color.toColor().green.toString(),
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                color: _textColor),
                          ),
                          Text(
                            _color.toColor().blue.toString(),
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900,
                                color: _textColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Center(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingActionButton.extended(
                  onPressed: _generateNewColor,
                  label: const Text('Regenerate'),
                  icon: Icon(
                    Icons.refresh,
                    color: _textColor,
                  ),
                  foregroundColor: _textColor,
                  backgroundColor: _color.toColor(),
                ),
              ),
            ),
            // Expanded(
            //   child: Align(
            //     alignment: FractionalOffset.bottomCenter,
            //     child: FloatingActionButton.extended(
            //       onPressed: _generateNewColor,
            //       label: const Text('Regenerate'),
            //       icon: const Icon(Icons.refresh),
            //       backgroundColor: _color,
            //     ),
            //   ),
            // ),
            // Center(
            //   child: Text(
            //     'Color: ${_color.red}, ${_color.green}, ${_color.blue}',
            //     style: const TextStyle(
            //       fontSize: 20.0,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
