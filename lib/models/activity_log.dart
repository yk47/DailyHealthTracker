class ActivityLog {
  final int id;
  final String title;
  final String body;
  final int userId;

  ActivityLog({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) {
    return ActivityLog(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body, 'userId': userId};
  }
}
