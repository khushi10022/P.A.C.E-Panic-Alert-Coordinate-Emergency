import 'dart:async';
import 'package:flutter/material.dart';
import '../shared/models/device_model.dart';

/// SheShield – Bluetooth Service
///
/// BLE communication layer for the smart safety band.
/// Uses a simulated interface when no hardware is available.
class BluetoothService {
  // Connection state
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  // Current device
  DeviceModel? _connectedDevice;
  DeviceModel? get connectedDevice => _connectedDevice;

  // Stream controllers
  final _connectionStateController = StreamController<bool>.broadcast();
  final _devicesController = StreamController<List<DeviceModel>>.broadcast();
  final _batteryController = StreamController<int>.broadcast();

  Stream<bool> get connectionState => _connectionStateController.stream;
  Stream<List<DeviceModel>> get discoveredDevices => _devicesController.stream;
  Stream<int> get batteryLevel => _batteryController.stream;

  /// Start scanning for nearby devices
  Future<void> startScan() async {
    debugPrint('🔵 Starting Bluetooth scan...');
    
    // Simulated scan results for development
    await Future.delayed(const Duration(seconds: 2));
    
    final mockDevices = [
      DeviceModel(
        id: 'PACE-BAND-001',
        name: 'P.A.C.E. Wearable Band',
        rssi: -45,
        isConnected: false,
        batteryLevel: 85,
        firmwareVersion: '1.2.0',
      ),
      DeviceModel(
        id: 'PACE-BAND-002',
        name: 'P.A.C.E. Smart Band Pro',
        rssi: -62,
        isConnected: false,
        batteryLevel: 72,
        firmwareVersion: '2.0.1',
      ),
    ];

    _devicesController.add(mockDevices);
    debugPrint('🔵 Found ${mockDevices.length} devices');
  }

  /// Stop scanning
  Future<void> stopScan() async {
    debugPrint('🔵 Stopped Bluetooth scan');
  }

  /// Connect to a device
  Future<bool> connect(DeviceModel device) async {
    debugPrint('🔵 Connecting to ${device.name}...');
    
    // Simulate connection delay
    await Future.delayed(const Duration(seconds: 2));
    
    _isConnected = true;
    _connectedDevice = device.copyWith(isConnected: true);
    _connectionStateController.add(true);
    
    // Start battery monitoring simulation
    _startBatteryMonitoring();
    
    debugPrint('🔵 Connected to ${device.name}');
    return true;
  }

  /// Disconnect from current device
  Future<void> disconnect() async {
    debugPrint('🔵 Disconnecting...');
    
    _isConnected = false;
    _connectedDevice = null;
    _connectionStateController.add(false);
    
    debugPrint('🔵 Disconnected');
  }

  /// Send SOS trigger to band
  Future<bool> triggerSosBuzzer() async {
    if (!_isConnected) return false;
    debugPrint('🚨 SOS buzzer triggered on band!');
    // In real implementation, this would send a BLE characteristic write
    return true;
  }

  /// Simulate battery level updates
  void _startBatteryMonitoring() {
    Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!_isConnected) {
        timer.cancel();
        return;
      }
      // Simulate battery drain
      final currentBattery = _connectedDevice?.batteryLevel ?? 85;
      _batteryController.add(currentBattery);
    });
  }

  /// Dispose resources
  void dispose() {
    _connectionStateController.close();
    _devicesController.close();
    _batteryController.close();
  }
}
