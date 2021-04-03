import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLENotifier with ChangeNotifier {
  bool _loading;
  bool _isAutoModeOn;
  Timer _timer;
  BLENotifier() {
    _isAutoModeOn = false;
    scan();
  }

  Stream<List<ScanResult>> get bluetoothDevicesStream =>
      FlutterBlue.instance.scanResults;
  bool get isLoading => _loading;
  bool get isAutoModeOn => _isAutoModeOn;

  startAutoScan() {
    _isAutoModeOn = true;
    notifyListeners();
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      scan();
    });
  }

  stopAutoScan() {
    _isAutoModeOn = false;
    _timer?.cancel();
    notifyListeners();
  }

  scan() async {
    _loading = true;
    notifyListeners();
    await FlutterBlue.instance.startScan(
      timeout: Duration(seconds: 2),
    );
    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
