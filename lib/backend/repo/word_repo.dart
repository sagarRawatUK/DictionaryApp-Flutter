import 'package:dictionaryapp/backend/service/dio_service.dart';
import 'package:dictionaryapp/models/word_response.dart';

class WordRepo {
  Future<List<WordCode>> getWords(String query) async {
    try {
      final response = await DioService().getRequest(
          "https://api.dictionaryapi.dev/api/v2/entries/en_US/$query");

      if (response.statusCode == 200) {
        print(response.statusMessage);
        // final result = response.data.map((wordcode) => wordcode.toList());
        List<WordCode> result =
            List<WordCode>.from(response.data.map((i) => WordCode.fromJson(i)));
        return result;
      } else
        return [];
    } on Exception catch (e) {
      throw e;
    }
  }
}
