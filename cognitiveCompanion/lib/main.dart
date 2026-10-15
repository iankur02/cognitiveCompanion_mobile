// main.dart - Cognitive Companion App
// No web-renderer issues - Pure mobile app

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CognitiveCompanionApp());
}

class CognitiveCompanionApp extends StatefulWidget {
  const CognitiveCompanionApp({Key? key}) : super(key: key);

  @override
  State<CognitiveCompanionApp> createState() => _CognitiveCompanionAppState();
}

class _CognitiveCompanionAppState extends State<CognitiveCompanionApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cognitive Companion',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 18),
          bodyMedium: TextStyle(fontSize: 16),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ),
      home: SplashScreen(onLocaleChange: setLocale),
    );
  }
}

// Translations
class AppTranslations {
  static const Map<String, Map<String, String>> translations = {
    'en': {
      'appName': 'Cognitive Companion',
      'welcome': 'Welcome',
      'login': 'Login',
      'signup': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'name': 'Name',
      'role': 'Role',
      'senior': 'Senior',
      'caregiver': 'Caregiver',
      'dashboard': 'Dashboard',
      'games': 'Brain Games',
      'progress': 'Progress',
      'settings': 'Settings',
      'logout': 'Logout',
      'playGame': 'Play Game',
      'score': 'Score',
      'level': 'Level',
      'memoryMatch': 'Memory Match',
      'sequenceRecall': 'Sequence Recall',
      'arithmetic': 'Simple Math',
      'spotDifference': 'Spot the Odd',
      'todayProgress': "Today's Progress",
      'weeklyStats': 'Weekly Statistics',
      'avgScore': 'Average Score',
      'gamesPlayed': 'Games Played',
      'streak': 'Day Streak',
      'changeLanguage': 'Change Language',
      'notifications': 'Enable Reminders',
    },
    'hi': {
      'appName': 'संज्ञानात्मक साथी',
      'welcome': 'स्वागत है',
      'login': 'लॉगिन',
      'signup': 'साइन अप',
      'email': 'ईमेल',
      'password': 'पासवर्ड',
      'name': 'नाम',
      'role': 'भूमिका',
      'senior': 'वरिष्ठ',
      'caregiver': 'देखभालकर्ता',
      'dashboard': 'डैशबोर्ड',
      'games': 'मस्तिष्क खेल',
      'progress': 'प्रगति',
      'settings': 'सेटिंग्स',
      'logout': 'लॉगआउट',
      'playGame': 'खेल खेलें',
      'score': 'अंक',
      'level': 'स्तर',
      'memoryMatch': 'याददाश्त मैच',
      'sequenceRecall': 'क्रम याद',
      'arithmetic': 'साधारण गणित',
      'spotDifference': 'विषम खोजें',
      'todayProgress': 'आज की प्रगति',
      'weeklyStats': 'साप्ताहिक आंकड़े',
      'avgScore': 'औसत स्कोर',
      'gamesPlayed': 'खेल खेले',
      'streak': 'दिन की लकीर',
      'changeLanguage': 'भाषा बदलें',
      'notifications': 'रिमाइंडर सक्षम करें',
    },
    'mr': {
      'appName': 'संज्ञानात्मक साथी',
      'welcome': 'स्वागत',
      'login': 'लॉगिन',
      'signup': 'साइन अप',
      'email': 'ईमेल',
      'password': 'पासवर्ड',
      'name': 'नाव',
      'role': 'भूमिका',
      'senior': 'ज्येष्ठ',
      'caregiver': 'काळजीवाहक',
      'dashboard': 'डॅशबोर्ड',
      'games': 'मेंदू खेळ',
      'progress': 'प्रगती',
      'settings': 'सेटिंग्ज',
      'logout': 'बाहेर पडा',
      'playGame': 'खेळ खेळा',
      'score': 'गुण',
      'level': 'पातळी',
      'memoryMatch': 'स्मृती जुळणी',
      'sequenceRecall': 'क्रम आठवणे',
      'arithmetic': 'साधे गणित',
      'spotDifference': 'विषम शोधा',
      'todayProgress': 'आजची प्रगती',
      'weeklyStats': 'साप्ताहिक आकडेवारी',
      'avgScore': 'सरासरी गुण',
      'gamesPlayed': 'खेळ खेळले',
      'streak': 'दिवस सातत्य',
      'changeLanguage': 'भाषा बदला',
      'notifications': 'स्मरणपत्रे सक्षम करा',
    },
  };

  static String translate(String key, String langCode) {
    return translations[langCode]?[key] ?? translations['en']![key] ?? key;
  }
}

// Data Models
class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? caregiverId;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.caregiverId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'caregiverId': caregiverId,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        caregiverId: json['caregiverId'] as String?,
      );
}

class GameScore {
  final String gameType;
  final int score;
  final DateTime date;
  final int level;

  GameScore({
    required this.gameType,
    required this.score,
    required this.date,
    required this.level,
  });

  Map<String, dynamic> toJson() => {
        'gameType': gameType,
        'score': score,
        'date': date.toIso8601String(),
        'level': level,
      };

  factory GameScore.fromJson(Map<String, dynamic> json) => GameScore(
        gameType: json['gameType'] as String,
        score: json['score'] as int,
        date: DateTime.parse(json['date'] as String),
        level: json['level'] as int,
      );
}

// Storage Service
class StorageService {
  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString('user');
    if (userStr != null) {
      return User.fromJson(jsonDecode(userStr) as Map<String, dynamic>);
    }
    return null;
  }

  static Future<void> saveScore(GameScore score) async {
    final prefs = await SharedPreferences.getInstance();
    final scoresStr = prefs.getString('scores') ?? '[]';
    final scoresList = jsonDecode(scoresStr) as List;
    final scores = scoresList
        .map((e) => GameScore.fromJson(e as Map<String, dynamic>))
        .toList();
    scores.add(score);
    await prefs.setString(
        'scores', jsonEncode(scores.map((e) => e.toJson()).toList()));
  }

  static Future<List<GameScore>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    final scoresStr = prefs.getString('scores') ?? '[]';
    final scoresList = jsonDecode(scoresStr) as List;
    return scoresList
        .map((e) => GameScore.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  static Future<void> saveLanguage(String langCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('language') ?? 'en';
  }
}

// Splash Screen
class SplashScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const SplashScreen({Key? key, required this.onLocaleChange})
      : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final langCode = await StorageService.getLanguage();
    widget.onLocaleChange(Locale(langCode));

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    final user = await StorageService.getUser();
    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              MainScreen(user: user, onLocaleChange: widget.onLocaleChange),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LoginScreen(onLocaleChange: widget.onLocaleChange),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple.shade700, Colors.blue.shade500],
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.psychology, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Cognitive Companion',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

// Login Screen
class LoginScreen extends StatefulWidget {
  final Function(Locale) onLocaleChange;

  const LoginScreen({Key? key, required this.onLocaleChange}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  String _selectedRole = 'senior';
  String _langCode = 'en';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String t(String key) => AppTranslations.translate(key, _langCode);

  void _login() async {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text,
      email: _emailController.text,
      role: _selectedRole,
    );

    await StorageService.saveUser(user);
    await StorageService.saveLanguage(_langCode);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MainScreen(user: user, onLocaleChange: widget.onLocaleChange),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.psychology, size: 80, color: Colors.purple),
                  const SizedBox(height: 16),
                  Text(
                    t('appName'),
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    t('welcome'),
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 40),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: t('name'),
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: t('email'),
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          DropdownButtonFormField<String>(
                            value: _selectedRole,
                            decoration: InputDecoration(
                              labelText: t('role'),
                              prefixIcon: const Icon(Icons.badge),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            items: [
                              DropdownMenuItem(
                                  value: 'senior', child: Text(t('senior'))),
                              DropdownMenuItem(
                                  value: 'caregiver',
                                  child: Text(t('caregiver'))),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _selectedRole = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Language: ',
                                  style: TextStyle(fontSize: 16)),
                              ChoiceChip(
                                label: const Text('EN'),
                                selected: _langCode == 'en',
                                onSelected: (selected) {
                                  setState(() {
                                    _langCode = 'en';
                                    widget.onLocaleChange(const Locale('en'));
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: const Text('हिं'),
                                selected: _langCode == 'hi',
                                onSelected: (selected) {
                                  setState(() {
                                    _langCode = 'hi';
                                    widget.onLocaleChange(const Locale('hi'));
                                  });
                                },
                              ),
                              const SizedBox(width: 8),
                              ChoiceChip(
                                label: const Text('मर'),
                                selected: _langCode == 'mr',
                                onSelected: (selected) {
                                  setState(() {
                                    _langCode = 'mr';
                                    widget.onLocaleChange(const Locale('mr'));
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(t('login')),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Main Screen with Bottom Navigation
class MainScreen extends StatefulWidget {
  final User user;
  final Function(Locale) onLocaleChange;

  const MainScreen({Key? key, required this.user, required this.onLocaleChange})
      : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(user: widget.user),
      GamesListScreen(user: widget.user),
      ProgressScreen(user: widget.user),
      SettingsScreen(user: widget.user, onLocaleChange: widget.onLocaleChange),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.games), label: 'Games'),
          BottomNavigationBarItem(
              icon: Icon(Icons.trending_up), label: 'Progress'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

// Dashboard Screen
class DashboardScreen extends StatefulWidget {
  final User user;

  const DashboardScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<GameScore> _scores = [];
  String _langCode = 'en';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final scores = await StorageService.getScores();
    final langCode = await StorageService.getLanguage();
    if (mounted) {
      setState(() {
        _scores = scores;
        _langCode = langCode;
      });
    }
  }

  String t(String key) => AppTranslations.translate(key, _langCode);

  int _calculateStreak() {
    if (_scores.isEmpty) return 0;

    int streak = 0;
    DateTime checkDate = DateTime.now();

    for (int i = 0; i < 30; i++) {
      bool hasScore = _scores.any((s) =>
          s.date.day == checkDate.day &&
          s.date.month == checkDate.month &&
          s.date.year == checkDate.year);

      if (hasScore) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }

    return streak;
  }

  @override
  Widget build(BuildContext context) {
    final todayScores = _scores
        .where((s) =>
            s.date.day == DateTime.now().day &&
            s.date.month == DateTime.now().month &&
            s.date.year == DateTime.now().year)
        .toList();

    final avgScore = _scores.isEmpty
        ? 0.0
        : _scores.map((s) => s.score).reduce((a, b) => a + b) / _scores.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(t('dashboard')),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.purple.shade50],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${t('welcome')}, ${widget.user.name}!',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      DateTime.now().toString().split(' ')[0],
                      style:
                          const TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t('todayProgress'),
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.gamepad,
                              title: t('gamesPlayed'),
                              value: todayScores.length.toString(),
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildStatCard(
                              icon: Icons.star,
                              title: t('avgScore'),
                              value: avgScore.toStringAsFixed(0),
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        icon: Icons.local_fire_department,
                        title: t('streak'),
                        value: '${_calculateStreak()} days',
                        color: Colors.red,
                        wide: true,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Recent Games',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 16),
                      if (_scores.isEmpty)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Text(
                              'No games played yet. Start playing!',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        )
                      else
                        ..._scores
                            .take(5)
                            .map((score) => _buildRecentGameCard(score)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    bool wide = false,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              wide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
              textAlign: wide ? TextAlign.left : TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentGameCard(GameScore score) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple.shade100,
          child: const Icon(Icons.games, color: Colors.purple),
        ),
        title: Text(score.gameType),
        subtitle: Text('Level ${score.level}'),
        trailing: Text(
          '${score.score}',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ),
    );
  }
}

// Games List Screen
class GamesListScreen extends StatelessWidget {
  final User user;

  const GamesListScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'name': 'Memory Match',
        'icon': Icons.grid_view,
        'color': Colors.blue,
        'screen': MemoryMatchGame(user: user),
      },
      {
        'name': 'Sequence Recall',
        'icon': Icons.format_list_numbered,
        'color': Colors.green,
        'screen': SequenceRecallGame(user: user),
      },
      {
        'name': 'Simple Math',
        'icon': Icons.calculate,
        'color': Colors.orange,
        'screen': ArithmeticGame(user: user),
      },
      {
        'name': 'Spot the Odd',
        'icon': Icons.compare,
        'color': Colors.red,
        'screen': SpotDifferenceGame(user: user),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Brain Games'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => game['screen'] as Widget),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        (game['color'] as Color).withOpacity(0.7),
                        (game['color'] as Color),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        game['icon'] as IconData,
                        size: 60,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        game['name'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Memory Match Game
class MemoryMatchGame extends StatefulWidget {
  final User user;

  const MemoryMatchGame({Key? key, required this.user}) : super(key: key);

  @override
  State<MemoryMatchGame> createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  final List<String> symbols = ['🌟', '🎨', '🎵', '🌺', '🦋', '🌈', '🎭', '🎪'];
  List<Map<String, dynamic>> cards = [];
  List<int> flipped = [];
  List<int> matched = [];
  int moves = 0;
  int score = 100;
  int level = 1;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    cards = [];
    for (var symbol in symbols) {
      cards.add({'symbol': symbol, 'id': cards.length});
      cards.add({'symbol': symbol, 'id': cards.length});
    }
    cards.shuffle();
  }

  void _handleCardTap(int index) {
    if (flipped.length == 2 ||
        flipped.contains(index) ||
        matched.contains(index)) return;

    setState(() {
      flipped.add(index);
    });

    if (flipped.length == 2) {
      moves++;
      if (cards[flipped[0]]['symbol'] == cards[flipped[1]]['symbol']) {
        setState(() {
          matched.addAll(flipped);
          flipped = [];
        });

        if (matched.length == cards.length) {
          _gameComplete();
        }
      } else {
        score = (score - 2).clamp(0, 100).toInt();
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              flipped = [];
            });
          }
        });
      }
    }
  }

  void _gameComplete() async {
    final finalScore = (score - moves).clamp(50, 100).toInt();
    await StorageService.saveScore(GameScore(
      gameType: 'Memory Match',
      score: finalScore,
      date: DateTime.now(),
      level: level,
    ));

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations! 🎉'),
        content: Text(
            'You completed the game!\n\nScore: $finalScore\nMoves: $moves'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                flipped = [];
                matched = [];
                moves = 0;
                score = 100;
                _initializeGame();
              });
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        backgroundColor: Colors.blue,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  Text('Score: $score', style: const TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Moves: $moves', style: const TextStyle(fontSize: 18)),
                Text(
                  'Matched: ${matched.length ~/ 2}/${cards.length ~/ 2}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final isFlipped =
                      flipped.contains(index) || matched.contains(index);
                  return GestureDetector(
                    onTap: () => _handleCardTap(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isFlipped
                            ? Colors.blue.shade300
                            : Colors.blue.shade700,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          isFlipped ? cards[index]['symbol'] as String : '?',
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sequence Recall Game
class SequenceRecallGame extends StatefulWidget {
  final User user;

  const SequenceRecallGame({Key? key, required this.user}) : super(key: key);

  @override
  State<SequenceRecallGame> createState() => _SequenceRecallGameState();
}

class _SequenceRecallGameState extends State<SequenceRecallGame> {
  List<int> sequence = [];
  List<int> userSequence = [];
  int level = 1;
  int score = 0;
  bool showingSequence = false;
  bool gameStarted = false;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    setState(() {
      gameStarted = true;
    });
    _generateSequence();
  }

  void _generateSequence() {
    setState(() {
      sequence = List.generate(level + 2, (_) => Random().nextInt(4));
      userSequence = [];
      showingSequence = true;
    });

    Future.delayed(Duration(seconds: (level + 2) * 1), () {
      if (mounted) {
        setState(() {
          showingSequence = false;
        });
      }
    });
  }

  void _handleButtonPress(int num) {
    if (showingSequence) return;

    setState(() {
      userSequence.add(num);
    });

    if (userSequence.length == sequence.length) {
      if (_checkSequence()) {
        setState(() {
          score += level * 10;
          level++;
        });
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            _generateSequence();
          }
        });
      } else {
        _gameOver();
      }
    }
  }

  bool _checkSequence() {
    for (int i = 0; i < userSequence.length; i++) {
      if (userSequence[i] != sequence[i]) return false;
    }
    return true;
  }

  void _gameOver() async {
    await StorageService.saveScore(GameScore(
      gameType: 'Sequence Recall',
      score: score,
      date: DateTime.now(),
      level: level,
    ));

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Final Score: $score\nLevel Reached: $level'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                sequence = [];
                userSequence = [];
                level = 1;
                score = 0;
                _startGame();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sequence Recall'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Level: $level',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Score: $score',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            if (showingSequence)
              const Text(
                'Watch the pattern...',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )
            else
              const Text(
                'Repeat the pattern!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final isHighlighted = showingSequence &&
                      userSequence.length < sequence.length &&
                      sequence[userSequence.length] == index;

                  return GestureDetector(
                    onTap: () => _handleButtonPress(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index]
                            .withOpacity(isHighlighted ? 1.0 : 0.6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color:
                              isHighlighted ? Colors.white : Colors.transparent,
                          width: 4,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Arithmetic Game
// Arithmetic Game
class ArithmeticGame extends StatefulWidget {
  final User user;

  const ArithmeticGame({Key? key, required this.user}) : super(key: key);

  @override
  State<ArithmeticGame> createState() => _ArithmeticGameState();
}

class _ArithmeticGameState extends State<ArithmeticGame> {
  int num1 = 0;
  int num2 = 0;
  String operator = '+';
  int correctAnswer = 0;
  List<int> options = [];
  int score = 0;
  int questionCount = 0;
  int timeLeft = 60;
  Timer? _timer;
  bool _gameEnded = false; // ← guards against post-game taps / double dialog

  @override
  void initState() {
    super.initState();
    _generateQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _gameEnded) return;
      if (timeLeft > 1) {
        setState(() => timeLeft--);
      } else {
        timer.cancel();
        setState(() => timeLeft = 0);
        _gameOver();
      }
    });
  }

  void _generateQuestion() {
    if (_gameEnded) return;

    final random = Random();

    // 1. Pick operands 1..20
    int a = random.nextInt(20) + 1;
    int b = random.nextInt(20) + 1;

    // 2. Pick operator; if '-', guarantee a >= b so result is non-negative
    final String op = random.nextBool() ? '+' : '-';
    if (op == '-' && a < b) {
      final t = a;
      a = b;
      b = t;
    }

    final int answer = op == '+' ? a + b : a - b;

    // 3. Build 4 unique, non-negative options with a HARD cap on iterations
    final Set<int> optSet = {answer};
    int attempts = 0;
    while (optSet.length < 4 && attempts < 100) {
      // ← safety cap
      final int offset = random.nextInt(11) - 5; // -5 .. +5
      if (offset != 0) {
        final int cand = answer + offset;
        if (cand >= 0 && cand <= 99) optSet.add(cand);
      }
      attempts++;
    }
    // 4. Fallback — guarantees we always end up with exactly 4 options
    int filler = 1;
    while (optSet.length < 4) {
      optSet.add(answer + filler);
      filler++;
    }

    final opts = optSet.toList()..shuffle();

    setState(() {
      num1 = a;
      num2 = b;
      operator = op;
      correctAnswer = answer;
      options = opts;
    });
  }

  void _checkAnswer(int answer) {
    if (_gameEnded) return; // ignore taps after time's up
    if (answer == correctAnswer) {
      setState(() {
        score += 10;
        questionCount++;
      });
    }
    _generateQuestion();
  }

  void _gameOver() async {
    if (_gameEnded) return; // prevent double-call from timer
    _gameEnded = true;
    _timer?.cancel();

    await StorageService.saveScore(GameScore(
      gameType: 'Simple Math',
      score: score,
      date: DateTime.now(),
      level: questionCount,
    ));

    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Time's Up!"),
        content:
            Text('Final Score: $score\nQuestions Answered: $questionCount'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // leave game screen
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Math'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Score: $score',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  'Time: ${timeLeft}s',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: timeLeft < 10 ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Text(
              '$num1 $operator $num2 = ?',
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () => _checkAnswer(options[index]),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade100,
                    foregroundColor: Colors.orange.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    '${options[index]}',
                    style: const TextStyle(
                        fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Spot Difference Game
class SpotDifferenceGame extends StatefulWidget {
  final User user;

  const SpotDifferenceGame({Key? key, required this.user}) : super(key: key);

  @override
  State<SpotDifferenceGame> createState() => _SpotDifferenceGameState();
}

class _SpotDifferenceGameState extends State<SpotDifferenceGame> {
  final List<String> emojis = ['😀', '😎', '🤖', '🎃', '🌟', '🎨', '🎵', '🍕'];
  String oddOne = '';
  List<String> displayEmojis = [];
  int score = 0;
  int level = 1;

  @override
  void initState() {
    super.initState();
    _generateQuestion();
  }

  void _generateQuestion() {
    final random = Random();
    final normalEmoji = emojis[random.nextInt(emojis.length)];
    oddOne = emojis.firstWhere((e) => e != normalEmoji);

    setState(() {
      displayEmojis = List.filled(8, normalEmoji);
      displayEmojis[random.nextInt(8)] = oddOne;
    });
  }

  void _checkAnswer(int index) {
    if (displayEmojis[index] == oddOne) {
      setState(() {
        score += level * 10;
        level++;
      });
      _generateQuestion();
    } else {
      _gameOver();
    }
  }

  void _gameOver() async {
    await StorageService.saveScore(GameScore(
      gameType: 'Spot the Odd',
      score: score,
      date: DateTime.now(),
      level: level,
    ));

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over'),
        content: Text('Final Score: $score\nLevel: $level'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                score = 0;
                level = 1;
                _generateQuestion();
              });
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spot the Odd'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Level: $level',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
                Text('Score: $score',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Find the different one!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _checkAnswer(index),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          displayEmojis[index],
                          style: const TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Progress Screen
class ProgressScreen extends StatefulWidget {
  final User user;

  const ProgressScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<GameScore> _scores = [];
  String _langCode = 'en';

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final scores = await StorageService.getScores();
    final langCode = await StorageService.getLanguage();
    if (mounted) {
      setState(() {
        _scores = scores..sort((a, b) => b.date.compareTo(a.date));
        _langCode = langCode;
      });
    }
  }

  String t(String key) => AppTranslations.translate(key, _langCode);

  @override
  Widget build(BuildContext context) {
    final weekScores = _scores
        .where((s) => DateTime.now().difference(s.date).inDays < 7)
        .toList();

    final avgScore = _scores.isEmpty
        ? 0.0
        : _scores.map((s) => s.score).reduce((a, b) => a + b) / _scores.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(t('progress')),
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t('weeklyStats'),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatColumn(
                        t('gamesPlayed'),
                        weekScores.length.toString(),
                        Icons.games,
                        Colors.blue,
                      ),
                      _buildStatColumn(
                        t('avgScore'),
                        avgScore.toStringAsFixed(0),
                        Icons.star,
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Game Performance',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              ...[
                'Memory Match',
                'Sequence Recall',
                'Simple Math',
                'Spot the Odd'
              ].map((game) => _buildGamePerformanceCard(game)),
              const SizedBox(height: 24),
              Text(
                'Recent Activity',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 16),
              if (_scores.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Text(
                      'No game history yet. Start playing to see your progress!',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ..._scores.take(10).map((score) => _buildScoreCard(score)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 40, color: color),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
              fontSize: 32, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }

  Widget _buildGamePerformanceCard(String gameName) {
    final gameScores = _scores.where((s) => s.gameType == gameName).toList();
    final avgScore = gameScores.isEmpty
        ? 0.0
        : gameScores.map((s) => s.score).reduce((a, b) => a + b) /
            gameScores.length;
    final maxScore = gameScores.isEmpty
        ? 0
        : gameScores.map((s) => s.score).reduce((a, b) => a > b ? a : b);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.purple.shade100,
          child: const Icon(Icons.gamepad, color: Colors.purple),
        ),
        title:
            Text(gameName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Played: ${gameScores.length} times'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Avg: ${avgScore.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Best: $maxScore', style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(GameScore score) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(Icons.gamepad, color: Colors.purple),
        title: Text(score.gameType),
        subtitle: Text(
            '${score.date.toString().split(' ')[0]} • Level ${score.level}'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${score.score}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
        ),
      ),
    );
  }
}

// Settings Screen
class SettingsScreen extends StatefulWidget {
  final User user;
  final Function(Locale) onLocaleChange;

  const SettingsScreen(
      {Key? key, required this.user, required this.onLocaleChange})
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _langCode = 'en';
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final langCode = await StorageService.getLanguage();
    if (mounted) {
      setState(() {
        _langCode = langCode;
      });
    }
  }

  String t(String key) => AppTranslations.translate(key, _langCode);

  void _changeLanguage(String langCode) async {
    await StorageService.saveLanguage(langCode);
    setState(() {
      _langCode = langCode;
    });
    widget.onLocaleChange(Locale(langCode));
  }

  void _logout() async {
    await StorageService.clearUser();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LoginScreen(onLocaleChange: widget.onLocaleChange),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t('settings')),
        backgroundColor: Colors.purple,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple,
                    child: Text(
                      widget.user.name[0].toUpperCase(),
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.user.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        Text(
                          widget.user.role == 'senior'
                              ? t('senior')
                              : t('caregiver'),
                          style: const TextStyle(color: Colors.purple),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            t('changeLanguage'),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              ChoiceChip(
                label: const Text('English'),
                selected: _langCode == 'en',
                onSelected: (selected) => _changeLanguage('en'),
              ),
              ChoiceChip(
                label: const Text('हिंदी'),
                selected: _langCode == 'hi',
                onSelected: (selected) => _changeLanguage('hi'),
              ),
              ChoiceChip(
                label: const Text('मराठी'),
                selected: _langCode == 'mr',
                onSelected: (selected) => _changeLanguage('mr'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            title: Text(t('notifications')),
            subtitle: const Text('Get daily reminders to play'),
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: Text(t('logout')),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
