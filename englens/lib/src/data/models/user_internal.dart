class UserInternal {
  int? id;
  int? userId;
  String? email;

  static UserInternal? _singleton;

  factory UserInternal() {
    if (_singleton != null) {
      return _singleton!;
    } else {
      return _singleton = new UserInternal._internal();
    }
  }

  UserInternal._internal();

  UserInternal.newInstance({this.id, this.email, this.userId}) {
    id = id;
    userId = userId;
    email = email;
  }
}
