
enum Role{
  admin, user
}

class UserModel{
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final Role role;
  final String password;

  UserModel(
      this.firstName, this.lastName, this.email, this.role, this.password, this.id);


}