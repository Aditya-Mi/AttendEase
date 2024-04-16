import 'package:attendease/core/functions.dart';
import 'package:attendease/models/class.dart';
import 'package:attendease/models/class_record.dart';
import 'package:attendease/models/single_class_record.dart';
import 'package:attendease/providers/filter_provider.dart';
import 'package:attendease/providers/user_provider.dart';
import 'package:attendease/repositories/class_repository.dart';
import 'package:attendease/repositories/shared_preferences_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final classRepositoryProvider = Provider(
  (ref) => ClassRepository(
    sharedPreferencesRepository: SharedPreferencesRepository(),
  ),
);

final classProvider = FutureProvider<List<Class>>((ref) async {
  await ref.watch(classIdsProvider.future);
  final classRepository = ref.read(classRepositoryProvider);
  return classRepository.getAllClasses();
});

final singleClassRecordProvider =
    FutureProvider.family<ClassRecord, List<String>>((ref, list) {
  final classRepository = ref.read(classRepositoryProvider);
  return classRepository.getSingleRecord(list[0], list[1], list[2]);
});

final singleClassAttendanceRecords =
    FutureProvider.family<SingleClassRecord, String>((ref, classId) {
  final classRepository = ref.read(classRepositoryProvider);
  return classRepository.getStudentsAttendance(classId);
});

final recordScreen2Provider =
    FutureProvider.family<List<ClassRecord>, String>((ref, day) async {
  final classes = await ref.read(classProvider.future);
  final filter = ref.watch(filterProvider);
  final classRepository = ref.read(classRepositoryProvider);
  List<Class> filterClasses = [];
  filterClasses = classes.where((classData) {
    return classData.dayOfWeek.contains(day);
  }).toList();
  List<String> ids = filterClasses
      .where(
        (cls) =>
            cls.section == filter.section &&
            cls.type == filter.type &&
            cls.branch == filter.branch,
      )
      .map((cls) => cls.sId)
      .toList();
  if (ids.isEmpty) {
    return [];
  }
  return classRepository.getRecords(ids, null, null);
});

final currentClassRecordProvider =
    FutureProvider<List<ClassRecord>>((ref) async {
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
