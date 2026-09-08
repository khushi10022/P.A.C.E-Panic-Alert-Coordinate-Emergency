/// SheShield – Emergency Event Model
class EmergencyModel {
  final String id;
  final String userId;
  final DateTime timestamp;
  final double latitude;
  final double longitude;
  final String address;
  final EmergencyType type;
  final EmergencyStatus status;
  final Duration? duration;
  final String? notes;

  const EmergencyModel({
    required this.id,
    required this.userId,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.type,
    required this.status,
    this.duration,
    this.notes,
  });

  EmergencyModel copyWith({
    String? id,
    String? userId,
    DateTime? timestamp,
    double? latitude,
    double? longitude,
    String? address,
    EmergencyType? type,
    EmergencyStatus? status,
    Duration? duration,
    String? notes,
  }) {
    return EmergencyModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      type: type ?? this.type,
      status: status ?? this.status,
      duration: duration ?? this.duration,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'timestamp': timestamp.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'type': type.name,
      'status': status.name,
      'durationMs': duration?.inMilliseconds,
      'notes': notes,
    };
  }

  factory EmergencyModel.fromMap(Map<String, dynamic> map) {
    return EmergencyModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      timestamp: DateTime.parse(
          map['timestamp'] ?? DateTime.now().toIso8601String()),
      latitude: (map['latitude'] ?? 0.0).toDouble(),
      longitude: (map['longitude'] ?? 0.0).toDouble(),
      address: map['address'] ?? 'Unknown',
      type: EmergencyType.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => EmergencyType.manual,
      ),
      status: EmergencyStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => EmergencyStatus.resolved,
      ),
      duration: map['durationMs'] != null
          ? Duration(milliseconds: map['durationMs'])
          : null,
      notes: map['notes'],
    );
  }

  /// Mock emergency history for development
  static List<EmergencyModel> mockHistory() {
    return [
      EmergencyModel(
        id: 'emg_001',
        userId: 'user_001',
        timestamp: DateTime.now().subtract(const Duration(days: 2)),
        latitude: 28.6139,
        longitude: 77.2090,
        address: 'Connaught Place, New Delhi',
        type: EmergencyType.manual,
        status: EmergencyStatus.resolved,
        duration: const Duration(minutes: 12),
        notes: 'Test alert — cancelled after guardian confirmation',
      ),
      EmergencyModel(
        id: 'emg_002',
        userId: 'user_001',
        timestamp: DateTime.now().subtract(const Duration(days: 7)),
        latitude: 28.5355,
        longitude: 77.3910,
        address: 'Sector 18, Noida',
        type: EmergencyType.wearable,
        status: EmergencyStatus.resolved,
        duration: const Duration(minutes: 8),
        notes: 'Band triggered — false alarm',
      ),
      EmergencyModel(
        id: 'emg_003',
        userId: 'user_001',
        timestamp: DateTime.now().subtract(const Duration(days: 15)),
        latitude: 28.4595,
        longitude: 77.0266,
        address: 'DLF Cyber City, Gurugram',
        type: EmergencyType.manual,
        status: EmergencyStatus.resolved,
        duration: const Duration(minutes: 5),
      ),
    ];
  }
}

enum EmergencyType {
  manual,
  wearable,
  automatic,
}

enum EmergencyStatus {
  active,
  pending,
  resolved,
  cancelled,
}

extension EmergencyTypeExtension on EmergencyType {
  String get label {
    switch (this) {
      case EmergencyType.manual:
        return 'Manual SOS';
      case EmergencyType.wearable:
        return 'Band Triggered';
      case EmergencyType.automatic:
        return 'Auto-Detected';
    }
  }
}

extension EmergencyStatusExtension on EmergencyStatus {
  String get label {
    switch (this) {
      case EmergencyStatus.active:
        return 'Active';
      case EmergencyStatus.pending:
        return 'Pending';
      case EmergencyStatus.resolved:
        return 'Resolved';
      case EmergencyStatus.cancelled:
        return 'Cancelled';
    }
  }
}
