class Message {
  final bool isSender;
  final String prompt;
  Message({
    required this.isSender,
    required this.prompt,
  });

  Message copyWith({
    bool? isSender,
    String? prompt,
  }) {
    return Message(
      isSender: isSender ?? this.isSender,
      prompt: prompt ?? this.prompt,
    );
  }
}
