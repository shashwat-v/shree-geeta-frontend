class Message {
  final String id;
  final String sender;
  final String text;
  final DateTime timestamp;
  final bool isStreaming;

  Message({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.isStreaming = false,
  });

  Message copyWith({
    String? id,
    String? sender,
    String? text,
    DateTime? timestamp,
    bool? isStreaming,
  }) {
    return Message(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      isStreaming: isStreaming ?? this.isStreaming,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
      'isStreaming': isStreaming,
    };
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      sender: json['sender'] as String,
      text: json['text'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isStreaming: json['isStreaming'] as bool? ?? false,
    );
  }
}
