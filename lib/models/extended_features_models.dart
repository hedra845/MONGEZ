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

// -------------------------------------------------------------
// غرف المذاكرة الجماعية الافتراضية (Virtual Study Rooms)
// -------------------------------------------------------------
class RoomMember {
  final String id;
  final String name;
  final Color avatarColor;
  final String subject;
  final int streakDays;
  final bool isStudying;
  int cheersCount;

  RoomMember({
    required this.id,
    required this.name,
    required this.avatarColor,
    required this.subject,
    required this.streakDays,
    this.isStudying = true,
    this.cheersCount = 0,
  });
}

class StudyRoom {
  final String id;
  final String title;
  final String description;
  final String topic;
  int activeMembersCount;
  final int maxMembers;
  final String roomCode;
  final bool isPrivate;
  final int focusMinutes;
  final Color badgeColor;
  final List<RoomMember> members;

  StudyRoom({
    required this.id,
    required this.title,
    required this.description,
    required this.topic,
    required this.activeMembersCount,
    required this.maxMembers,
    required this.roomCode,
    this.isPrivate = false,
    required this.focusMinutes,
    required this.badgeColor,
    required this.members,
  });
}

// -------------------------------------------------------------
// حاسبة المعدل التراكمي وتوقع النتيجة (GPA Calculator)
// -------------------------------------------------------------
enum GpaScale {
  percentage, // 100% (نظام الثانوية والشهادات العامة)
  scale4, // 4.0 (نظام الساعات المعتمدة الأمريكي)
  scale5, // 5.0 (نظام الجامعات المعتمدة 5)
}

class GpaCourse {
  final String id;
  String name;
  double creditHours; // وزن المادة أو عدد ساعاتها
  double score; // الدرجة المئوية أو من 100
  String letterGrade; // A+, A, B+, B, C+, C, D+, D, F

  GpaCourse({
    required this.id,
    required this.name,
    required this.creditHours,
    required this.score,
    required this.letterGrade,
  });
}

// -------------------------------------------------------------
// الملاحظات الصوتية والملخصات الذكية (AI Audio Notes)
// -------------------------------------------------------------
class AudioStudyNote {
  final String id;
  final String title;
  final String subject;
  final String durationText;
  final String date;
  final String transcript;
  final List<String> bulletPoints;
  final List<String> keyTerms;
  final List<String> reviewQuestions;
  final Color color;
  bool isPlaying;
  bool hasAiSummary;

  AudioStudyNote({
    required this.id,
    required this.title,
    required this.subject,
    required this.durationText,
    required this.date,
    required this.transcript,
    required this.bulletPoints,
    required this.keyTerms,
    required this.reviewQuestions,
    required this.color,
    this.isPlaying = false,
    this.hasAiSummary = true,
  });
}

// -------------------------------------------------------------
// تتبع العادات الدراسية والذهنية (Habits Tracker)
// -------------------------------------------------------------
enum HabitCategory {
  study, // عادات دراسية
  health, // صحة ونشاط
  mindset, // هدوء ودعم نفسي
  timeManagement, // تنظيم الوقت
}

class HabitItem {
  final String id;
  final String title;
  final String description;
  final HabitCategory category;
  final IconData icon;
  final Color color;
  int streakDays;
  bool isCompletedToday;
  List<bool> weeklyHistory; // 7 days (السبت - الجمعة)

  HabitItem({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
    this.streakDays = 0,
    this.isCompletedToday = false,
    required this.weeklyHistory,
  });
}

// -------------------------------------------------------------
// جمل الدعم النفسي والتحفيز (Psychological Support Notifications)
// -------------------------------------------------------------
enum SupportMood {
  all, // عام وشامل
  examAnxiety, // قلق وتوتر الامتحانات
  lowMotivation, // فتور وفقدان شغف
  fearOfFailure, // خوف من الفشل وضغط النتيجة
  burnout, // إجهاد ذهني وحاجة للاستراحة
}

class PsychologicalQuote {
  final String id;
  final String message;
  final String authorOrContext;
  final SupportMood mood;
  final IconData icon;
  final Color accentColor;

  PsychologicalQuote({
    required this.id,
    required this.message,
    required this.authorOrContext,
    required this.mood,
    required this.icon,
    required this.accentColor,
  });
}

