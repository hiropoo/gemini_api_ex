import 'package:gemini_api_ex/chat_card.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_list.g.dart';


@riverpod
class ChatList extends _$ChatList {
  @override
  Future<List<ChatCard>> build() async{
    
    return [
      const ChatCard(
        text: "こんにちは",
        isUser: true,
      ),
      const ChatCard(
        text: "こんにちは、私はGeminiです",
        isUser: false,
      ),
    ];
  }

  /// chatListに新しいメッセージを追加するメソッド
  void addNewChat(ChatCard chatCard) {
    state = AsyncValue.data([...state.value!, chatCard]);
  }  
  
}