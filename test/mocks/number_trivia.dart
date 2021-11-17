import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:tdd_clean_app/core/network/network_info.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_local_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

@GenerateMocks([
  NumberTriviaRepository,
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
  DataConnectionChecker,
])
void main() {}
