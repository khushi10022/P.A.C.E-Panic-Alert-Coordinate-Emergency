import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/di/injection.dart';
import '../../services/bluetooth_service.dart';
import '../models/device_model.dart';

/// SheShield – Bluetooth Provider
///
/// Manages BLE device state, scanning, and connection.
final bluetoothProvider =
    StateNotifierProvider<BluetoothNotifier, BluetoothState>((ref) {
  return BluetoothNotifier();
});

class BluetoothNotifier extends StateNotifier<BluetoothState> {
  final BluetoothService _bluetoothService = getIt<BluetoothService>();
  StreamSubscription? _connectionSub;
  StreamSubscription? _devicesSub;

  BluetoothNotifier() : super(const BluetoothState()) {
    _listenToConnection();
  }

  void _listenToConnection() {
    _connectionSub = _bluetoothService.connectionState.listen((connected) {
      state = state.copyWith(
        isConnected: connected,
        connectedDevice: _bluetoothService.connectedDevice,
      );
    });
  }

  /// Start scanning for devices
  Future<void> startScan() async {
    state = state.copyWith(isScanning: true, devices: []);

    _devicesSub = _bluetoothService.discoveredDevices.listen((devices) {
      state = state.copyWith(devices: devices, isScanning: false);
    });

    await _bluetoothService.startScan();
  }

  /// Connect to a device
  Future<void> connect(DeviceModel device) async {
    state = state.copyWith(isConnecting: true);
    final success = await _bluetoothService.connect(device);
    state = state.copyWith(
      isConnecting: false,
      isConnected: success,
      connectedDevice: success ? device.copyWith(isConnected: true) : null,
    );
  }

  /// Disconnect
  Future<void> disconnect() async {
    await _bluetoothService.disconnect();
    state = state.copyWith(
      isConnected: false,
      connectedDevice: null,
    );
  }

  @override
  void dispose() {
    _connectionSub?.cancel();
    _devicesSub?.cancel();
    super.dispose();
  }
}

class BluetoothState {
  final bool isScanning;
  final bool isConnecting;
  final bool isConnected;
  final List<DeviceModel> devices;
  final DeviceModel? connectedDevice;

  const BluetoothState({
    this.isScanning = false,
    this.isConnecting = false,
    this.isConnected = false,
    this.devices = const [],
    this.connectedDevice,
  });

  BluetoothState copyWith({
    bool? isScanning,
    bool? isConnecting,
    bool? isConnected,
    List<DeviceModel>? devices,
    DeviceModel? connectedDevice,
  }) {
    return BluetoothState(
      isScanning: isScanning ?? this.isScanning,
      isConnecting: isConnecting ?? this.isConnecting,
      isConnected: isConnected ?? this.isConnected,
      devices: devices ?? this.devices,
      connectedDevice: connectedDevice ?? this.connectedDevice,
    );
  }
}
