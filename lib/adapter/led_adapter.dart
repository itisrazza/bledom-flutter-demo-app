import 'dart:ui';

/// Represents a generic adapter for an LED light. Allows for generic control of
/// LED devices without being aware of how communication is handled.
abstract class LEDController {
  /// The viewable name of the LED controller.
  String get name;

  /// A unique string identifying each LED controller.
  String get guid;

  /// The capabilities this adapter supports.
  Set<LEDAdapterCapability> get capabilities;

  // basic

  /// Powers the LEDs on.
  Future<void> powerOn();

  /// Powers the LEDs off.
  Future<void> powerOff();

  /// Sets a static color on the LED controller.
  Future<void> setColor(Color color);

  // fade preset capability

  /// The known fade presets. If the LEDAdapterCapability.fadePreset is not
  /// supported, the list will be empty.
  List<FadePreset> get fadePresets;

  Future<void> setFade(FadePreset preset);

  // fade custom capability

  /// The maximum size of the list.
  int get fadeColorLimit;

  Future<void> setFadeColors(List<Color> colors);
}

/// Represents a known capability of an LED controller
enum LEDAdapterCapability {
  /// The controller supports fading between known preset colours.
  fadePreset,

  /// The controller supports fading between any colour combination.
  fadeCustom,

  /// The controller supports updating the colour near real-time with minimal lag.
  realtimeControl,
}

class FadePreset {
  /// The user visible name of the preset.
  final String name;

  /// The preset ID.
  final String id;

  FadePreset(this.name, this.id);
  // note for the boys: this is a big brain constructor

  @override
  bool operator ==(Object other) =>
      other is FadePreset && name == other.name && id == other.id;

  @override
  int get hashCode => name.hashCode << 11 | id.hashCode;
}
