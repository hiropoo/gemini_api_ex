import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_api_ex/chat_card.dart';
import 'package:gemini_api_ex/chat_generation_judge.dart';
import 'package:gemini_api_ex/chat_list.dart';
import 'package:gemini_api_ex/gemini.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _controller = TextEditingController();
    final chatList = ref.watch(chatListProvider); // チャットリスト
    final isGenerating = ref.watch(chatGenerationJudgeProvider);  // チャット生成中かどうか

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
          body: Container(
            margin: const EdgeInsets.fromLTRB(3, 0, 3, 30),
            child: Column(
              children: [
            
                // チャットの表示
                chatList.when(
                  error: (_,__) => const Text('エラーが発生しました'), 
                  loading: () => const CircularProgressIndicator(),
                  data: (chatList) => Expanded(
                    child: ListView.builder(
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        return chatList[index];
                      },
                    ),
                  ) 
                ),
              
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
            
                            // 送信ボタンが押された時の処理
                            onPressed: () async {
                              // チャット生成中フラグを立てる
                              ref.read(chatGenerationJudgeProvider.notifier).changeFlag(true); 
            
                              yourText = _controller.text;
                              if(yourText!.isEmpty) {
                                // チャット生成中フラグを下げる
                                ref.read(chatGenerationJudgeProvider.notifier).changeFlag(false);
                                return; 
                              }
            
                              ref.read(chatListProvider.notifier).addNewChat(
                                ChatCard(
                                  text: yourText!,
                                  isUser: true,
                                ),
                              );
            
                              _controller.clear();
                              
                              geminiText = await Gemini.getText(yourText!);
                              // チャット生成中フラグを下げる
                              ref.read(chatGenerationJudgeProvider.notifier).changeFlag(false);
            
                              ref.read(chatListProvider.notifier).addNewChat(
                                    ChatCard(
                                      text: geminiText!,
                                      isUser: false,
                                    ),
                                  );
            
                              debugPrint("あなた: $yourText");
                              debugPrint("Gemini: $geminiText");
                            },
                            icon: isGenerating ?  const CupertinoActivityIndicator(): const Icon(Icons.send),
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
               
              ],
            ),
          )),
    );
  }
}
