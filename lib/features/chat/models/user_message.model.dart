// ignore_for_file: public_member_api_docs, sort_constructors_first
class Message {
  final bool isSender;
  final String prompt;
  final bool shouldAnimate;
  Message({
    required this.isSender,
    required this.prompt,
    required this.shouldAnimate,
  });

  Message copyWith({
    bool? isSender,
    String? prompt,
    bool? shouldAnimate,
  }) {
    return Message(
      isSender: isSender ?? this.isSender,
      prompt: prompt ?? this.prompt,
      shouldAnimate: shouldAnimate ?? this.shouldAnimate,
    );
  }
}
