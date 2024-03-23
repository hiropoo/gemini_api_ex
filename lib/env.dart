import 'package:envied/envied.dart';
part 'env.g.dart';


@Envied(path: 'scripts/env/.env')
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static final String apiKey = _Env.apiKey;
}


