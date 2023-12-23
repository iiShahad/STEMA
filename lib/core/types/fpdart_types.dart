import 'package:fpdart/fpdart.dart';
import 'package:stema/core/types/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = Future<Either<Failure, void>>;
