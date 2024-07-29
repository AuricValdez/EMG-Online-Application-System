class User {
  final String username;
  final String password;
  final String firstName;
  final String lastName;

  User(this.username, this.password, this.firstName, this.lastName);
}

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() => _instance;

  UserManager._internal();

  final Map<String, User> _users = {};

  bool registerUser(String username, String password, String firstName, String lastName) {
    if (_users.containsKey(username)) {
      return false; // Username already exists
    }
    _users[username] = User(username, password, firstName, lastName);
    return true;
  }

  User? loginUser(String username, String password) {
    final user = _users[username];
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }
}
