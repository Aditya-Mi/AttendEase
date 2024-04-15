import 'package:attendease/core/functions.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/models/class_record.dart';
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

final classRecordProvider = FutureProvider<List<ClassRecord>>((ref) async {
  final classes = await ref.watch(classProvider.future);
  List<Class> classesOnCurrentDay = classes.where((classData) {
    return classData.dayOfWeek.contains(getCurrentDay());
  }).toList();
  final classesBeforeCurrentTime = filterClasses(classesOnCurrentDay);
  final classIds = getClassIds(classesBeforeCurrentTime);
  final classRepository = ref.read(classRepositoryProvider);
  final startDate = getCurrentDate();
  final endDate = getNextDay(startDate);
  return classRepository.getRecords(classIds, startDate, endDate);
});
