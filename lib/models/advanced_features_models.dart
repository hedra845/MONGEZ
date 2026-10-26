import 'package:flutter/material.dart';

class RewardBadge {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;
  final int progress; // e.g., 80%

  RewardBadge({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.isUnlocked,
    this.progress = 100,
  });
}

class SoundAtmosphere {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
  bool isPlaying;
  double volume;

  SoundAtmosphere({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
    this.isPlaying = false,
    this.volume = 0.7,
  });
}

class Flashcard {
  final String id;
  final String question;
  final String answer;
  final String subject;
  bool isFlipped;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.subject,
    this.isFlipped = false,
  });
}

// -------------------------------------------------------------
// متجر المكافآت واستبدال النقاط (Rewards Store)
// -------------------------------------------------------------
class RedeemableReward {
  final String id;
  final String title;
  final String description;
  final int pointsCost;
  final IconData icon;
  final Color color;
  bool isClaimed;

  RedeemableReward({
    required this.id,
    required this.title,
    required this.description,
    required this.pointsCost,
    required this.icon,
    required this.color,
    this.isClaimed = false,
  });
}

// -------------------------------------------------------------
// مهام كسب النقاط اليومية (Daily Points Tasks)
// -------------------------------------------------------------
class PointsTask {
  final String id;
  final String title;
  final int pointsReward;
  final int currentProgress;
  final int targetProgress;
  final IconData icon;
  final Color color;
  bool isCompleted;
  bool isClaimed;

  PointsTask({
    required this.id,
    required this.title,
    required this.pointsReward,
    required this.currentProgress,
    required this.targetProgress,
    required this.icon,
    required this.color,
    this.isCompleted = false,
    this.isClaimed = false,
  });
}

