import 'package:dartz/dartz.dart';
import 'package:tdd_clean_app/core/error/failures.dart';
import 'package:tdd_clean_app/core/usecases/usecase.dart';
import 'package:tdd_clean_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);
  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) {
    return repository.getRandomNumberTrivia();
  }
}
