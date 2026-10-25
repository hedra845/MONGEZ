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
