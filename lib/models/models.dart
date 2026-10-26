import 'package:flutter/material.dart';

enum SessionStatus {
  completed,
  inProgress,
  upcoming,
}

class StudySession {
  final String id;
  final String subject;
  final String topic;
  final String timeRange;
  final int durationMinutes;
  final Color color;
  final IconData icon;
  final bool isCompleted;
  final SessionStatus status;

  StudySession({
    required this.id,
    required this.subject,
    required this.topic,
    required this.timeRange,
    required this.durationMinutes,
    required this.color,
    required this.icon,
    this.isCompleted = false,
    this.status = SessionStatus.upcoming,
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
    SessionStatus? status,
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
      status: status ?? this.status,
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

class SubjectProgress {
  final String name;
  final int percentage;
  final IconData icon;
  final Color color;

  const SubjectProgress({
    required this.name,
    required this.percentage,
    required this.icon,
    required this.color,
  });
}

// -------------------------------------------------------------
// الإشعارات والتنبيهات (App Notifications)
// -------------------------------------------------------------
enum NotificationType {
  study, // تذكير جلسات ومذاكرة
  support, // دعم نفسي وطمأنينة
  rewards, // مكافآت ونقاط
  system, // مواعيد واختبارات
}

class AppNotification {
  final String id;
  final String title;
  final String body;
  final String timeAgo;
  final NotificationType type;
  final IconData icon;
  final Color color;
  bool isRead;

  AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.timeAgo,
    required this.type,
    required this.icon,
    required this.color,
    this.isRead = false,
  });
}


