class TodoList {
  int? id;
  String? title, desc, createdAt, UpdatedAt;

  TodoList({this.id, this.desc, this.createdAt, this.title, this.UpdatedAt});

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
        id: json['id'],
        desc: json['desc'],
        title: json['title'],
        createdAt: json['created_at'],
        UpdatedAt: json['updated_at']);
  }
}
