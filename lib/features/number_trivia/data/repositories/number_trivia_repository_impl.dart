import 'package:tdd_clean_app/core/error/exceptions.dart';
import 'package:tdd_clean_app/core/network/network_info.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_local_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:tdd_clean_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:tdd_clean_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:tdd_clean_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

typedef _ConcreteOrRandomChooser = Future<NumberTriviaModel> Function();

class NumberTriviaRepositoryImpl implements NumberTriviaRepository {
  final NumberTriviaRemoteDataSource remoteDataSource;
  final NumberTriviaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  NumberTriviaRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(
      int number) async {
    return _getTrivia(() {
      return remoteDataSource.getConcreteNumberTrivia(number);
    });
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return _getTrivia(remoteDataSource.getRandomNumberTrivia);
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
      _ConcreteOrRandomChooser getConreteOrRandom) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteTrivia = await getConreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTrivia = await localDataSource.getLastNumberTrivia();
        return Right(localTrivia);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
