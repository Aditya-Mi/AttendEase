// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Class {
  final String sId;
  final String subject;
  final int semester;
  final List<String> dayOfWeek;
  final String startTime;
  final String endTime;
  final String topic;
  final String branch;
  final String section;
  final String type;
  final int roomNo;
  final String teacher;
  final String createdAt;
  final String updatedAt;
  Class({
    required this.sId,
    required this.subject,
    required this.semester,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.topic,
    required this.branch,
    required this.section,
    required this.type,
    required this.roomNo,
    required this.teacher,
    required this.createdAt,
    required this.updatedAt,
  });

  Class copyWith({
    String? sId,
    String? subject,
    int? semester,
    List<String>? dayOfWeek,
    String? startTime,
    String? endTime,
    String? topic,
    String? branch,
    String? section,
    String? type,
    int? roomNo,
    String? teacher,
    String? createdAt,
    String? updatedAt,
  }) {
    return Class(
      sId: sId ?? this.sId,
      subject: subject ?? this.subject,
      semester: semester ?? this.semester,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      topic: topic ?? this.topic,
      branch: branch ?? this.branch,
      section: section ?? this.section,
      type: type ?? this.type,
      roomNo: roomNo ?? this.roomNo,
      teacher: teacher ?? this.teacher,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': sId,
      'subject': subject,
      'semester': semester,
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      'topic': topic,
      'branch': branch,
      'section': section,
      'type': type,
      'roomNo': roomNo,
      'teacher': teacher,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory Class.fromJson(Map<String, dynamic> map) {
    return Class(
      sId: map['_id'] as String,
      subject: map['subject'] as String,
      semester: map['semester'] as int,
      dayOfWeek: List<String>.from(map['dayOfWeek']),
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      topic: map['topic'] as String,
      branch: map['branch'] as String,
      section: map['section'] as String,
      type: map['type'] as String,
      roomNo: map['roomNo'] as int,
      teacher: map['teacher'] as String,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Class(sId: $sId, subject: $subject, semester: $semester, dayOfWeek: $dayOfWeek, startTime: $startTime, endTime: $endTime, topic: $topic, branch: $branch, section: $section, type: $type, roomNo: $roomNo, teacher: $teacher, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(covariant Class other) {
    if (identical(this, other)) return true;

    return other.sId == sId &&
        other.subject == subject &&
        other.semester == semester &&
        listEquals(other.dayOfWeek, dayOfWeek) &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.topic == topic &&
        other.branch == branch &&
        other.section == section &&
        other.type == type &&
        other.roomNo == roomNo &&
        other.teacher == teacher &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return sId.hashCode ^
        subject.hashCode ^
        semester.hashCode ^
        dayOfWeek.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        topic.hashCode ^
        branch.hashCode ^
        section.hashCode ^
        type.hashCode ^
        roomNo.hashCode ^
        teacher.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
