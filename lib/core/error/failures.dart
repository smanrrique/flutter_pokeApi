sealed class Failure implements Exception {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error']);
}
