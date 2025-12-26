import 'package:flutter/material.dart';
import 'package:shree_geeta/core/errors/api_exception.dart';
import 'package:shree_geeta/features/chat/data/chat_repository.dart';
import 'package:shree_geeta/features/chat/models/message.dart';
import 'dart:developer' as developer;

enum ChatState { idle, streaming, error }

class ChatProvider extends ChangeNotifier {
  final ChatRepository _repo = ChatRepository();

  final List<Message> _messages = [];
  ChatState _state = ChatState.idle;
  String? _error;

  List<Message> get messages => List.unmodifiable(_messages);
  ChatState get state => _state;
  String? get error => _error;
  bool get isStreaming => _state == ChatState.streaming;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: 'user',
      text: text.trim(),
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    _state = ChatState.streaming;
    _error = null;
    notifyListeners();

    final botMessageId =
        '${DateTime.now().millisecondsSinceEpoch + 1}';
    String accumulatedText = '';

    try {
      final stream = _repo.askStream(text.trim());

      await for (final chunk in stream) {
        accumulatedText += chunk;

        final existingIndex = _messages.indexWhere(
          (msg) => msg.id == botMessageId,
        );

        if (existingIndex != -1) {
          _messages[existingIndex] = _messages[existingIndex].copyWith(
            text: accumulatedText,
          );
        } else {
          _messages.add(
            Message(
              id: botMessageId,
              sender: 'assistant',
              text: accumulatedText,
              timestamp: DateTime.now(),
              isStreaming: true,
            ),
          );
        }

        notifyListeners();
      }

      final finalIndex = _messages.indexWhere(
        (msg) => msg.id == botMessageId,
      );
      if (finalIndex != -1) {
        _messages[finalIndex] = _messages[finalIndex].copyWith(
          isStreaming: false,
        );
      }

      _state = ChatState.idle;
      notifyListeners();
    } on ApiException catch (e) {
      _error = e.message;
      _state = ChatState.error;
      developer.log('Chat error: ${e.message}', name: 'ChatProvider');
      notifyListeners();
    } catch (e) {
      _error = 'Failed to get response. Please try again.';
      _state = ChatState.error;
      developer.log('Unexpected chat error: $e', name: 'ChatProvider');
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    _state = ChatState.idle;
    _error = null;
    notifyListeners();
  }
}
