import 'dart:convert';
import 'package:flutter_playground/core/error/exceptions.dart';
import 'package:flutter_playground/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_playground/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockConcreteHttpclientSuccess200(int tNumber) {
    when(() => mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
            headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockConcreteHttpclientFailure404(int tNumber) {
    when(() => mockHttpClient.get(Uri.parse('http://numbersapi.com/$tNumber'),
            headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockRandomHttpclientSuccess200() {
    when(() => mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
            headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response(fixture('trivia.json'), 200));
  }

  void setUpMockRandomHttpclientFailure404() {
    when(() => mockHttpClient.get(Uri.parse('http://numbersapi.com/random'),
            headers: any(named: 'headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number 
        being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockConcreteHttpclientSuccess200(tNumber);
      // act
      dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      verify(() => mockHttpClient.get(
            Uri.parse('http://numbersapi.com/$tNumber'),
            headers: {
              'Content-Type': 'application/json',
            },
          ));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      // arrange
      setUpMockConcreteHttpclientSuccess200(tNumber);
      // act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockConcreteHttpclientFailure404(tNumber);
      // act
      final call = dataSource.getConcreteNumberTrivia;
      // assert
      expect(() => call(tNumber), throwsA(TypeMatcher<ServerException>()));
    });
  });

  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''should perform a GET request on a URL with number
        being the endpoint and with application/json header''', () async {
      // arrange
      setUpMockRandomHttpclientSuccess200();
      // act
      dataSource.getRandomNumberTrivia();
      // assert
      verify(() => mockHttpClient.get(
            Uri.parse('http://numbersapi.com/random'),
            headers: {
              'Content-Type': 'application/json',
            },
          ));
    });

    test('should return NumberTrivia when the response code is 200', () async {
      // arrange
      setUpMockRandomHttpclientSuccess200();
      // act
      final result = await dataSource.getRandomNumberTrivia();
      // assert
      expect(result, equals(tNumberTriviaModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockRandomHttpclientFailure404();
      // act
      final call = dataSource.getRandomNumberTrivia;
      // assert
      expect(() => call(), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
