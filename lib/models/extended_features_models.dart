import 'package:flutter/material.dart';

class AiStudyChat {
  final String id;
  final String sender; // 'user' or 'ai'
  final String text;
  final DateTime timestamp;

  AiStudyChat({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
  });
}

class WellnessExercise {
  final String id;
  final String title;
  final String subtitle;
  final int durationSeconds;
  final IconData icon;
  final Color color;

  WellnessExercise({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.durationSeconds,
    required this.icon,
    required this.color,
  });
}

class StudyNote {
  final String id;
  final String subject;
  final String title;
  final String content;
  final String date;
  final Color color;

  StudyNote({
    required this.id,
    required this.subject,
    required this.title,
    required this.content,
    required this.date,
    required this.color,
  });
}
