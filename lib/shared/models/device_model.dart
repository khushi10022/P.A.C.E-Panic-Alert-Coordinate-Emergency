/// SheShield – BLE Device Model
class DeviceModel {
  final String id;
  final String name;
  final int rssi;
  final bool isConnected;
  final int batteryLevel;
  final String firmwareVersion;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.rssi,
    this.isConnected = false,
    this.batteryLevel = 0,
    this.firmwareVersion = '1.0.0',
  });

  DeviceModel copyWith({
    String? id,
    String? name,
    int? rssi,
    bool? isConnected,
    int? batteryLevel,
    String? firmwareVersion,
  }) {
    return DeviceModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rssi: rssi ?? this.rssi,
      isConnected: isConnected ?? this.isConnected,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      firmwareVersion: firmwareVersion ?? this.firmwareVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rssi': rssi,
      'isConnected': isConnected,
      'batteryLevel': batteryLevel,
      'firmwareVersion': firmwareVersion,
    };
  }

  factory DeviceModel.fromMap(Map<String, dynamic> map) {
    return DeviceModel(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Unknown Device',
      rssi: map['rssi'] ?? -100,
      isConnected: map['isConnected'] ?? false,
      batteryLevel: map['batteryLevel'] ?? 0,
      firmwareVersion: map['firmwareVersion'] ?? '1.0.0',
    );
  }
}
