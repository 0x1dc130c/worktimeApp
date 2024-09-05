
class UserModel {
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String password;
  final String phonenumber;
  final String position;
  final String roles;

  const UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.phonenumber,
    required this.position,
    required this.roles,
  });

  Map<String, dynamic> toJson() {
    return {
      'Firstname': firstname,
      'Lastname': lastname,
      'Email': email,
      'Username': username,
      'Password': password,
      'Position': position,
      'Phonenumber': phonenumber,
      'Roles': 'User',
    };
  }
}