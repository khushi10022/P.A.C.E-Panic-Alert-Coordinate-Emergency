/// SheShield – Emergency Contact Model
class ContactModel {
  final String id;
  final String name;
  final String phone;
  final String? photoUrl;
  final String relationship;
  final bool isPrimary;
  final DateTime createdAt;

  const ContactModel({
    required this.id,
    required this.name,
    required this.phone,
    this.photoUrl,
    required this.relationship,
    this.isPrimary = false,
    required this.createdAt,
  });

  ContactModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? photoUrl,
    String? relationship,
    bool? isPrimary,
    DateTime? createdAt,
  }) {
    return ContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      relationship: relationship ?? this.relationship,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl,
      'relationship': relationship,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      photoUrl: map['photoUrl'],
      relationship: map['relationship'] ?? 'Other',
      isPrimary: map['isPrimary'] ?? false,
      createdAt: DateTime.parse(
          map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  /// Mock contacts for development
  static List<ContactModel> mockContacts() {
    return [
      ContactModel(
        id: 'contact_001',
        name: 'Mom',
        phone: '+91 98765 11111',
        relationship: 'Mother',
        isPrimary: true,
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
      ),
      ContactModel(
        id: 'contact_002',
        name: 'Rahul Sharma',
        phone: '+91 98765 22222',
        relationship: 'Brother',
        isPrimary: false,
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
      ContactModel(
        id: 'contact_003',
        name: 'Anita Patel',
        phone: '+91 98765 33333',
        relationship: 'Best Friend',
        isPrimary: false,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }
}

/// Available relationship types
class Relationships {
  static const List<String> types = [
    'Mother',
    'Father',
    'Brother',
    'Sister',
    'Husband',
    'Partner',
    'Best Friend',
    'Friend',
    'Colleague',
    'Neighbor',
    'Other',
  ];
}
