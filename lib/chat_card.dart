import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.text, required this.isUser});
  final String text;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
            child: ClipOval(
              child: isUser
                  ? Container(
                      width: 20,
                      height: 20,
                      color: Colors.grey,
                      child: const Icon(Icons.person))
                  : Image.network(
                      "https://play-lh.googleusercontent.com/HA-Q2VP4OYX-GaSTrhrjzlVe8jpR0l_yBFvrCxiAuAVOlDcZxZzYHNTVU1zQBpiSqg=w480-h960",
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(isUser ? "You" : "Gemini",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  text,
                  softWrap: true,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
