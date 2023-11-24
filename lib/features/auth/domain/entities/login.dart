class UserLoginInfo {
  final String? token;
  final String? name;
  final String email;
  const UserLoginInfo({
    this.token,
    this.name,
    required this.email,
  });

  @override
  String toString() {
    return 'UserLoginInfo(token: $token, name: $name, email: $email)';
  }
}
