class Repository {
  List<String> users;

  Future<void> getUsers() async {
    return Future.delayed(Duration(seconds: 5), () {
      return users = ['User 1', 'User 2', 'User 3', 'User 4'];
    });
  }

  void addUser(String user) => users.add(user);

  void delUser() {
    if (users.isNotEmpty) {
      users.removeLast();
    }
  }
}
