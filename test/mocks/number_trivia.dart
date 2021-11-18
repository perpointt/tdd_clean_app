import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_clean_app/core/network/network_info.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_local_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  NumberTriviaRepository,
  NumberTriviaRemoteDataSource,
  NumberTriviaLocalDataSource,
  NetworkInfo,
  DataConnectionChecker,
  SharedPreferences,
  http.Client,
])
void main() {}
