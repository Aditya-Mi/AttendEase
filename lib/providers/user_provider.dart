import 'package:attendease/models/user.dart';
import 'package:attendease/repositories/shared_preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPreferenceRepositoryProvider = Provider(
  (ref) => SharedPreferencesRepository(),
);

final userProvider = FutureProvider<User>((ref) {
  final sharedPreferencesRepository =
      ref.read(sharedPreferenceRepositoryProvider);
  return sharedPreferencesRepository.getUser();
});
