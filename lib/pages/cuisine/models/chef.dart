class Chef {
  final String id;
  final String bio;
  final String username;
  final int experience;
  final List<String> specialties;
  final double rating;
  final String availabilityStatus;
  final double pricingPerHour;
  final String profileVerificationStatus;
  final bool verifiedBadge;
  final String profileImage;
  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final bool isVerified;
  final String backgroundImage;
  final String gigImage;

  Chef({
    required this.id,
    required this.bio,
    required this.experience,
    required this.specialties,
    required this.rating,
    required this.availabilityStatus,
    required this.pricingPerHour,
    required this.profileVerificationStatus,
    required this.verifiedBadge,
    required this.profileImage,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.isVerified,
    this.backgroundImage = "",
    this.gigImage = "",
    this.username = "",
  });

  factory Chef.fromJson(Map<String, dynamic> json) {
    return Chef(
      id: json['_id'],
      bio: json['Bio'],
      experience: json['Experience'],
      specialties: List<String>.from(json['Specialties']),
      rating: json['Rating'].toDouble(),
      availabilityStatus: json['AvailabilityStatus'],
      pricingPerHour: json['PricingPerHour'].toDouble(),
      profileVerificationStatus: json['ProfileVerificationStatus'],
      verifiedBadge: json['VerifiedBadge'],
      profileImage: json['profileImage'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      address: json['address'],
      type: json['type'],
      isVerified: json['isVerified'],
      backgroundImage: json['backgroundImage'] ?? "",
      gigImage: json['gigImage'] ?? "",
      username: json['username'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'Bio': bio,
      'Experience': experience,
      'Specialties': specialties,
      'Rating': rating,
      'AvailabilityStatus': availabilityStatus,
      'PricingPerHour': pricingPerHour,
      'ProfileVerificationStatus': profileVerificationStatus,
      'VerifiedBadge': verifiedBadge,
      'profileImage': profileImage,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'type': type,
      'isVerified': isVerified,
      'gigImage': gigImage,
      'backgroundImage': backgroundImage,
      'username': username,
    };
  }
}
