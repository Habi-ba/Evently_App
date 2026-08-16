class MyUser {
  //collection name
  static const String collectionName = 'Users';

  //attributes
  String id;
  String email;
  String name;

  //constructor
  MyUser({required this.id, required this.name, required this.email});

  //json=> object
  MyUser.fromJson(Map<String, dynamic> json)
    : this(id: json['id'], email: json['email'], name: json['name']);

  //object=> json
  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'name': name};
  }
}
