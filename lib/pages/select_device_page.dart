import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectDevicePage extends StatefulWidget {
  const SelectDevicePage({Key? key}) : super(key: key);

  @override
  _SelectDevicePageState createState() => _SelectDevicePageState();
}

class _SelectDevicePageState extends State<SelectDevicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select a device"),
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Text("Select a device"),
                    Spacer(),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.refresh))
                  ],
                ))
          ],
        ));
  }
}
