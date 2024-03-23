import 'package:flutter/material.dart';
import 'package:gemini_api_ex/chat_card.dart';
import 'package:gemini_api_ex/gemini.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    String? yourText;
    String? geminiText;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Gemini API Ex'),
          ),
          body: Column(
            children: [
              const Icon(Icons.lightbulb),
              const ChatCard(text: "こんにちは",isUser: true,),
              const ChatCard(text: "こんにちは、私はGeminiです",isUser: false,),
              const Spacer(),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      maxLines: 10,
                      minLines: 1,
                      controller: _controller,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        labelText: 'Message',
                        hintText: "Message",
                        suffixIcon: IconButton(
                          onPressed: () async {
                            yourText = _controller.text;
                            _controller.clear();
                            geminiText = await Gemini.getText(yourText!);


                            debugPrint("あなた: $yourText");
                            debugPrint("Gemini: $geminiText");
                          },
                          icon: const Icon(Icons.send),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              )
            ],
          )),
    );
  }
}
