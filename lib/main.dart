import 'package:flutter/material.dart';
import 'package:llumin8_bledom_demo/pages/select_device_page.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  Color _color = const Color.fromARGB(255, 120, 64, 255);

  void _changeRed(double red) {
    setState(() {
      _color = _color.withRed((255 * red).toInt());
    });
  }

  void _changeGreen(double green) {
    setState(() {
      _color = _color.withGreen((255 * green).toInt());
    });
  }

  void _changeBlue(double blue) {
    setState(() {
      _color = _color.withBlue((255 * blue).toInt());
    });
  }

  void _commit() {
    // send the command to the device
  }

  void _changeDevice() {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) {
      return SelectDevicePage();
    }));
  }

  String _colorToHex(Color c) {
    return "#${c.red.toRadixString(16).padLeft(2, '0')}${c.green.toRadixString(16).padLeft(2, '0')}${c.blue.toRadixString(16).padLeft(2, '0')}"
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: _color,
              padding: const EdgeInsetsDirectional.only(top: 32, bottom: 32),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      _colorToHex(_color),
                      style: TextStyle(
                          fontSize: 32,
                          color: _color.computeLuminance() > 0.45
                              ? Colors.black
                              : Colors.white),
                    )
                  ],
                ),
              ),
            ),

            // Colour sliders
            Slider(
              value: _color.red.toDouble() / 255,
              onChanged: _changeRed,
              activeColor: Colors.red,
              thumbColor: Colors.redAccent,
              inactiveColor: Colors.red.shade100,
            ),
            Slider(
              value: _color.green.toDouble() / 255,
              onChanged: _changeGreen,
              activeColor: Colors.green,
              thumbColor: Colors.greenAccent,
              inactiveColor: Colors.green.shade100,
            ),
            Slider(
              value: _color.blue.toDouble() / 255,
              onChanged: _changeBlue,
              activeColor: Colors.blue,
              thumbColor: Colors.blueAccent,
              inactiveColor: Colors.blue.shade100,
            ),
            ElevatedButton(child: const Text("Change"), onPressed: () {})
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _changeDevice,
        tooltip: 'Increment',
        child: const Icon(Icons.swap_horiz),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
