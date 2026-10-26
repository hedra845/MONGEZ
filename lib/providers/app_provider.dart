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

  // Subscription State (الاشتراك الرمزي المدفوع)
  bool isPremium = true; // مفعل كعرض اشتراك رمزي
  String subscriptionPlan = "الاشتراك الفصلي الرمزي (29 ج.م / شهر)";
  DateTime subscriptionExpiryDate = DateTime(2026, 6, 30);

  void activateSubscription(String planName) {
    isPremium = true;
    subscriptionPlan = planName;
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

  // Daily Goal Stats
  int dailyGoalHours = 3;
  int completedGoalHours = 1;

  // Subjects Progress List
  final List<SubjectProgress> subjectsProgress = const [
    SubjectProgress(
      name: "اللغة العربية",
      percentage: 90,
      icon: Icons.menu_book_rounded,
      color: Color(0xFF8B5CF6),
    ),
    SubjectProgress(
      name: "الرياضيات",
      percentage: 80,
      icon: Icons.calculate_rounded,
      color: Color(0xFF2563EB),
    ),
    SubjectProgress(
      name: "اللغة الإنجليزية",
      percentage: 45,
      icon: Icons.translate_rounded,
      color: Color(0xFFF43F5E),
    ),
    SubjectProgress(
      name: "العلوم",
      percentage: 60,
      icon: Icons.science_rounded,
      color: Color(0xFF10B981),
    ),
  ];

  // Study Sessions (Schedule)
  List<StudySession> sessions = [
    StudySession(
      id: "1",
      subject: "اللغة العربية",
      topic: "النحو والبلاغة والنصوص الأدبية",
      timeRange: "8:00 ص - 10:00 ص",
      durationMinutes: 120,
      color: const Color(0xFF8B5CF6),
      icon: Icons.menu_book_rounded,
      isCompleted: true,
      status: SessionStatus.completed,
    ),
    StudySession(
      id: "2",
      subject: "الرياضيات",
      topic: "المعادلات والتفاضل والتكامل",
      timeRange: "11:00 ص - 1:00 م",
      durationMinutes: 120,
      color: const Color(0xFF2563EB),
      icon: Icons.calculate_rounded,
      isCompleted: false,
      status: SessionStatus.inProgress,
    ),
    StudySession(
      id: "3",
      subject: "اللغة الإنجليزية",
      topic: "المفردات والقواعد والترجمة",
      timeRange: "4:00 م - 6:00 م",
      durationMinutes: 120,
      color: const Color(0xFFF43F5E),
      icon: Icons.translate_rounded,
      isCompleted: false,
      status: SessionStatus.upcoming,
    ),
    StudySession(
      id: "4",
      subject: "العلوم",
      topic: "الفيزياء والكيمياء والأحياء",
      timeRange: "8:00 م - 9:30 م",
      durationMinutes: 90,
      color: const Color(0xFF10B981),
      icon: Icons.science_rounded,
      isCompleted: false,
      status: SessionStatus.upcoming,
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

  // Rewards & Gamification (نظام النقاط والجوائز ومستوى الطالب)
  int userCoins = 580;
  int streakDays = 7;
  int userLevel = 5;
  int currentXp = 1450;
  int targetXp = 2000;
  int streakFreezeCount = 1;
  bool isDailyChestClaimed = false;

  // نجوم التفوق والانضباط (نجمة الاختبارات العالية + الالتزام بالحصص والمذاكرة)
  int excellenceStars = 14; 
  int annualRank = 1; // الترتيب في مكافأة نهاية العام من إدارة التطبيق

  void awardExcellenceStar(String reason) {
    excellenceStars++;
    addPoints(100);
    notifyListeners();
  }

  String get studentLevelTitle {
    if (userLevel >= 10) return "أسطورة الدفعة 👑";
    if (userLevel >= 7) return "بطل مُنجز 💎";
    if (userLevel >= 5) return "طالب عبقري 🥇";
    if (userLevel >= 3) return "صانع الفارق 🥈";
    return "طالب مجتهد 🥉";
  }

  // Redeemable Rewards (متجر استبدال النقاط والجوائز)
  List<RedeemableReward> redeemableRewards = [
    RedeemableReward(
      id: "rew_1",
      title: "قسيمة استراحة إضافية 20 دقيقة",
      description: "استمتع باستراحة مستحقة بدون تأنيب ضمير مع موسيقى هادئة",
      pointsCost: 100,
      icon: Icons.coffee_rounded,
      color: const Color(0xFFF59E0B),
      isClaimed: false,
    ),
    RedeemableReward(
      id: "rew_2",
      title: "درع حماية الاستمرارية (Streak Freeze)",
      description: "يحمي عداد أيامك المتتالية من الانكسار إذا فاتتك جلسة ليوم واحد",
      pointsCost: 180,
      icon: Icons.shield_rounded,
      color: const Color(0xFF0EA5E9),
      isClaimed: true,
    ),
    RedeemableReward(
      id: "rew_3",
      title: "فتح صوتيات التركيز الحصرية",
      description: "حزمة أصوات نادرة: مكتبة جامعة أكسفورد ومطر الغابة الهادئ",
      pointsCost: 220,
      icon: Icons.headphones_rounded,
      color: const Color(0xFF8B5CF6),
      isClaimed: false,
    ),
    RedeemableReward(
      id: "rew_4",
      title: "اختبارات ذكاء اصطناعي غير محدودة (يوم كامل)",
      description: "توليد كويزات ومراجعات لجميع فصول المنهج بلا حدود لمدة 24 ساعة",
      pointsCost: 300,
      icon: Icons.auto_awesome_rounded,
      color: const Color(0xFF10B981),
      isClaimed: false,
    ),
    RedeemableReward(
      id: "rew_5",
      title: "الثيم الذهبي للمتفوقين (Gold VIP)",
      description: "شعار ذهبي يظهر بجانب اسمك في غرف المذاكرة ولوحة الشرف",
      pointsCost: 450,
      icon: Icons.workspace_premium_rounded,
      color: const Color(0xFFEAB308),
      isClaimed: false,
    ),
    RedeemableReward(
      id: "rew_6",
      title: "شهادة تفوق إلكترونية معتمدة من مُنجز",
      description: "شهادة تقدير رسمية باسمك ومعدلك الدراسي قابلة للتحميل والمشاركة",
      pointsCost: 500,
      icon: Icons.card_membership_rounded,
      color: const Color(0xFFEC4899),
      isClaimed: false,
    ),
  ];

  // Daily Points Tasks (مهام كسب النقاط اليومية)
  List<PointsTask> dailyPointsTasks = [
    PointsTask(
      id: "task_1",
      title: "إتمام جلسة بومودورو كاملة (25 دقيقة)",
      pointsReward: 50,
      currentProgress: 1,
      targetProgress: 1,
      icon: Icons.timer_rounded,
      color: const Color(0xFF1E5BB8),
      isCompleted: true,
      isClaimed: false,
    ),
    PointsTask(
      id: "task_2",
      title: "إنجاز 3 من العادات اليومية",
      pointsReward: 60,
      currentProgress: 3,
      targetProgress: 3,
      icon: Icons.checklist_rtl_rounded,
      color: const Color(0xFF6366F1),
      isCompleted: true,
      isClaimed: true,
    ),
    PointsTask(
      id: "task_3",
      title: "المذاكرة 45 دقيقة داخل غرفة جماعية",
      pointsReward: 70,
      currentProgress: 45,
      targetProgress: 45,
      icon: Icons.groups_rounded,
      color: const Color(0xFF10B981),
      isCompleted: true,
      isClaimed: false,
    ),
    PointsTask(
      id: "task_4",
      title: "حل اختبار ذكي بنتيجة 80% فأعلى",
      pointsReward: 80,
      currentProgress: 0,
      targetProgress: 1,
      icon: Icons.assignment_turned_in_rounded,
      color: const Color(0xFFEC4899),
      isCompleted: false,
      isClaimed: false,
    ),
    PointsTask(
      id: "task_5",
      title: "المذاكرة في ساعات الصباح الباكر",
      pointsReward: 40,
      currentProgress: 1,
      targetProgress: 1,
      icon: Icons.wb_sunny_rounded,
      color: const Color(0xFFF59E0B),
      isCompleted: true,
      isClaimed: false,
    ),
    PointsTask(
      id: "task_6",
      title: "تحدي مضاعفة النقاط (ساعتين مذاكرة متواصلة)",
      pointsReward: 120,
      currentProgress: 2,
      targetProgress: 2,
      icon: Icons.bolt_rounded,
      color: const Color(0xFF8B5CF6),
      isCompleted: true,
      isClaimed: false,
    ),
    PointsTask(
      id: "task_7",
      title: "مراجعة 20 بطاقة تعليمية (Flashcards)",
      pointsReward: 45,
      currentProgress: 14,
      targetProgress: 20,
      icon: Icons.style_rounded,
      color: const Color(0xFF06B6D4),
      isCompleted: false,
      isClaimed: false,
    ),
  ];

  void addPoints(int amount) {
    userCoins += amount;
    currentXp += amount;
    if (currentXp >= targetXp) {
      userLevel++;
      currentXp = currentXp - targetXp;
      targetXp += 500;
    }
    notifyListeners();
  }

  bool redeemReward(String rewardId) {
    final reward = redeemableRewards.firstWhere((r) => r.id == rewardId);
    if (userCoins >= reward.pointsCost && !reward.isClaimed) {
      userCoins -= reward.pointsCost;
      reward.isClaimed = true;
      if (rewardId == "rew_2") {
        streakFreezeCount++;
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  void claimTaskPoints(String taskId) {
    final task = dailyPointsTasks.firstWhere((t) => t.id == taskId);
    if (task.isCompleted && !task.isClaimed) {
      task.isClaimed = true;
      addPoints(task.pointsReward);
    }
  }

  int claimDailyChest() {
    if (!isDailyChestClaimed) {
      isDailyChestClaimed = true;
      const rewardCoins = 75;
      addPoints(rewardCoins);
      return rewardCoins;
    }
    return 0;
  }

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
    RewardBadge(
      id: "5",
      title: "روح الفريق",
      description: "المذاكرة أكثر من 10 ساعات في الغرف الجماعية",
      icon: Icons.groups_rounded,
      color: const Color(0xFF0EA5E9),
      isUnlocked: true,
      progress: 100,
    ),
    RewardBadge(
      id: "6",
      title: "سيد العادات",
      description: "الالتزام بجميع العادات اليومية لمدة أسبوع كامل",
      icon: Icons.checklist_rtl_rounded,
      color: const Color(0xFF6366F1),
      isUnlocked: false,
      progress: 75,
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

  // =============================================================
  // غرف المذاكرة الجماعية الافتراضية (Virtual Study Rooms)
  // =============================================================
  StudyRoom? currentStudyRoom;
  List<StudyRoom> studyRooms = [
    StudyRoom(
      id: "room_1",
      title: "غرفة أوائل الثانوية العامة 🚀",
      description: "جلسات تركيز عميق مع تقنية بومودورو 50 دقيقة واستراحة 10 دقائق",
      topic: "الرياضيات والفيزياء",
      activeMembersCount: 14,
      maxMembers: 25,
      roomCode: "MNZ-701",
      focusMinutes: 50,
      badgeColor: const Color(0xFF1E5BB8),
      members: [
        RoomMember(
          id: "m1",
          name: "أحمد كمال (أنت)",
          avatarColor: const Color(0xFF1E5BB8),
          subject: "التفاضل والتكامل",
          streakDays: 12,
          isStudying: true,
          cheersCount: 8,
        ),
        RoomMember(
          id: "m2",
          name: "سارة محمود",
          avatarColor: const Color(0xFF10B981),
          subject: "الفيزياء الحديثة",
          streakDays: 19,
          isStudying: true,
          cheersCount: 24,
        ),
        RoomMember(
          id: "m3",
          name: "عمر خالد",
          avatarColor: const Color(0xFFF59E0B),
          subject: "الكيمياء العضوية",
          streakDays: 7,
          isStudying: true,
          cheersCount: 15,
        ),
        RoomMember(
          id: "m4",
          name: "مريم إبراهيم",
          avatarColor: const Color(0xFF8B5CF6),
          subject: "اللغة الإنجليزية",
          streakDays: 15,
          isStudying: false,
          cheersCount: 31,
        ),
      ],
    ),
    StudyRoom(
      id: "room_2",
      title: "ماراثون الهندسة والحاسبات 💻",
      description: "غرفة صامتة للبرمجة والرياضيات التطبيقية وحل المسائل المتقدمة",
      topic: "هندسة وحاسبات",
      activeMembersCount: 9,
      maxMembers: 20,
      roomCode: "ENG-402",
      focusMinutes: 45,
      badgeColor: const Color(0xFF0EA5E9),
      members: [
        RoomMember(
          id: "m5",
          name: "يوسف عادل",
          avatarColor: const Color(0xFF0EA5E9),
          subject: "خوارزميات وحل مسائل",
          streakDays: 22,
          isStudying: true,
          cheersCount: 19,
        ),
        RoomMember(
          id: "m6",
          name: "ندى حسن",
          avatarColor: const Color(0xFFEC4899),
          subject: "الجبر الخطي والمصفوفات",
          streakDays: 14,
          isStudying: true,
          cheersCount: 11,
        ),
      ],
    ),
    StudyRoom(
      id: "room_3",
      title: "مجموعة مراجعة ليلة الامتحان ⚡",
      description: "مراجعة تلخيصية مكثفة واختبارات سريعة لكل فصول المنهج",
      topic: "مراجعات عامة وشاملة",
      activeMembersCount: 21,
      maxMembers: 30,
      roomCode: "EXM-990",
      focusMinutes: 30,
      badgeColor: const Color(0xFF10B981),
      members: [
        RoomMember(
          id: "m7",
          name: "كريم سامح",
          avatarColor: const Color(0xFF10B981),
          subject: "مراجعة النحو والأدب",
          streakDays: 5,
          isStudying: true,
          cheersCount: 9,
        ),
      ],
    ),
  ];

  void joinRoom(StudyRoom room) {
    currentStudyRoom = room;
    if (!room.members.any((m) => m.id == "current_user")) {
      room.members.insert(
        0,
        RoomMember(
          id: "current_user",
          name: userName.isNotEmpty ? "$userName (أنت)" : "أنت",
          avatarColor: const Color(0xFF1E5BB8),
          subject: currentSession?.subject ?? "مذاكرة مركزة",
          streakDays: 14,
          isStudying: true,
          cheersCount: 0,
        ),
      );
      room.activeMembersCount++;
    }
    notifyListeners();
  }

  void leaveRoom() {
    currentStudyRoom = null;
    notifyListeners();
  }

  void cheerMember(String roomId, String memberId) {
    final room = studyRooms.firstWhere((r) => r.id == roomId, orElse: () => studyRooms.first);
    final member = room.members.firstWhere((m) => m.id == memberId);
    member.cheersCount++;
    notifyListeners();
  }

  void createStudyRoom(StudyRoom room) {
    studyRooms.insert(0, room);
    joinRoom(room);
    notifyListeners();
  }

  // =============================================================
  // حاسبة المعدل التراكمي وتوقع النتيجة (GPA Calculator)
  // =============================================================
  GpaScale currentGpaScale = GpaScale.percentage;

  List<GpaCourse> gpaCourses = [
    GpaCourse(
      id: "c1",
      name: "الرياضيات البحتة والتفاضل",
      creditHours: 3.0,
      score: 94.0,
      letterGrade: "A",
    ),
    GpaCourse(
      id: "c2",
      name: "الفيزياء العامة",
      creditHours: 3.0,
      score: 88.0,
      letterGrade: "B+",
    ),
    GpaCourse(
      id: "c3",
      name: "اللغة العربية والبلاغة",
      creditHours: 2.0,
      score: 96.0,
      letterGrade: "A+",
    ),
    GpaCourse(
      id: "c4",
      name: "اللغة الإنجليزية",
      creditHours: 2.0,
      score: 91.0,
      letterGrade: "A",
    ),
    GpaCourse(
      id: "c5",
      name: "الكيمياء",
      creditHours: 3.0,
      score: 85.0,
      letterGrade: "B",
    ),
  ];

  void setGpaScale(GpaScale scale) {
    currentGpaScale = scale;
    notifyListeners();
  }

  void addGpaCourse(GpaCourse course) {
    gpaCourses.add(course);
    notifyListeners();
  }

  void removeGpaCourse(String id) {
    gpaCourses.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  void updateGpaCourse(GpaCourse course) {
    final index = gpaCourses.indexWhere((c) => c.id == course.id);
    if (index != -1) {
      gpaCourses[index] = course;
      notifyListeners();
    }
  }

  double calculateCurrentGpa() {
    if (gpaCourses.isEmpty) return 0.0;

    if (currentGpaScale == GpaScale.percentage) {
      double totalWeightedScore = 0.0;
      double totalHours = 0.0;
      for (var c in gpaCourses) {
        totalWeightedScore += c.score * c.creditHours;
        totalHours += c.creditHours;
      }
      return totalHours > 0 ? (totalWeightedScore / totalHours) : 0.0;
    } else if (currentGpaScale == GpaScale.scale4) {
      double totalPoints = 0.0;
      double totalHours = 0.0;
      for (var c in gpaCourses) {
        double points = _convertScoreTo4Scale(c.score, c.letterGrade);
        totalPoints += points * c.creditHours;
        totalHours += c.creditHours;
      }
      return totalHours > 0 ? (totalPoints / totalHours) : 0.0;
    } else {
      // 5.0 scale
      double totalPoints = 0.0;
      double totalHours = 0.0;
      for (var c in gpaCourses) {
        double points = _convertScoreTo5Scale(c.score, c.letterGrade);
        totalPoints += points * c.creditHours;
        totalHours += c.creditHours;
      }
      return totalHours > 0 ? (totalPoints / totalHours) : 0.0;
    }
  }

  double _convertScoreTo4Scale(double score, String letter) {
    if (letter == "A+") return 4.0;
    if (letter == "A") return 3.75;
    if (letter == "B+") return 3.3;
    if (letter == "B") return 3.0;
    if (letter == "C+") return 2.5;
    if (letter == "C") return 2.0;
    if (letter == "D") return 1.0;
    // fallback based on numeric score
    if (score >= 95) return 4.0;
    if (score >= 90) return 3.75;
    if (score >= 85) return 3.3;
    if (score >= 80) return 3.0;
    if (score >= 75) return 2.5;
    if (score >= 65) return 2.0;
    if (score >= 50) return 1.0;
    return 0.0;
  }

  double _convertScoreTo5Scale(double score, String letter) {
    if (letter == "A+") return 5.0;
    if (letter == "A") return 4.75;
    if (letter == "B+") return 4.25;
    if (letter == "B") return 3.75;
    if (letter == "C+") return 3.25;
    if (letter == "C") return 2.75;
    if (letter == "D") return 2.0;
    if (score >= 95) return 5.0;
    if (score >= 90) return 4.75;
    if (score >= 85) return 4.25;
    if (score >= 80) return 3.75;
    if (score >= 75) return 3.25;
    if (score >= 65) return 2.75;
    if (score >= 50) return 2.0;
    return 1.0;
  }

  // =============================================================
  // الملاحظات الصوتية والملخصات الذكية (AI Audio Notes)
  // =============================================================
  List<AudioStudyNote> audioNotes = [
    AudioStudyNote(
      id: "aud_1",
      title: "شرح قانون أوم والدوائر الكهربائية المعقدة",
      subject: "الفيزياء",
      durationText: "03:42",
      date: "اليوم 10:15 ص",
      transcript:
          "في الدوائر المتوازية، فرق الجهد متساوي على جميع الفروع ولكن شدة التيار تتوزع عكسياً مع المقاومة. المقاومة المكافئة لمجموعة مقاومات على التوازي تكون دائماً أصغر من أصغر مقاومة في المجموعة. هذا يختلف تماماً عن التوالي حيث تجمع المقاومات.",
      bulletPoints: [
        "فرق الجهد ثابت في جميع فروع التوازي (V = V1 = V2 = V3).",
        "التيار الكلي ينقسم بنسب عكسية مع قيم المقاومات (I = I1 + I2 + ...).",
        "المقاومة المكافئة على التوازي أصغر من أصغر مقاومة متصلة.",
        "توصيل الأجهزة المنزلية يتم دائماً على التوازي لضمان ثبات الجهد.",
      ],
      keyTerms: [
        "قانون أوم (V = I * R)",
        "المقاومة المكافئة (Req)",
        "توصيل التوازي vs التوالي",
      ],
      reviewQuestions: [
        "علل: توصل المصابيح الكهربائية في المنازل على التوازي وليس التوالي؟",
        "ماذا يحدث للمقاومة الكلية عند إضافة مقاومة جديدة على التوازي؟",
      ],
      color: const Color(0xFF0EA5E9),
    ),
    AudioStudyNote(
      id: "aud_2",
      title: "قواعد الاشتقاق والتفاضل الضمني",
      subject: "الرياضيات",
      durationText: "04:18",
      date: "أمس 06:30 م",
      transcript:
          "عندما لا يمكن فصل المتغير y في طرف بمفرده، نستخدم التفاضل الضمني باشتقاق كل حد بالنسبة لـ x مع تذكر ضرب أي حد يحتوي على y في مشتقة y' أو dy/dx. بعد ذلك نجمع حدود dy/dx في طرف واحد ونأخذها عاملاً مشتركاً.",
      bulletPoints: [
        "الاشتقاق الضمني يطبق عندما تكون العلاقة بين x و y متداخلة يصعب فصلها.",
        "كل اشتقاق للمتغير y ينتج عنه ضرب مباشر في dy/dx.",
        "تجميع الحدود التي تحتوي على dy/dx بطرف وباقي الحدود في الطرف الآخر.",
      ],
      keyTerms: [
        "التفاضل الضمني (Implicit Differentiation)",
        "المشتقة الأولى (dy/dx)",
        "معادلة المماس والعمودي",
      ],
      reviewQuestions: [
        "أوجد dy/dx للمعادلة: x^2 + y^2 = 25 عند النقطة (3, 4)؟",
      ],
      color: const Color(0xFF1E5BB8),
    ),
    AudioStudyNote(
      id: "aud_3",
      title: "الممنوع من الصرف لعلة ولعلتين",
      subject: "اللغة العربية",
      durationText: "02:50",
      date: "منذ يومين",
      transcript:
          "الممنوع من الصرف هو الاسم الذي لا ينون ويجر بالفتحة نيابة عن الكسرة إلا إذا عُرّف بأل أو أضيف. يمنع لعلة واحدة إذا كان صيغة منتهى الجموع أو مختوماً بألف التأنيث المقصورة أو الممدودة.",
      bulletPoints: [
        "الممنوع من الصرف لا ينون أبداً.",
        "علامة جره الفتحة نيابة عن الكسرة بشرط تجرده من (أل) والإضافة.",
        "إذا أضيف أو دخلت عليه (أل) جُر بالكسرة الظاهرة على الأصل.",
      ],
      keyTerms: [
        "صيغة منتهى الجموع (مفاعيل ومفاعل)",
        "العلمية ووزن الفعل",
        "علامات الإعراب الفرعية",
      ],
      reviewQuestions: [
        "أعرب كلمة 'مساجد' في: (صليت في مساجدَ أثرية) و (صليت في المساجدِ الأثرية)؟",
      ],
      color: const Color(0xFF10B981),
    ),
  ];

  void addAudioNote(AudioStudyNote note) {
    audioNotes.insert(0, note);
    notifyListeners();
  }

  void toggleAudioPlayback(String id) {
    for (var note in audioNotes) {
      if (note.id == id) {
        note.isPlaying = !note.isPlaying;
      } else {
        note.isPlaying = false;
      }
    }
    notifyListeners();
  }

  void deleteAudioNote(String id) {
    audioNotes.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  // =============================================================
  // تتبع العادات الدراسية والصحية (Habits Tracker)
  // =============================================================
  List<HabitItem> habits = [
    HabitItem(
      id: "h1",
      title: "جلسة المذاكرة الصباحية (التركيز الذهبي)",
      description: "مذاكرة 60 دقيقة في أول اليوم عندما يكون الذهن في أصفى حالاته",
      category: HabitCategory.study,
      icon: Icons.wb_sunny_rounded,
      color: const Color(0xFFF59E0B),
      streakDays: 8,
      isCompletedToday: true,
      weeklyHistory: [true, true, true, true, false, true, true],
    ),
    HabitItem(
      id: "h2",
      title: "حل 30 مسألة أو سؤال تطبيقي",
      description: "التدريب العملي هو مفتاح التثبيت الدائم للمعلومة وتجنب النسيان",
      category: HabitCategory.study,
      icon: Icons.assignment_turned_in_rounded,
      color: const Color(0xFF1E5BB8),
      streakDays: 5,
      isCompletedToday: true,
      weeklyHistory: [true, false, true, true, true, true, false],
    ),
    HabitItem(
      id: "h3",
      title: "شرب 8 أكواب ماء وتجنب الجفاف",
      description: "ترطيب الدماغ يحسن التركيز بنسبة تتجاوز 25% ويمنع الصداع",
      category: HabitCategory.health,
      icon: Icons.water_drop_rounded,
      color: const Color(0xFF0EA5E9),
      streakDays: 12,
      isCompletedToday: false,
      weeklyHistory: [true, true, true, true, true, true, false],
    ),
    HabitItem(
      id: "h4",
      title: "المذاكرة في وضع عدم الإزعاج (قفل المشتتات)",
      description: "إبعاد الهاتف ومنصات التواصل الاجتماعي خلال وقت الجلسة",
      category: HabitCategory.timeManagement,
      icon: Icons.phonelink_erase_rounded,
      color: const Color(0xFFEF4444),
      streakDays: 14,
      isCompletedToday: true,
      weeklyHistory: [true, true, true, true, true, true, true],
    ),
    HabitItem(
      id: "h5",
      title: "تفريغ ذهني وتمرين تنفس لتخفيف القلق",
      description: "5 دقائق للتنفس العميق وتفريغ الشحنات السلبية قبل النوم",
      category: HabitCategory.mindset,
      icon: Icons.spa_rounded,
      color: const Color(0xFF10B981),
      streakDays: 4,
      isCompletedToday: false,
      weeklyHistory: [false, true, true, false, true, true, false],
    ),
  ];

  int get completedTodayHabitsCount => habits.where((h) => h.isCompletedToday).length;

  double get habitsCompletionRate {
    if (habits.isEmpty) return 0.0;
    return completedTodayHabitsCount / habits.length;
  }

  void toggleHabit(String id) {
    final habit = habits.firstWhere((h) => h.id == id);
    habit.isCompletedToday = !habit.isCompletedToday;
    if (habit.isCompletedToday) {
      habit.streakDays++;
      if (habit.weeklyHistory.isNotEmpty) {
        habit.weeklyHistory[habit.weeklyHistory.length - 1] = true;
      }
    } else {
      if (habit.streakDays > 0) habit.streakDays--;
      if (habit.weeklyHistory.isNotEmpty) {
        habit.weeklyHistory[habit.weeklyHistory.length - 1] = false;
      }
    }
    notifyListeners();
  }

  void addHabit(HabitItem habit) {
    habits.add(habit);
    notifyListeners();
  }

  void deleteHabit(String id) {
    habits.removeWhere((h) => h.id == id);
    notifyListeners();
  }

  // =============================================================
  // جمل الدعم النفسي والتحفيز (Psychological Support Notifications)
  // =============================================================
  bool isSupportNotificationsEnabled = true;
  String notificationFrequency = "كل ساعتين";
  SupportMood selectedSupportMood = SupportMood.all;
  int _currentQuoteIndex = 0;

  final List<PsychologicalQuote> psychologicalQuotes = [
    PsychologicalQuote(
      id: "q1",
      message: "تذكّر أن قيمتك كإنسان لا يحددها رقم في ورقة امتحان. أنت تبذل ما في وسعك، وهذا بحد ذاته شجاعة عظيمة تستحق أن تفخر بها 🤍",
      authorOrContext: "دعم الطمأنينة وتقليل القلق",
      mood: SupportMood.examAnxiety,
      icon: Icons.favorite_rounded,
      accentColor: const Color(0xFFEC4899),
    ),
    PsychologicalQuote(
      id: "q2",
      message: "الخطوة الصغيرة التي تخطوها اليوم وأنت متعب، أعظم وأثقل بكثير من قفزة تخطوها وأنت في كامل طاقتك. لا تحقرنّ من إنجازك شيئاً 🌟",
      authorOrContext: "استعادة الشغف والهمّة",
      mood: SupportMood.lowMotivation,
      icon: Icons.auto_awesome_rounded,
      accentColor: const Color(0xFFF59E0B),
    ),
    PsychologicalQuote(
      id: "q3",
      message: "الخوف من الفشل هو مجرد خدعة ينسجها عقلك لحمايتك من المجهول. كل الناجحين مروا بلحظات شك وضياع، السر يكمن في الاستمرار رغم الخوف 🚀",
      authorOrContext: "كسر حاجز الخوف والتردد",
      mood: SupportMood.fearOfFailure,
      icon: Icons.shield_rounded,
      accentColor: const Color(0xFF1E5BB8),
    ),
    PsychologicalQuote(
      id: "q4",
      message: "إذا شعرت بالإجهاد، تعلّم كيف تأخذ استراحة حقيقية دون الشعور بالذنب، لا أن تستسلم. عقلك وجسدك بحاجة للطاقة لكي يبدعا ☕",
      authorOrContext: "الوقاية من الاحتراق النفسي",
      mood: SupportMood.burnout,
      icon: Icons.spa_rounded,
      accentColor: const Color(0xFF10B981),
    ),
    PsychologicalQuote(
      id: "q5",
      message: "ليس المطلوب منك أن تكون مثالياً في كل الأيام؛ يكفيك أن تحضر كل يوم بنسبة 1% أفضل. التراكم الهادئ يصنع المعجزات 🌿",
      authorOrContext: "فلسفة التحسين المستمر",
      mood: SupportMood.all,
      icon: Icons.energy_savings_leaf_rounded,
      accentColor: const Color(0xFF0EA5E9),
    ),
    PsychologicalQuote(
      id: "q6",
      message: "الله لا يضيع أجر من أحسن عملاً. كل سجدة، كل سهر، وكل لحظة قاومت فيها رغبتك بالاستسلام محفوظة ومكتوبة عند رب كريم 🤲",
      authorOrContext: "يقين وتوكل واطمئنان",
      mood: SupportMood.all,
      icon: Icons.volunteer_activism_rounded,
      accentColor: const Color(0xFF8B5CF6),
    ),
  ];

  PsychologicalQuote get currentQuote {
    final list = selectedSupportMood == SupportMood.all
        ? psychologicalQuotes
        : psychologicalQuotes.where((q) => q.mood == selectedSupportMood).toList();
    if (list.isEmpty) return psychologicalQuotes.first;
    return list[_currentQuoteIndex % list.length];
  }

  void nextRandomQuote({SupportMood? mood}) {
    if (mood != null) selectedSupportMood = mood;
    _currentQuoteIndex++;
    notifyListeners();
  }

  void toggleSupportNotifications(bool enabled) {
    isSupportNotificationsEnabled = enabled;
    notifyListeners();
  }

  void setNotificationFrequency(String freq) {
    notificationFrequency = freq;
    notifyListeners();
  }

  void setSupportMood(SupportMood mood) {
    selectedSupportMood = mood;
    _currentQuoteIndex = 0;
    notifyListeners();
  }

  // =============================================================
  // مركز الإشعارات والتنبيهات (Notifications Center)
  // =============================================================
  List<AppNotification> notifications = [
    AppNotification(
      id: "notif_1",
      title: "تذكير بموعد المذاكرة 📚",
      body: "جلسة الرياضيات القادمة (المعادلات والتفاضل والتكامل) تبدأ بعد 15 دقيقة.",
      timeAgo: "منذ 10 دقائق",
      type: NotificationType.study,
      icon: Icons.alarm_on_rounded,
      color: const Color(0xFF2563EB),
      isRead: false,
    ),
    AppNotification(
      id: "notif_2",
      title: "رسالة دعم نفسي لك 💌",
      body: "تذكّر أن قيمتك كإنسان لا يحددها رقم في ورقة امتحان. كل مجهود تبذله اليوم يصنع فارقاً كبيراً غداً.",
      timeAgo: "منذ ساعة",
      type: NotificationType.support,
      icon: Icons.favorite_rounded,
      color: const Color(0xFFEC4899),
      isRead: false,
    ),
    AppNotification(
      id: "notif_3",
      title: "مكافأة نقاط جديدة 🪙",
      body: "حصلت على +50 نقطة مُنجز لإتمامك جلسة بومودورو بتركيز تام بدون مقاطعة!",
      timeAgo: "منذ 3 ساعات",
      type: NotificationType.rewards,
      icon: Icons.stars_rounded,
      color: const Color(0xFFF59E0B),
      isRead: false,
    ),
    AppNotification(
      id: "notif_4",
      title: "شعلة الاستمرارية في خطر 🔥",
      body: "تبقى 3 ساعات لتوثيق عاداتك اليومية والحفاظ على شعلة 7 أيام متتالية!",
      timeAgo: "منذ 5 ساعات",
      type: NotificationType.study,
      icon: Icons.local_fire_department_rounded,
      color: const Color(0xFFEF4444),
      isRead: true,
    ),
    AppNotification(
      id: "notif_5",
      title: "اقتراب موعد اختبار تجريبي 📅",
      body: "متبقي 10 أيام فقط على اختبار الفيزياء الشامل التجريبي. يمكنك البدء بالمراجعة الآن.",
      timeAgo: "أمس",
      type: NotificationType.system,
      icon: Icons.event_note_rounded,
      color: const Color(0xFF10B981),
      isRead: true,
    ),
  ];

  int get unreadNotificationsCount => notifications.where((n) => !n.isRead).length;

  void markAllNotificationsAsRead() {
    for (var n in notifications) {
      n.isRead = true;
    }
    notifyListeners();
  }

  void markNotificationAsRead(String id) {
    final notif = notifications.firstWhere((n) => n.id == id);
    notif.isRead = true;
    notifyListeners();
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n.id == id);
    notifyListeners();
  }

  void clearAllNotifications() {
    notifications.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

