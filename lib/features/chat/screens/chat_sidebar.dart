import 'package:flutter/material.dart';

class ChatSidebar
    extends
        StatelessWidget {
  final AnimationController controller;

  const ChatSidebar({
    super.key,
    required this.controller,
  });

  static const Color primaryOrange = Color.fromRGBO(
    254,
    153,
    51,
    1,
  );

  @override
  Widget build(
    BuildContext context,
  ) {
    final width =
        MediaQuery.of(
          context,
        ).size.width *
        0.78;

    return AnimatedBuilder(
      animation: controller,
      builder:
          (
            _,
            __,
          ) {
            return Positioned(
              left:
                  -width +
                  (width *
                      controller.value),
              top: 0,
              bottom: 0,
              child: MediaQuery.removeViewInsets(
                context: context,
                removeBottom: true, // 🔒 prevents keyboard push
                child: Material(
                  elevation: 8,
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(
                      16,
                    ),
                    bottomRight: Radius.circular(
                      16,
                    ),
                  ),
                  child: SizedBox(
                    width: width,
                    child: Stack(
                      children: [
                        /// ================= MAIN CONTENT =================
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 110,
                          ),
                          child: SafeArea(
                            bottom: false,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _searchBar(),
                                const SizedBox(
                                  height: 10,
                                ),
                                _newChatButton(),
                                const SizedBox(
                                  height: 12,
                                ),
                                Expanded(
                                  child: _chatList(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// ================= FIXED BOTTOM =================
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: _bottomSection(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }

  // 🔍 SEARCH BAR
  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search chats",
          prefixIcon: const Icon(
            Icons.search,
          ),
          filled: true,
          fillColor: const Color(
            0xFFF3F3F3,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ➕ NEW CHAT
  Widget _newChatButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Container(
        height: 46,
        decoration: BoxDecoration(
          color: primaryOrange.withValues(
            alpha: 0.12,
          ),
          borderRadius: BorderRadius.circular(
            30,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              size: 18,
              color: primaryOrange,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "New chat",
              style: TextStyle(
                color: primaryOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🗂 CHAT LIST
  Widget _chatList() {
    final chats = [
      "PDF Case Study Summaries",
      "Magnificent 7 Explained",
      "Flutter Login UI Breakdown",
      "AWS ELB Types Explained",
      "Portfolio Analysis Summary",
    ];

    return ListView(
      padding: const EdgeInsets.only(
        top: 4,
      ),
      children: [
        _sectionTitle(
          "Recent",
        ),
        ...chats.map(
          _chatTile,
        ),
      ],
    );
  }

  Widget _sectionTitle(
    String title,
  ) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        10,
        16,
        4,
      ),
      child: Text(
        "Recent",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // 💬 CHAT TILE + BEAUTIFUL DELETE
  Widget _chatTile(
    String title,
  ) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 2,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PopupMenuButton<
              String
            >(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              color: const Color(
                0xFFFFF3E8,
              ),
              icon: const Icon(
                Icons.more_vert,
                size: 18,
              ),
              onSelected:
                  (
                    value,
                  ) {
                    if (value ==
                        'delete') {
                      debugPrint(
                        "Delete chat: $title",
                      );
                    }
                  },
              itemBuilder:
                  (
                    _,
                  ) => [
                    PopupMenuItem(
                      value: 'delete',
                      height: 25,
                      padding: EdgeInsets.zero, // 👈 removes default padding
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.delete_outline,
                              size: 18,
                              color: primaryOrange,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Delete",
                              style: TextStyle(
                                color: primaryOrange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
            ),
          ],
        ),
      ),
    );
  }

  // 👤 FIXED PROFILE + LOGOUT
  Widget _bottomSection() {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black12,
          ),

          const SizedBox(
            height: 12,
          ),

          Row(
            children: const [
              CircleAvatar(
                radius: 18,
                backgroundColor: primaryOrange,
                child: Text(
                  "SV",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                "Shashwat Vishwakarma",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 12,
          ),

          /// FULL-WIDTH DIVIDER
          const Divider(
            height: 1,
            thickness: 1,
            color: Colors.black12,
          ),

          const SizedBox(
            height: 8,
          ),

          /// LOGOUT
          InkWell(
            borderRadius: BorderRadius.circular(
              8,
            ),
            onTap: () {
              debugPrint(
                "Logout tapped",
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    size: 20,
                    color: Colors.redAccent,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
