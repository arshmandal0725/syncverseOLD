class UserData {
  final String id;
  final String name;
  final int phone;
  final String email;
  final String location;
  final String place;
  final String photo;
  final List calllist;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.place,
    required this.photo,
    required this.calllist
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['_id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        location: json['location'],
        place: json['place'],
        photo: json['photo'],
    calllist: json['calllist']);
  }
}
