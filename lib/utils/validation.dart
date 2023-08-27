bool isValidEmail(String email) {
  final RegExp regex =
      RegExp(r"^[a-zA-Z0-9\.a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
  return regex.hasMatch(email);
}

bool isValidNickName(String nickname) {
  return nickname.length >= 6;
}

bool isValidName(String name) {
  final regex = RegExp(r'^[a-zA-Z]+$');

  return regex.hasMatch(name);
}

bool isValidPassword(String password) {
  final RegExp regex =
      RegExp(r'^[a-zA-Z0-9!@#\$%^&*\(\)_\+\-\[\]{};:"\\|,.<>\/?~]{8,}$');

  return regex.hasMatch(password);
}

bool isCheckValidPassword(String password, String checkPassword) {
  return password == checkPassword;
}
