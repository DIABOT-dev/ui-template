import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

// Helper to convert opacity to alpha for BoxDecoration
int alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}



// Dummy Data Models
class JournalEntryData {
  final String title;
  final String content;
  final DateTime date;
  final String time;
  final int totalWords;
  final String mood;
  final String emotion;
  final String timeSpent;
  final int avgWordCount;
  final double trend;

  JournalEntryData({
    required this.title,
    required this.content,
    required this.date,
    required this.time,
    required this.totalWords,
    required this.mood,
    required this.emotion,
    required this.timeSpent,
    required this.avgWordCount,
    required this.trend,
  });
}

class EmotionInsightData {
  final String emotion;
  final int count;
  final Color color;
  final IconData icon;

  EmotionInsightData({
    required this.emotion,
    required this.count,
    required this.color,
    required this.icon,
  });
}

class MoodEntry {
  final DateTime date;
  final String mood;
  final int moodLevel; // 1-5 scale

  MoodEntry({
    required this.date,
    required this.mood,
    required this.moodLevel,
  });
}

class TherapyResource {
  final String title;
  final String description;
  final String duration;
  final IconData icon;
  final Color color;

  TherapyResource({
    required this.title,
    required this.description,
    required this.duration,
    required this.icon,
    required this.color,
  });
}

class TherapyMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  TherapyMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

// Dummy Data
final List<JournalEntryData> dummyJournalEntries = [
  JournalEntryData(
    title: 'Just Got Betrayed By Best Friend',
    content: "You were betrayed by your best friend and now you're feeling depressed. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    date: DateTime(2028, 6, 23),
    time: '00:01 AM',
    totalWords: 257,
    mood: 'Anxious, Reflective',
    emotion: 'Overwhelmed',
    timeSpent: '15 minutes',
    avgWordCount: 160,
    trend: -0.15,
  ),
  JournalEntryData(
    title: 'A Productive Day at Work',
    content: "Today was incredibly productive at work. I managed to finish all my tasks ahead of schedule and even started on a new project. Feeling accomplished and happy. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    date: DateTime(2028, 6, 22),
    time: '08:30 PM',
    totalWords: 310,
    mood: 'Accomplished, Joyful',
    emotion: 'Happy',
    timeSpent: '20 minutes',
    avgWordCount: 180,
    trend: 0.10,
  ),
  JournalEntryData(
    title: 'Quiet Evening Walk',
    content: "Took a peaceful walk in the park tonight. The fresh air and quiet surroundings helped clear my mind. It was a much-needed break from the daily hustle. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
    date: DateTime(2028, 6, 21),
    time: '07:00 PM',
    totalWords: 180,
    mood: 'Calm, Relaxed',
    emotion: 'Peaceful',
    timeSpent: '10 minutes',
    avgWordCount: 100,
    trend: 0.05,
  ),
];

final List<EmotionInsightData> dummyEmotionInsights = [
  EmotionInsightData(emotion: 'Happy', count: 99, color: Colors.green.shade400, icon: FontAwesomeIcons.solidFaceGrin),
  EmotionInsightData(emotion: 'Calm', count: 87, color: Colors.blue.shade300, icon: FontAwesomeIcons.solidFaceMeh),
  EmotionInsightData(emotion: 'Anxious', count: 25, color: Colors.orange.shade300, icon: FontAwesomeIcons.solidFaceFrown),
  EmotionInsightData(emotion: 'Sad', count: 19, color: Colors.red.shade300, icon: FontAwesomeIcons.solidFaceSadTear),
  EmotionInsightData(emotion: 'Energetic', count: 7, color: Colors.purple.shade300, icon: FontAwesomeIcons.solidFaceGrinSquint),
];

final List<MoodEntry> dummyMoodEntries = [
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 6)), mood: 'Happy', moodLevel: 4),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 5)), mood: 'Neutral', moodLevel: 3),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 4)), mood: 'Sad', moodLevel: 2),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 3)), mood: 'Anxious', moodLevel: 2),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 2)), mood: 'Calm', moodLevel: 3),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 1)), mood: 'Happy', moodLevel: 4),
  MoodEntry(date: DateTime.now(), mood: 'Energetic', moodLevel: 5),
];

final List<TherapyResource> dummyTherapyResources = [
  TherapyResource(
    title: 'Guided Meditation',
    description: '10-minute session to reduce anxiety and improve focus',
    duration: '10 min',
    icon: FontAwesomeIcons.headphones,
    color: Colors.purple.shade400,
  ),
  TherapyResource(
    title: 'Breathing Exercises',
    description: 'Quick breathing techniques for instant stress relief',
    duration: '5 min',
    icon: FontAwesomeIcons.wind,
    color: Colors.blue.shade400,
  ),
  TherapyResource(
    title: 'Sleep Stories',
    description: 'Calming stories to help you fall asleep faster',
    duration: '15 min',
    icon: FontAwesomeIcons.moon,
    color: Colors.indigo.shade400,
  ),
  TherapyResource(
    title: 'Cognitive Restructuring',
    description: 'Learn techniques to challenge negative thoughts',
    duration: '20 min',
    icon: FontAwesomeIcons.brain,
    color: Colors.teal.shade400,
  ),
];

final List<TherapyMessage> dummyTherapyMessages = [
  TherapyMessage(
    text: "Hello! I'm your AI therapist. How are you feeling today?",
    isUser: false,
    time: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  TherapyMessage(
    text: "I've been feeling a bit anxious lately. Work has been stressful.",
    isUser: true,
    time: DateTime.now().subtract(const Duration(minutes: 8)),
  ),
  TherapyMessage(
    text: "I understand. Work stress can be overwhelming. Have you tried any relaxation techniques?",
    isUser: false,
    time: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  TherapyMessage(
    text: "I tried deep breathing once, but I'm not sure if I'm doing it right.",
    isUser: true,
    time: DateTime.now().subtract(const Duration(minutes: 2)),
  ),
  TherapyMessage(
    text: "That's a great start! Let me guide you through a simple breathing exercise. Would you like to try?",
    isUser: false,
    time: DateTime.now(),
  ),
];

// JournalsScreen
class JournalsScreen extends StatelessWidget {
  const JournalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: const Text('Mental Wellness'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
              radius: 18,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('257', style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 48, fontWeight: FontWeight.bold)),
                    Text('Total Journals', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.black54)),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildSentimentIndicator(context, 'Total Words', '25.187', Colors.blue.shade100.withValues(alpha: 0.1), FontAwesomeIcons.penToSquare),
                        _buildSentimentIndicator(context, 'Negative', '115', Colors.red.shade100.withValues(alpha: 0.1), FontAwesomeIcons.faceSadTear),
                        _buildSentimentIndicator(context, 'Positive', '99', Colors.green.shade100.withValues(alpha: 0.1), FontAwesomeIcons.faceSmileBeam),
                      ],
                    ),
                    const SizedBox(height: 11),
                  ],
                ),
              ),
              Center(
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddAudioJournalScreen()));
                  },
                  heroTag: 'add_journal_button',
                  child: const Icon(Icons.add, size: 30),
                ),
              ),
              const SizedBox(height: 11),
              JournalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Journal Insight', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 10),
                    Text('Happy', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: Colors.green)),
                    Text('Most frequent emotion', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 15),
                    ...dummyEmotionInsights.map((insight) => _buildEmotionProgress(context, insight)),
                    const SizedBox(height: 10),
                    Text(
                      'You\'ve been reflecting on positive experiences often this month. Keep it up!',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 9),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFeatureCard(
                      context,
                      'Mood Tracker',
                      'Track your daily emotions',
                      FontAwesomeIcons.chartLine,
                      Colors.blue.shade400,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const MoodTrackerScreen())),
                    ),
                    _buildFeatureCard(
                      context,
                      'Therapy Session',
                      'Connect with AI therapist',
                      FontAwesomeIcons.comments,
                      Colors.purple.shade400,
                          () => Navigator.push(context, MaterialPageRoute(builder: (context) => const TherapySessionScreen())),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSentimentIndicator(BuildContext context, String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width / 3.9,
      child: Column(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).primaryColor),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  Widget _buildEmotionProgress(BuildContext context, EmotionInsightData insight) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(insight.emotion, style: Theme.of(context).textTheme.bodyMedium)),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: insight.count / 100,
                backgroundColor: insight.color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(insight.color),
                minHeight: 10,
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(width: 30, child: Text('${insight.count}', style: Theme.of(context).textTheme.bodyMedium)),
          const SizedBox(width: 5),
          Icon(insight.icon, size: 18, color: insight.color),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      String title,
      String subtitle,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width / 2.3,
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 28, color: color),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// JournalCard Widget
class JournalCard extends StatelessWidget {
  final Widget child;

  const JournalCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: child,
      ),
    );
  }
}

// JournalDetailScreen
class JournalDetailScreen extends StatelessWidget {
  final JournalEntryData entry;

  const JournalDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Icon(FontAwesomeIcons.bookOpen, size: 24, color: Colors.black54),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.black54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(FontAwesomeIcons.penToSquare, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 5),
                  Text('${entry.totalWords} Total Words', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 15),
                  Icon(FontAwesomeIcons.calendarDay, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 5),
                  Text('${entry.date.day}/${entry.date.month}/${entry.date.year}', style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(width: 15),
                  Icon(FontAwesomeIcons.clock, size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 5),
                  Text(entry.time, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                entry.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 30),
              JournalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Key Metrics', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 15),
                    _buildMetricRow(context, 'Words Written', '${entry.totalWords} words'),
                    _buildMetricRow(context, 'Mood', entry.mood),
                    _buildMetricRow(context, 'Emotion', entry.emotion),
                    _buildMetricRow(context, 'Time Spent', entry.timeSpent),
                    _buildMetricRow(context, 'Average word count', '${entry.avgWordCount}'),
                    _buildMetricRow(
                      context,
                      'Trend',
                      '${(entry.trend * 100).toStringAsFixed(0)}% vs last month',
                      valueColor: entry.trend < 0 ? Colors.red : Colors.green,
                      valueIcon: entry.trend < 0 ? FontAwesomeIcons.arrowDown : FontAwesomeIcons.arrowUp,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricRow(BuildContext context, String label, String value, {Color? valueColor, IconData? valueIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyLarge),
          Row(
            children: [
              if (valueIcon != null) ...[
                Icon(valueIcon, size: 16, color: valueColor ?? Colors.black54),
                const SizedBox(width: 5),
              ],
              Text(value, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: valueColor ?? Colors.black87)),
            ],
          ),
        ],
      ),
    );
  }
}

// JournalStatsScreen

// AddAudioJournalScreen
class AddAudioJournalScreen extends StatefulWidget {
  const AddAudioJournalScreen({super.key});

  @override
  State<AddAudioJournalScreen> createState() => _AddAudioJournalScreenState();
}

class _AddAudioJournalScreenState extends State<AddAudioJournalScreen> with SingleTickerProviderStateMixin {
  String currentStatus = 'Preparing Voice LLMs...';
  int statusIndex = 0;
  List<String> statuses = [
    'Preparing Voice LLMs...',
    'Transcribing your audio...',
    'Integrating the text editor...',
    'Ready for recording!'
  ];
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startStatusSequence();
  }

  void _startStatusSequence() async {
    for (int i = 0; i < statuses.length; i++) {
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) return;
      setState(() {
        currentStatus = statuses[i];
        statusIndex = i;
      });
      if (i == statuses.length - 1) {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Audio Journal', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(FontAwesomeIcons.xmark, color: Colors.black54),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentStatus,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                if (statusIndex < statuses.length - 1)
                  FadeTransition(
                    opacity: _animation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) => _buildDot(context, index)),
                    ),
                  )
                else
                  Column(
                    children: [
                      FloatingActionButton.large(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Recording audio... (dummy action)')),
                          );
                        },
                        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
                        child: const Icon(FontAwesomeIcons.microphone, size: 40),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Tap to start recording',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                const SizedBox(height: 15),
                if (statusIndex == statuses.length - 1)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => JournalDetailScreen(entry: dummyJournalEntries[0])));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(FontAwesomeIcons.bookOpenReader, color: Theme.of(context).primaryColor),
                          const SizedBox(width: 10),
                          Text(
                            'View an example journal entry',
                            style: Theme.of(context).textTheme.labelLarge,
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
    );
  }

  Widget _buildDot(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}

// MoodTrackerScreen
class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  int selectedMoodLevel = 3;
  String selectedMood = 'Neutral';

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Mood Tracker', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.calendarDays),
            onPressed: () {
              // Show calendar view
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How are you feeling today?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _scaleAnimation,
                child: JournalCard(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMoodEmoji(1, 'Very Sad', FontAwesomeIcons.solidFaceSadTear, Colors.red.shade400),
                            _buildMoodEmoji(2, 'Sad', FontAwesomeIcons.solidFaceFrown, Colors.orange.shade400),
                            _buildMoodEmoji(3, 'Neutral', FontAwesomeIcons.solidFaceMeh, Colors.grey.shade400),
                            _buildMoodEmoji(4, 'Happy', FontAwesomeIcons.solidFaceSmile, Colors.lightGreen.shade400),
                            _buildMoodEmoji(5, 'Very Happy', FontAwesomeIcons.solidFaceGrin, Colors.green.shade400),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        selectedMood,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getMoodColor(selectedMoodLevel),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Save mood entry
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Mood recorded: $selectedMood'),
                              backgroundColor: _getMoodColor(selectedMoodLevel),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getMoodColor(selectedMoodLevel),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Save Mood'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Your Mood This Week',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              JournalCard(
                child: SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withValues(alpha: 0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              final day = DateTime.now().subtract(Duration(days: 6 - value.toInt()));
                              return Text(
                                DateFormat.E().format(day),
                                style: Theme.of(context).textTheme.bodySmall,
                              );
                            },
                            interval: 1,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value == 1 || value == 3 || value == 5) {
                                return Text(
                                  value.toInt().toString(),
                                  style: Theme.of(context).textTheme.bodySmall,
                                );
                              }
                              return const SizedBox();
                            },
                            reservedSize: 28,
                          ),
                        ),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      minX: 0,
                      maxX: 6,
                      minY: 0,
                      maxY: 6,
                      lineBarsData: [
                        LineChartBarData(
                          spots: dummyMoodEntries.asMap().entries.map((entry) {
                            final index = entry.key;
                            final moodEntry = entry.value;
                            return FlSpot(index.toDouble(), moodEntry.moodLevel.toDouble());
                          }).toList(),
                          isCurved: true,
                          color: Colors.deepPurple,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                radius: 5,
                                color: Colors.white,
                                strokeWidth: 2,
                                strokeColor: Colors.deepPurple,
                              );
                            },
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.deepPurple.withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              JournalCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mood Insights',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Your mood has been improving over the past week. You had 3 good days and 2 neutral days.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Try to maintain positive activities that boost your mood on good days.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodEmoji(int level, String label, IconData icon, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMoodLevel = level;
          selectedMood = label;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selectedMoodLevel == level
              ? color.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: selectedMoodLevel == level
                ? color
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: selectedMoodLevel == level
                    ? color
                    : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMoodColor(int level) {
    switch (level) {
      case 1:
        return Colors.red.shade400;
      case 2:
        return Colors.orange.shade400;
      case 3:
        return Colors.grey.shade400;
      case 4:
        return Colors.lightGreen.shade400;
      case 5:
        return Colors.green.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}



// Dummy data (assuming these exist in your code)



class TherapySessionScreen extends StatefulWidget {
  const TherapySessionScreen({super.key});

  @override
  State<TherapySessionScreen> createState() => _TherapySessionScreenState();
}

class _TherapySessionScreenState extends State<TherapySessionScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<TherapyMessage> messages = List.from(dummyTherapyMessages);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();

    // Scroll to bottom after initial render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        TherapyMessage(
          text: _messageController.text,
          isUser: true,
          time: DateTime.now(),
        ),
      );
      _messageController.clear();
    });

    // Scroll to bottom after adding new message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });

    // Simulate AI response after delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          messages.add(
            TherapyMessage(
              text: "Thank you for sharing. How does that make you feel?",
              isUser: false,
              time: DateTime.now(),
            ),
          );
        });

        // Scroll to bottom after AI response
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToBottom();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Therapy Session', style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circleInfo),
            onPressed: () {
              // Show info about therapy session
            },
          ),
        ],
      ),
      body: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(_slideAnimation),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
            _buildMessageInput(),
            const SizedBox(height: 5), // Reduced from 10
            Flexible(
              child: _buildTherapyResources(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(TherapyMessage message) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isUser) ...[
            CircleAvatar(
              backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/women/32.jpg'),
              radius: 16,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isUser
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: message.isUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: message.isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: message.isUser ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat.Hm().format(message.time),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: message.isUser
                          ? Colors.white.withValues(alpha: 0.7)
                          : Colors.grey.shade500,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (message.isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: const NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
              radius: 16,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                hintStyle: TextStyle(color: Colors.grey.shade400),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              textCapitalization: TextCapitalization.sentences,
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            onPressed: _sendMessage,
            mini: true,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  Widget _buildTherapyResources() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recommended Resources',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 110, // Fixed height for horizontal ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dummyTherapyResources.length,
              itemBuilder: (context, index) {
                final resource = dummyTherapyResources[index];
                return _buildResourceCard(resource);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(TherapyResource resource) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening ${resource.title}...'),
            backgroundColor: resource.color,
          ),
        );
      },
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
          border: Border.all(color: resource.color.withValues(alpha: 0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(resource.icon, size: 16, color: resource.color), // Reduced size
                const SizedBox(width: 4),
                Text(
                  resource.duration,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              resource.title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              resource.description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}