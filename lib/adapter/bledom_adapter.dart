import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:llumin8_bledom_demo/adapter/led_adapter.dart';


class BLEDOMController extends LEDController {
  static final Guid bleCharacteristic = Guid("0000fff3-0000-1000-8000-00805f9b34fb");

  @override
  String get name => _device.name;

  late String _guid;

  BluetoothDevice _device;
  BluetoothCharacteristic _characteristic;

  @override
  String get guid => _guid;

  @override
  Set<LEDAdapterCapability> get capabilities =>
      {LEDAdapterCapability.realtimeControl, LEDAdapterCapability.fadePreset};

  BLEDOMController(this._device, this._characteristic) {
    _guid = _device.id.toString();
  }

  static Future<BLEDOMController> fromDevice(BluetoothDevice device) async {
    BluetoothCharacteristic? targetCharacteristic;

    var services = await device.discoverServices();
    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.uuid == bleCharacteristic) {
          targetCharacteristic = characteristic;
        }
      }
    }

    if (targetCharacteristic == null) {
      throw UnsupportedError("This device does not advertise BLEDOM characteristic.");
    }

    return BLEDOMController(device, targetCharacteristic);
  }

  /// Sends an arbitrary command to the LED controller.
  Future<void> sendCommand(int id, [int arg0 = 0, int arg1 = 0, int arg2 = 0, int arg3 = 0, int arg4 = 0]) {
    return _characteristic.write([ 0x7E, 0x00, id, arg0, arg1, arg2, arg3, arg4, 0xEF ]);
  }

  // basic

  @override
  Future<void> setColor(Color color) {
    return sendCommand(0x05, 0x03, color.red, color.green, color.blue);
  }

  // fade preset capability

  @override
  List<FadePreset> get fadePresets => [
        FadePreset("JUMP_RED_GREEN_BLUE", "0x87"),
        FadePreset("JUMP_RED_GREEN_BLUE_YELLOW_CYAN_MAGENTA_WHITE", "0x88"),
        FadePreset("Cross-fade between black and red", "0x8b"),
        FadePreset("Cross-fade between black and green", "0x8c"),
        FadePreset("Cross-fade between black and blue", "0x8d"),
        FadePreset("Yeah, uh huh, you know what it is (black and yellow)", "0x8e"),
        FadePreset("Cross-fade between black and cyan", "0x8f"),
        FadePreset("Cross-fade between black and magenta", "0x90"),
        FadePreset("Cross-fade between black and white", "0x91"),
        FadePreset("Cross-fade between red and green", "0x92"),
        FadePreset("Cross-fade between red and blue", "0x93"),
        FadePreset("Cross-fade between green and blue", "0x94"),
        FadePreset("Cross-fade between red, green and blue", "0x89"),
        FadePreset("Cross-fade between all colours", "0x8a"),
        FadePreset("BLINK_RED", "0x96"),
        FadePreset("BLINK_GREEN", "0x97"),
        FadePreset("BLINK_BLUE", "0x98"),
        FadePreset("BLINK_YELLOW", "0x99"),
        FadePreset("BLINK_CYAN", "0x9a"),
        FadePreset("BLINK_MAGENTA", "0x9b"),
        FadePreset("BLINK_WHITE", "0x9c"),
        FadePreset("BLINK_RED_GREEN_BLUE_YELLOW_CYAN_MAGENTA_WHITE", "0x95")
      ];

  @override
  Future<void> setFade(FadePreset preset) async {
    sendCommand(0x03, int.parse(preset.id));
  }

  // fade custom capability

  @override
  int get fadeColorLimit => 0;

  @override
  Future<void> setFadeColors(List<Color> colors) => throw UnsupportedError(
      "BLEDOM doesn't support fading between arbitrary colours.");
}
