/// SheShield – User Data Model
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? photoUrl;
  final String? bloodGroup;
  final String? medicalInfo;
  final String? connectedDeviceId;
  final int emergencyContactsCount;
  final int safetyScore;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.photoUrl,
    this.bloodGroup,
    this.medicalInfo,
    this.connectedDeviceId,
    this.emergencyContactsCount = 0,
    this.safetyScore = 50,
    required this.createdAt,
    required this.updatedAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? photoUrl,
    String? bloodGroup,
    String? medicalInfo,
    String? connectedDeviceId,
    int? emergencyContactsCount,
    int? safetyScore,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      medicalInfo: medicalInfo ?? this.medicalInfo,
      connectedDeviceId: connectedDeviceId ?? this.connectedDeviceId,
      emergencyContactsCount:
          emergencyContactsCount ?? this.emergencyContactsCount,
      safetyScore: safetyScore ?? this.safetyScore,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'bloodGroup': bloodGroup,
      'medicalInfo': medicalInfo,
      'connectedDeviceId': connectedDeviceId,
      'emergencyContactsCount': emergencyContactsCount,
      'safetyScore': safetyScore,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
      photoUrl: map['photoUrl'],
      bloodGroup: map['bloodGroup'],
      medicalInfo: map['medicalInfo'],
      connectedDeviceId: map['connectedDeviceId'],
      emergencyContactsCount: map['emergencyContactsCount'] ?? 0,
      safetyScore: map['safetyScore'] ?? 50,
      createdAt: DateTime.parse(
          map['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(
          map['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// Mock user for development
  factory UserModel.mock() {
    return UserModel(
      id: 'user_001',
      name: 'Priya Sharma',
      email: 'priya@pace.org',
      phone: '+91 98765 43210',
      bloodGroup: 'B+',
      medicalInfo: 'No known allergies',
      emergencyContactsCount: 3,
      safetyScore: 85,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }
}
