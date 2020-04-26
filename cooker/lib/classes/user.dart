class User {
  String id;
  String password;
  String firstname;
  String lastname;
  String username;
  String address;
  String phone;
  int balance;
  String email;

  User(
      {this.id,
      this.firstname,
      this.lastname,
      this.username,
      this.address,
      this.phone,
      this.email,
      this.balance});
  User.register(
      {this.firstname,
      this.lastname,
      this.username,
      this.password,
      this.address,
      this.phone,
      this.email,
      this.balance});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        username: json['username'],
        address: json['address'],
        phone: json['phone'],
        email: json['email'],
        balance: json['balance']);
  }
}
