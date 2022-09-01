import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  BlendMode blendMode = BlendMode.src;

  void _incrementCounter() {
    setState(() {
      final currentBlendModeValue = blendMode.index;
      final nextBlendModeValue = (currentBlendModeValue + 1) % BlendMode.values.length;
      blendMode = BlendMode.values[nextBlendModeValue];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blendMode.name),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://www.freepnglogos.com/uploads/spotify-logo-png/spotify-icon-marilyn-scott-0.png',
          ),
          Positioned.fromRect(
            rect: const Rect.fromLTWH(100.0, 100.0, 300.0, 300.0),
            child: FusionWidget(
              blendMode: blendMode,
              widget: Image.network(
                'https://www.freepnglogos.com/uploads/instagram-logo-png-transparent-0.png',
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.switch_access_shortcut),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class FusionWidget extends StatelessWidget {
  const FusionWidget({
    Key? key,
    required this.blendMode,
    required this.widget,
  }) : super(key: key);

  final BlendMode blendMode;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.matrix(Matrix4.identity().storage, filterQuality: FilterQuality.high),
        blendMode: blendMode,
        child: widget,
      ),
    );
  }
}
