import 'package:attendease/models/class.dart';
import 'package:attendease/repositories/class_repository.dart';
import 'package:attendease/repositories/shared_preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classRepositoryProvider = Provider(
  (ref) => ClassRepository(
    sharedPreferencesRepository: SharedPreferencesRepository(),
  ),
);

final classProvider = FutureProvider<List<Class>>((ref) {
  final classRepository = ref.read(classRepositoryProvider);
  return classRepository.getAllClasses();
});
