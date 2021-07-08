import 'package:flutter_playground/core/error/exceptions.dart';
import 'package:flutter_playground/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_playground/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTrivia triviaToCache);
}
