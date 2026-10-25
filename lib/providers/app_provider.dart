import 'dart:async';
import 'package:flutter/material.dart';
import '../models/models.dart';
import '../models/advanced_features_models.dart';
import '../models/extended_features_models.dart';

class AppProvider extends ChangeNotifier {
  // Theme mode toggle
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  // User Profile & Onboarding State
  String userName = "أحمد محمد";
  String userEmail = "ahmed.student@example.com";
  String targetFaculty = "كلية هندسة";
  double targetPercentage = 90.0;

  void updateUserProfile({
    String? name,
    String? email,
    String? faculty,
    double? percentage,
  }) {
    if (name != null) userName = name;
    if (email != null) userEmail = email;
    if (faculty != null) targetFaculty = faculty;
    if (percentage != null) targetPercentage = percentage;
    notifyListeners();
  }

  // Deadlines
  List<ImportantDeadline> deadlines = [
    ImportantDeadline(
      id: "1",
      title: "مواعيد الإمتحانات",
      date: "2025-05-20",
      color: const Color(0xFF3B82F6),
      icon: Icons.calendar_today_rounded,
    ),
    ImportantDeadline(
      id: "2",
      title: "مواعيد الإمتحانات التجريبية",
      date: "2025-05-15",
      color: const Color(0xFFEF4444),
      icon: Icons.edit_calendar_rounded,
    ),
    ImportantDeadline(
      id: "3",
      title: "دروس إضافية ومراجعة",
      date: "2025-05-10",
      color: const Color(0xFF10B981),
      icon: Icons.school_rounded,
    ),
  ];

  void addDeadline(ImportantDeadline deadline) {
    deadlines.add(deadline);
    notifyListeners();
  }

  // Study Sessions (Schedule)
  List<StudySession> sessions = [
    StudySession(
      id: "1",
      subject: "الرياضيات",
      topic: "المعادلات التفاضلية والتكامل",
      timeRange: "2:00 - 3:30",
      durationMinutes: 45,
      color: const Color(0xFFF59E0B),
      icon: Icons.calculate_outlined,
    ),
    StudySession(
      id: "2",
      subject: "الفيزياء",
      topic: "الكهربية المغناطيسية والديناميكا",
      timeRange: "4:00 - 5:30",
      durationMinutes: 45,
      color: const Color(0xFF10B981),
      icon: Icons.electric_bolt_outlined,
    ),
    StudySession(
      id: "3",
      subject: "اللغة العربية",
      topic: "النحو والبلاغة والنصوص",
      timeRange: "6:00 - 7:00",
      durationMinutes: 45,
      color: const Color(0xFF8B5CF6),
      icon: Icons.auto_stories_outlined,
    ),
    StudySession(
      id: "4",
      subject: "اللغة الإنجليزية",
      topic: "القواعد والمفردات والترجمة",
      timeRange: "7:30 - 8:30",
      durationMinutes: 45,
      color: const Color(0xFF06B6D4),
      icon: Icons.language_outlined,
    ),
  ];

  // Active Timer State
  StudySession? currentSession;
  int _timerSeconds = 45 * 60; // 45 minutes default
  int _initialSeconds = 45 * 60;
  bool _isTimerRunning = false;
  Timer? _timer;

  int get timerSeconds => _timerSeconds;
  int get initialSeconds => _initialSeconds;
  bool get isTimerRunning => _isTimerRunning;

  double get timerProgress {
    if (_initialSeconds == 0) return 0;
    return (_initialSeconds - _timerSeconds) / _initialSeconds;
  }

  String get formattedTimer {
    int minutes = _timerSeconds ~/ 60;
    int seconds = _timerSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void startSession(StudySession session, [int minutes = 45]) {
    currentSession = session;
    _initialSeconds = minutes * 60;
    _timerSeconds = _initialSeconds;
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _isTimerRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        _timerSeconds--;
        notifyListeners();
      } else {
        stopTimer();
      }
    });
    notifyListeners();
  }

  void pauseTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void toggleTimer() {
    if (_isTimerRunning) {
      pauseTimer();
    } else {
      startTimer();
    }
  }

  void stopTimer() {
    _timer?.cancel();
    _isTimerRunning = false;
    notifyListeners();
  }

  void resetTimer([int minutes = 45]) {
    _timer?.cancel();
    _isTimerRunning = false;
    _initialSeconds = minutes * 60;
    _timerSeconds = _initialSeconds;
    notifyListeners();
  }

  // Distraction Lock Screen State
  bool isDeviceLocked = true;
  int breakMinutesRemaining = 15;
  int breakSecondsRemaining = 0;

  List<AppInfo> appsToBlock = [
    AppInfo(name: "YouTube", iconAsset: "", iconData: Icons.play_circle_fill, iconBgColor: Colors.red, isBlocked: true),
    AppInfo(name: "Instagram", iconAsset: "", iconData: Icons.camera_alt, iconBgColor: Colors.pink, isBlocked: true),
    AppInfo(name: "TikTok", iconAsset: "", iconData: Icons.music_note, iconBgColor: Colors.black, isBlocked: true),
    AppInfo(name: "Twitter (X)", iconAsset: "", iconData: Icons.close, iconBgColor: Colors.blueGrey, isBlocked: true),
    AppInfo(name: "Facebook", iconAsset: "", iconData: Icons.facebook, iconBgColor: Colors.blue, isBlocked: true),
  ];

  List<AppInfo> appsAllowed = [
    AppInfo(name: "القاموس", iconAsset: "", iconData: Icons.book, iconBgColor: Colors.teal, isBlocked: false),
    AppInfo(name: "الآلة الحاسبة", iconAsset: "", iconData: Icons.calculate, iconBgColor: Colors.indigo, isBlocked: false),
    AppInfo(name: "الملاحظات", iconAsset: "", iconData: Icons.note_alt, iconBgColor: Colors.amber, isBlocked: false),
  ];

  void toggleAppBlock(AppInfo app) {
    app.isBlocked = !app.isBlocked;
    notifyListeners();
  }

  void unlockDevice() {
    isDeviceLocked = false;
    notifyListeners();
  }

  void lockDevice() {
    isDeviceLocked = true;
    notifyListeners();
  }

  // AI Quiz state
  int quizScore = 80; // 80% as shown in design
  bool isQuizGenerating = false;

  List<QuizQuestion> sampleQuestions = [
    QuizQuestion(
      question: "ما هي مشتقة الدالة f(x) = sin(2x) ؟",
      options: ["cos(2x)", "2 cos(2x)", "-2 cos(2x)", "2 sin(x)"],
      correctIndex: 1,
      selectedIndex: 1,
    ),
    QuizQuestion(
      question: "ما هي وحدة قياس القوة الدافعة الكهربية المستحثة؟",
      options: ["الأوم", "التسلا", "الفولت", "الويبر"],
      correctIndex: 2,
      selectedIndex: 2,
    ),
    QuizQuestion(
      question: "إعراب كلمة (طالباً) في جملة (يا طالباً العلمَ اجتهدْ):",
      options: ["منادى شبيه بالمضاف منصوب", "منادى مضاف منصوب", "منادى نكرة غير مقصودة", "حال منصوب"],
      correctIndex: 0,
      selectedIndex: 0,
    ),
  ];

  // Rewards & Badges (نظام الجوائز والألعاب المذكور في رأس التصميم)
  int userCoins = 450;
  int streakDays = 7;

  List<RewardBadge> badges = [
    RewardBadge(
      id: "1",
      title: "بطل الانضباط",
      description: "إتمام 7 أيام متتالية من المذاكرة دون انقطاع",
      icon: Icons.local_fire_department_rounded,
      color: const Color(0xFFEF4444),
      isUnlocked: true,
      progress: 100,
    ),
    RewardBadge(
      id: "2",
      title: "صائد الدقائق",
      description: "المذاكرة لمدة أكثر من 20 ساعة أسبوعياً",
      icon: Icons.timer_rounded,
      color: const Color(0xFF1E5BB8),
      isUnlocked: true,
      progress: 100,
    ),
    RewardBadge(
      id: "3",
      title: "عبقري الذكاء الاصطناعي",
      description: "الحصول على درجة 100% في 5 اختبارات ذكية",
      icon: Icons.psychology_rounded,
      color: const Color(0xFF8B5CF6),
      isUnlocked: false,
      progress: 60,
    ),
    RewardBadge(
      id: "4",
      title: "قاهر المشتتات",
      description: "تفعيل وضع القفل التام لأكثر من 50 ساعة",
      icon: Icons.shield_rounded,
      color: const Color(0xFF10B981),
      isUnlocked: true,
      progress: 100,
    ),
  ];

  // Ambient Study Sounds (صوتيات التركيز والمذاكرة)
  List<SoundAtmosphere> soundAtmospheres = [
    SoundAtmosphere(
      id: "rain",
      name: "صوت المطر الهادئ",
      icon: Icons.water_drop_rounded,
      color: const Color(0xFF0EA5E9),
      isPlaying: false,
    ),
    SoundAtmosphere(
      id: "waves",
      name: "أمواج البحر",
      icon: Icons.waves_rounded,
      color: const Color(0xFF1E5BB8),
      isPlaying: false,
    ),
    SoundAtmosphere(
      id: "fireplace",
      name: "دفء الموقد",
      icon: Icons.local_fire_department_rounded,
      color: const Color(0xFFF97316),
      isPlaying: false,
    ),
    SoundAtmosphere(
      id: "cafe",
      name: "أجواء المكتبة والمقهى",
      icon: Icons.local_cafe_rounded,
      color: const Color(0xFF8B5CF6),
      isPlaying: false,
    ),
    SoundAtmosphere(
      id: "forest",
      name: "هدوء الطبيعة والطيور",
      icon: Icons.forest_rounded,
      color: const Color(0xFF10B981),
      isPlaying: false,
    ),
  ];

  void toggleSound(SoundAtmosphere sound) {
    sound.isPlaying = !sound.isPlaying;
    notifyListeners();
  }

  void updateSoundVolume(SoundAtmosphere sound, double volume) {
    sound.volume = volume;
    notifyListeners();
  }

  // Smart Flashcards (البطاقات التعليمية الذكية للمراجعة السريعة)
  List<Flashcard> flashcards = [
    Flashcard(
      id: "1",
      subject: "الرياضيات",
      question: "ما هو قانون ميل المماس لمنحنى الدالة؟",
      answer: "المشتقة الأولى للدالة عند نقطة التماس: f'(x) = dy/dx",
    ),
    Flashcard(
      id: "2",
      subject: "الفيزياء",
      question: "ما هو نص قانون فاراداي للحث الكهرومغناطيسي؟",
      answer: "القوة الدافعة الكهربية المستحثة تتناسب طردياً مع المعدل الزمني للتغير في الفيض المغناطيسي.",
    ),
    Flashcard(
      id: "3",
      subject: "اللغة العربية",
      question: "ما هي شروط عمل (لا) النافية للجنس عمل (إنّ)؟",
      answer: "1- أن يكون اسمها وخبرها نكرتين.\n2- ألا يفصل بينها وبين اسمها فاصل.\n3- ألا يدخل عليها حرف جر.",
    ),
  ];

  void flipFlashcard(Flashcard card) {
    card.isFlipped = !card.isFlipped;
    notifyListeners();
  }

  // AI Study Tutor Chat (معلم الذكاء الاصطناعي الخاص)
  List<AiStudyChat> chatMessages = [
    AiStudyChat(
      id: "1",
      sender: "ai",
      text: "مرحباً يا بطل! أنا معلمك الذكي من مُنجز 🤖. إذا واجهت أي مسألة صعبة أو مفهوم يحتاج لتبسيط، اسألني وسأشرحه لك بالخطوات!",
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
  ];

  void sendAiMessage(String query) {
    if (query.trim().isEmpty) return;

    chatMessages.add(
      AiStudyChat(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: "user",
        text: query,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();

    // Smart simulated responses for student topics
    Future.delayed(const Duration(milliseconds: 1200), () {
      String response = "سؤال رائع! لحل هذه النقطة، ركّز أولاً على كتابة المعطيات بدقة، ثم تطبيق القاعدة الأساسية. يمكنك مراجعة بطاقة القوانين السريعة أيضاً لترسيخ المفهوم!";
      if (query.contains("تفاضل") || query.contains("رياضيات") || query.contains("مشتقة")) {
        response = "في التفاضل، تذكر دائماً قاعدة السلسلة: مشتقة الدالة الخارجية مضروبة في مشتقة ما بداخل القوس. مثال: (sin 2x)' = 2 * cos 2x.";
      } else if (query.contains("فيزياء") || query.contains("فاراداي") || query.contains("كهرباء")) {
        response = "في الكهرومغناطيسية، قانون لنز يحدد اتجاه التيار المستحث بحيث يعاكس التغير في الفيض المسبب له. تذكر قاعدة اليد اليمنى!";
      } else if (query.contains("نحو") || query.contains("إعراب") || query.contains("عربي")) {
        response = "لتحديد الإعراب بدقة، حدد أولاً نوع الجملة (اسمية أو فعلية)، وابحث عن الأركان الأساسية مثل المبتدأ والخبر أو الفعل والفاعل.";
      }

      chatMessages.add(
        AiStudyChat(
          id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
          sender: "ai",
          text: response,
          timestamp: DateTime.now(),
        ),
      );
      notifyListeners();
    });
  }

  // Wellness & Mental Health (صحة ورفاهية متكاملة للطلاب)
  int waterCupsDrunk = 5;
  final int targetWaterCups = 8;

  void addWaterCup() {
    if (waterCupsDrunk < targetWaterCups) {
      waterCupsDrunk++;
      notifyListeners();
    }
  }

  void resetWater() {
    waterCupsDrunk = 0;
    notifyListeners();
  }

  List<WellnessExercise> wellnessExercises = [
    WellnessExercise(
      id: "breath",
      title: "تمرين التنفس 4-7-8",
      subtitle: "استنشاق 4ث، حبس 7ث، زفير 8ث لتقليل توتر الامتحانات",
      durationSeconds: 120,
      icon: Icons.air_rounded,
      color: const Color(0xFF0EA5E9),
    ),
    WellnessExercise(
      id: "eye",
      title: "قاعدة 20-20-20 للعين",
      subtitle: "كل 20 دقيقة، انظر لشيء يبعد 20 قدماً لمدة 20 ثانية",
      durationSeconds: 60,
      icon: Icons.visibility_rounded,
      color: const Color(0xFF10B981),
    ),
    WellnessExercise(
      id: "stretch",
      title: "تمارين استطالة الرقبة والظهر",
      subtitle: "تخفيف آلام الجلوس الطويل والمذاكرة المستمرة",
      durationSeconds: 180,
      icon: Icons.self_improvement_rounded,
      color: const Color(0xFFF59E0B),
    ),
  ];

  // Quick Study Notes (ملاحظات سريعة أثناء المذاكرة)
  List<StudyNote> notes = [
    StudyNote(
      id: "1",
      subject: "الرياضيات",
      title: "ملاحظة هامة في النهايات",
      content: "عند التعويض المباشر والوصول لـ 0/0، استخدم قاعدة لوبيتال باشتقاق البسط والمقام بشكل منفصل.",
      date: "اليوم 4:30 م",
      color: const Color(0xFFF59E0B),
    ),
    StudyNote(
      id: "2",
      subject: "الفيزياء",
      title: "فكرة مسألة محول كهربي",
      content: "في المحول المثالي: القدرة في الملف الابتدائي تساوي القدرة في الملف الثانوي (Vp * Ip = Vs * Is).",
      date: "أمس 7:15 م",
      color: const Color(0xFF0EA5E9),
    ),
  ];

  void addNote(StudyNote note) {
    notes.insert(0, note);
    notifyListeners();
  }

  void deleteNote(String id) {
    notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
