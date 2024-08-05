
class UserModel {
  final String id;
  final String fistname;
  final String lastname;
  final String email;
  final String username;
  final String password;
  final String phonenumber;
  final String roles;

  const UserModel({
    required this.id,
    required this.fistname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.password,
    required this.phonenumber,
    required this.roles,
  });

  toJson(){
    return {
      'id': id,
      'fistname': fistname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'password': password,
      'phonenumber': phonenumber,
      'roles': roles,
    };
  }

}