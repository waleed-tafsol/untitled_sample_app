class UserModel {
  final String phoneNumber;
  final String? otp;
  final bool isVerified;

  UserModel({
    required this.phoneNumber,
    this.otp,
    this.isVerified = false,
  });

  UserModel copyWith({
    String? phoneNumber,
    String? otp,
    bool? isVerified,
  }) {
    return UserModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otp: otp ?? this.otp,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  String toString() {
    return 'UserModel(phoneNumber: $phoneNumber, otp: $otp, isVerified: $isVerified)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.phoneNumber == phoneNumber &&
        other.otp == otp &&
        other.isVerified == isVerified;
  }

  @override
  int get hashCode {
    return phoneNumber.hashCode ^ otp.hashCode ^ isVerified.hashCode;
  }
}

