import 'package:flutter/material.dart';

class MessageBubble
    extends
        StatelessWidget {
  final bool isUser;
  final String text;

  const MessageBubble({
    super.key,
    required this.isUser,
    required this.text,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 12,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: isUser
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                _buildAvatar(
                  false,
                ),
                const SizedBox(
                  width: 4,
                ),
              ],

              Column(
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 3,
                    ),
                    child: Text(
                      isUser
                          ? "You"
                          : "Gita GPT",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth:
                          MediaQuery.of(
                            context,
                          ).size.width *
                          0.70,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(
                              0xFFFF9500,
                            )
                          : const Color(
                              0xFFF1F1F1,
                            ),
                      borderRadius: BorderRadius.circular(
                        18,
                      ),
                      boxShadow: isUser
                          ? [
                              BoxShadow(
                                color: Colors.orange.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 6,
                                offset: const Offset(
                                  0,
                                  2,
                                ),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.30,
                        letterSpacing: 0.1,
                        color: isUser
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),

              if (isUser) ...[
                const SizedBox(
                  width: 4,
                ),
                _buildAvatar(
                  true,
                ),
              ],
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(
    bool user,
  ) {
    return CircleAvatar(
      radius: 14,
      backgroundColor: user
          ? Colors.orange.shade100
          : Colors.grey.shade200,
      child: Icon(
        user
            ? Icons.person
            : Icons.spa_rounded,
        size: 16,
        color: Colors.black87,
      ),
    );
  }
}
