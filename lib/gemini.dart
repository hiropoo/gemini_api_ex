import 'dart:typed_data';

import 'package:gemini_api_ex/env.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

// Gemini を呼び出すクラス
class Gemini {

  /// geminiにpromptを送信して、生成されたテキストを返すメソッド
  static Future<String?> getText(String prompt) async {
    final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: Env.apiKey,
    );

    final content = [
      Content.text(prompt),
    ];

    final response = await model.generateContent(content);
    return response.text;
  }

  /// geminiにpromptと画像を送信して、生成されたテキストを返すメソッド
  static Future<String?> getTextWithImage(String prompt, Uint8List image) async {
    final model = GenerativeModel(
      model: 'gemini-pro-vision',
      apiKey: Env.apiKey,
    );

    final textPart = TextPart(prompt);
    final dataPart = DataPart('image/png', image);
    final content = [
      Content.multi([textPart, dataPart])
    ];

    final response = await model.generateContent(content);
    return response.text;
  }
}
