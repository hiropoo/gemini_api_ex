import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_generation_judge.g.dart';


// flutter pub run build_runner build --delete-conflicting-outputs
@riverpod
class ChatGenerationJudge extends _$ChatGenerationJudge {
  @override
  bool build() {
    
    return false;
  }

  /// フラグを変更するメソッド
  void changeFlag(bool flag) {
    state = flag;
  }
  
}