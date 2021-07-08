import 'package:dartz/dartz.dart';
import 'package:flutter_playground/core/error/exceptions.dart';
import 'package:flutter_playground/core/error/failures.dart';
import 'package:flutter_playground/core/network/netfork_info.dart';
import 'package:flutter_playground/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:flutter_playground/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:flutter_playground/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:flutter_playground/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_playground/features/number_trivia/domain/repositories/number_trivia_repository.dart';

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
    return await _getTrivia(
        () async => remoteDataSource.getConcreteNumberTrivia(number));
  }

  @override
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia() async {
    return await _getTrivia(
        () async => remoteDataSource.getRandomNumberTrivia());
  }

  Future<Either<Failure, NumberTrivia>> _getTrivia(
    Future<NumberTriviaModel> Function() getConcreteOrRandom,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        final remoteTrivia = await getConcreteOrRandom();
        localDataSource.cacheNumberTrivia(remoteTrivia);
        return Right(remoteTrivia);
      } on ServerException {
        return Left(ServerFailure());
      }
    }

    try {
      final localTrivia = await localDataSource.getLastNumberTrivia();
      return Right(localTrivia);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
