import 'package:tdd_clean_app/features/number_trivia/data/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws CacheException if no cached data is present.
  Future<NumberTriviaModel>? getLastNumberTrivia();

  Future<void>? cacheNumberTrivia(NumberTriviaModel traviaToCache);
}
