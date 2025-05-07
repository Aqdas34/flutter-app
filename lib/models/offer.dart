class Offer {
  final String id;
  final String chefId;
  final String userId;
  final DateTime date;
  final String time;
  final List<String> selectedCuisines;
  final int numberOfPersons;
  final String comments;
  final String status; // pending, accepted, rejected

  Offer({
    required this.id,
    required this.chefId,
    required this.userId,
    required this.date,
    required this.time,
    required this.selectedCuisines,
    required this.numberOfPersons,
    required this.comments,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chefId': chefId,
      'userId': userId,
      'date': date.toIso8601String(),
      'time': time,
      'selectedCuisines': selectedCuisines,
      'numberOfPersons': numberOfPersons,
      'comments': comments,
      'status': status,
    };
  }

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      chefId: json['chefId'],
      userId: json['userId'],
      date: DateTime.parse(json['date']),
      time: json['time'],
      selectedCuisines: List<String>.from(json['selectedCuisines']),
      numberOfPersons: json['numberOfPersons'],
      comments: json['comments'],
      status: json['status'],
    );
  }
}
