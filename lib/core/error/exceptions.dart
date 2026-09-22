
class ServerException implements Exception {}

class CacheException implements Exception {}

class NetworkException implements Exception {}

bool isOfflineError(Object error) {
  final text = error.toString().toLowerCase();
  return text.contains('socketexception') ||
      text.contains('clientexception') ||
      text.contains('failed host lookup') ||
      text.contains('connection abort') ||
      text.contains('network is unreachable') ||
      text.contains('connection reset') ||
      text.contains('connection refused') ||
      text.contains('timed out') ||
      text.contains('timeout');
}