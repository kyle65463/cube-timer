import 'package:cubetimer/models/record/record.dart';
import 'package:cubetimer/models/record/track.dart';
import 'package:cubetimer/models/settings/options/language.dart';
import 'package:cubetimer/models/settings/options/theme.dart';
import 'package:cubetimer/models/settings/settings_key.dart';
import 'package:cubetimer/models/settings/settings_value.dart';
import 'package:cubetimer/models/solve/move/rotate.dart';
import 'package:cubetimer/models/solve/move/turn.dart';
import 'package:cubetimer/repositories/database/database.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase extends Database {
  // Variables
  late Box<SettingsValue> _settingsBox;
  late Box<Track> _trackBox;

  // Functions
  /* Initialize */
  @override
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EnUSAdapter());
    Hive.registerAdapter(ZhTWAdapter());
    Hive.registerAdapter(BrownThemeAdapter());
    Hive.registerAdapter(WhiteThemeAdapter());
    Hive.registerAdapter(RecordAdapter());
    Hive.registerAdapter(TrackAdapter());
    Hive.registerAdapter(TurnRAdapter());
    Hive.registerAdapter(TurnLAdapter());
    Hive.registerAdapter(TurnUAdapter());
    Hive.registerAdapter(TurnDAdapter());
    Hive.registerAdapter(TurnFAdapter());
    Hive.registerAdapter(TurnBAdapter());
    Hive.registerAdapter(TurnMAdapter());
    Hive.registerAdapter(TurnSAdapter());
    Hive.registerAdapter(TurnEAdapter());
    Hive.registerAdapter(RotateXAdapter());
    Hive.registerAdapter(RotateYAdapter());
    Hive.registerAdapter(RotateZAdapter());
    _settingsBox = await Hive.openBox('settings');
    _trackBox = await Hive.openBox('track');
  }

  /* Settings */
  @override
  Stream getSettingsStream() {
    return _settingsBox.watch();
  }

  @override
  SettingsValue loadSettingsValue(SettingsKey key) {
    final SettingsValue? value = _settingsBox.get(key.name);
    if (value == null) {
      _settingsBox.put(key.name, key.defaultValue);
      return key.defaultValue;
    }
    return value;
  }

  @override
  void updateSettingsValue(SettingsKey key, SettingsValue value) {
    _settingsBox.put(key.name, value);
  }

  /* Tracks */
  @override
  Stream getTrackStream() {
    return _trackBox.watch();
  }

  @override
  List<Track> loadTracks() {
    final List<Track> tracks = _trackBox.values.toList();
    if (tracks.isEmpty) {
      final Track defaultTrack = Track.defaultValue();
      _trackBox.put(defaultTrack.id, defaultTrack);
      return [defaultTrack];
    }
    return tracks;
  }

  @override
  void createTrack(Track track) {
    _trackBox.put(track.id, track);
  }

  @override
  void updateTrack(Track track) {
    track.save();
  }

  @override
  void deleteTrack(Track track) {
    track.delete();
  }
}