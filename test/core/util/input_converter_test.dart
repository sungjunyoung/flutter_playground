import 'package:dartz/dartz.dart';
import 'package:flutter_playground/core/util/input_converter.dart';
import 'package:test/test.dart';

void main() {
  late InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
        'should return an integer when the string represents an unsigned integer',
        () async {
      // arrange
      final str = '123';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // expect
      expect(result, Right(123));
    });

    test('should return a failure when the string is not an integer', () async {
      // arrange
      final str = '1.0';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // expect
      expect(result, Left(InvalidInputFailure()));
    });

    test('should return a failure when the string is a negative integer',
        () async {
      // arrange
      final str = '-123';
      // act
      final result = inputConverter.stringToUnsignedInteger(str);
      // expect
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
