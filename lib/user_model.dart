class User {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  User({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': int userId,
        'id': int id,
        'title': String title,
        'completed': bool completed,
      } =>
        User(
          userId: userId,
          id: id,
          title: title,
          completed: completed,
        ),
      _ => throw const FormatException('Failed to load User'),
    };
  }
}
