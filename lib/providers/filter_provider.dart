import 'package:attendease/models/filters.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final filterProvider = StateProvider<Filters>(
  (ref) => Filters(),
);
