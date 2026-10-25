import 'package:flutter/material.dart';

class StudySession {
  final String id;
  final String subject;
  final String topic;
  final String timeRange;
  final int durationMinutes;
  final Color color;
  final IconData icon;
  final bool isCompleted;

  StudySession({
    required this.id,
    required this.subject,
    required this.topic,
    required this.timeRange,
    required this.durationMinutes,
    required this.color,
    required this.icon,
    this.isCompleted = false,
  });

  StudySession copyWith({
    String? id,
    String? subject,
    String? topic,
    String? timeRange,
    int? durationMinutes,
    Color? color,
    IconData? icon,
    bool? isCompleted,
  }) {
    return StudySession(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      topic: topic ?? this.topic,
      timeRange: timeRange ?? this.timeRange,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class ImportantDeadline {
  final String id;
  final String title;
  final String date;
  final Color color;
  final IconData icon;

  ImportantDeadline({
    required this.id,
    required this.title,
    required this.date,
    required this.color,
    required this.icon,
  });
}

class AppInfo {
  final String name;
  final String iconAsset;
  final IconData iconData;
  final Color iconBgColor;
  bool isBlocked;

  AppInfo({
    required this.name,
    required this.iconAsset,
    required this.iconData,
    required this.iconBgColor,
    this.isBlocked = false,
  });
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  int? selectedIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    this.selectedIndex,
  });
}
