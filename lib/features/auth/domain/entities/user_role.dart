enum UserRole {
  admin,
  user;

  String get firestoreValue => name;

  static UserRole fromFirestore(String? value) {
    return UserRole.values.firstWhere(
      (role) => role.name == value,
      orElse: () => UserRole.user,
    );
  }
}
