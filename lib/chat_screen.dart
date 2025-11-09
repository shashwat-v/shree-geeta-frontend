import 'package:flutter/material.dart';
import 'package:shree_geeta/components/message_bubble.dart';
import 'package:shree_geeta/test.dart';

class ChatScreen
    extends
        StatefulWidget {
  const ChatScreen({
    super.key,
  });

  @override
  State<
    ChatScreen
  >
  createState() => _ChatScreenState();
}

void
handleSend() {
  print(
    "Send button pressed",
  );
}

class _ChatScreenState
    extends
        State<
          ChatScreen
        > {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Gita GPT",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      itemCount: dummyMessages.length,
                      itemBuilder:
                          (
                            context,
                            index,
                          ) {
                            final msg = dummyMessages[index];
                            return MessageBubble(
                              isUser:
                                  msg["sender"] ==
                                  "user",
                              text: msg["text"],
                            );
                          },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Ask a question...",
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            36,
                          ),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: handleSend,
                    child: Container(
                      height: 46,
                      width: 46,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          254,
                          153,
                          51,
                          1,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// ShreeGeeta header ["three lines", "title", "three dots"]
// dynamic chat screeen showing requests and replies
// footer floating, ["Ask a question...", "send button logo"]

