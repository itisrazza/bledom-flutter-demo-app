import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:llumin8_bledom_demo/adapter/bledom_adapter.dart';

class SelectDevicePage extends StatefulWidget {
  const SelectDevicePage({Key? key}) : super(key: key);

  @override
  _SelectDevicePageState createState() => _SelectDevicePageState();
}

final _flutterBlue = FlutterBlue.instance;

class _SelectDevicePageState extends State<SelectDevicePage> {
  List<BluetoothDevice> _devices = [];
  Future<void>? _activeScan;

  void _scanBluetooth() {
    if (_activeScan != null) return;

    final activeScan =
        _flutterBlue.startScan(timeout: const Duration(seconds: 4));
    activeScan.then((val) {
      if (!mounted) return;
      setState(() {
        _activeScan = null;
      });
    });

    setState(() {
      _activeScan = activeScan;
    });

    _flutterBlue.scanResults.listen((results) {
      setState(() {
        if (!mounted) return;
        _devices = results.map((result) => result.device).toList();
      });
    });
  }

  void _selectDevice(BluetoothDevice device) async {
    print("Connecting to BLEDOM device");
    final led = await BLEDOMController.fromDevice(device);

    print("Connecting to set the colour");
    await led.setColor(const Color.fromARGB(255, 255, 212, 111));

    print("Previous page");
    Navigator.pop(context, led);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Select a device"),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Text("Select a device"),
                    const Spacer(),
                    IconButton(
                        onPressed: _activeScan != null ? null : _scanBluetooth,
                        icon: const Icon(Icons.refresh))
                  ],
                )),
            Expanded(
                child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final device = _devices[index];
                final name = device.name;
                final guid = device.id.toString();

                if (device.name.trim() == "") {
                  return ListTile(
                    title: Text(guid),
                    onTap: () => _selectDevice(device),
                  );
                } else {
                  return ListTile(
                    title: Text(name),
                    subtitle: Text(guid),
                    onTap: () => _selectDevice(device),
                  );
                }
              },
            ))
          ],
        ));
  }
}
