// ignore_for_file: leading_newlines_in_multiline_strings

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd_clean_app/core/error/exceptions.dart';
import 'package:tdd_clean_app/features/number_trivia/data/datasourses/number_trivia_remote_data_source.dart';
import 'package:tdd_clean_app/features/number_trivia/data/models/number_trivia_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import '../../../../mocks/number_trivia.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request on a URL with number
    being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();

      // act
      dataSource.getConcreteNumberTrivia(tNumber);

      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/$tNumber'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTriviaModel when response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();

      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);

      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();

      // act
      final call = dataSource.getConcreteNumberTrivia;

      // assert
      expect(
          () => call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));
    test('''should perform a GET request on a URL with random
    endpoint and with application/json header''', () async {
      // arrange
      setUpMockHttpClientSuccess200();

      // act
      dataSource.getRandomNumberTrivia();

      // assert
      verify(mockHttpClient.get(
        Uri.parse('http://numbersapi.com/random'),
        headers: {
          'Content-Type': 'application/json',
        },
      ));
    });

    test('should return NumberTriviaModel when response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();

      // act
      final result = await dataSource.getRandomNumberTrivia();

      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test('should throw a ServerException when the response code 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();

      // act
      final call = dataSource.getRandomNumberTrivia;

      // assert
      expect(call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
