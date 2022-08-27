class User {
  final String email, firstName, lastName;

  User({required this.email, required this.firstName, required this.lastName});

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json['email'],
    firstName: json['first name'],
    lastName: json['last name'],
  );
}