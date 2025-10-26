class UserEntity {
  final String id;
  final String? fullName;
  final String email;
  final String? phoneNumber;
  final String role;
  final String? profileImage;
  final String? bio;
  final List<String>? skills;
  final double? hourlyRate;
  final double? rating;
  final String? clientStatus;
  final String? freelancerStatus;
  final DateTime? lastSeen;
  final bool? isOnline;
  final int? jobsCount;
  final int? reviewsCount;
  final double? freelancerBalance;
  final DateTime? createdAt;
  final BillingInfo? billingInfo;
  final double? balance;
  final DateTime? updatedAt;
  final bool? isVerified;
  final double? totalOrders;
  final double? totalEarnings;
  final double? completedOrders;
  final String? lastMessage;
  final DateTime? lastMessageTime;

  UserEntity({
    required this.id,
    this.fullName,
    required this.email,
    this.phoneNumber,
    required this.role,
    this.profileImage,
    this.bio,
    this.skills,
    this.rating,
    this.billingInfo,
    this.balance,
    this.hourlyRate,
    this.createdAt,
    this.updatedAt,
    this.clientStatus,
    this.freelancerStatus,
    this.lastSeen,
    this.isOnline,
    this.jobsCount,
    this.reviewsCount,
    this.freelancerBalance,
    this.isVerified,
    required this.totalOrders,
    required this.totalEarnings,
    required this.completedOrders,
    this.lastMessage,
    this.lastMessageTime,
  });
  static UserEntity get dummy => UserEntity(
    id: '0',
    fullName: 'Dummy User',
    email: 'dummy@example.com',
    role: 'client',
    profileImage: null,
    bio: 'This is a placeholder user',
    skills: [],
    rating: 0.0,
    billingInfo: null,
    balance: 0.0,
    hourlyRate: 0.0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    clientStatus: 'active',
    freelancerStatus: 'inactive',
    lastSeen: DateTime.now(),
    isOnline: false,
    jobsCount: 0,
    reviewsCount: 0,
    freelancerBalance: 0.0,
    isVerified: false,
    totalOrders: 0,
    totalEarnings: 0.0,
    completedOrders: 0.0,
    lastMessage: '',
    lastMessageTime:   DateTime.now(),
  );
}

class BillingInfo {
  final String name;
  final String address;
  final String paymentMethod;

  BillingInfo({
    required this.name,
    required this.address,
    required this.paymentMethod,
  });

  factory BillingInfo.fromJson(Map<String, dynamic> json) {
    return BillingInfo(
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      paymentMethod: json['paymentMethod'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'address': address, 'paymentMethod': paymentMethod};
  }

}
