
class LoginModel {
  final String username;
  final String password;

  const LoginModel({
    required this.username,
    required this.password,
  });

  toJson(){
    return {
      'username': username,
      'password': password,
    };
  }
}