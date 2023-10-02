import 'dart:convert';

class MessageModel {
  final String role;
  final String content;
  MessageModel({
    required this.role,
    required this.content,
  });

  MessageModel copyWith({
    String? role,
    String? content,
  }) {
    return MessageModel(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'role': role,
      'content': content,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      role: map['role'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
