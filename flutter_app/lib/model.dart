class Menu {
  final String menuName;
  final String menuIcon;
  final bool isActive;

  Menu(this.menuName, this.menuIcon, this.isActive);
}

class User {
  int id;
  final String name;
  final String email;

  User({this.id, this.name, this.email});

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        id: parsedJson["id"],
        name: parsedJson["name"] as String,
        email: parsedJson["email"] as String);
  }
}
