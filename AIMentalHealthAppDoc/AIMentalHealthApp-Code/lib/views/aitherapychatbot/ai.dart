import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

// --- Global Constants and Helper Functions ---

// Helper function to convert opacity to alpha value for colors
int alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}

// Custom Colors based on the design
class AppColors {
  static const Color primaryOrange = Color(0xFFF09A34);
  static const Color primaryGreen = Color(0xFF5CB85C);
  static const Color darkGreen = Color(0xFF386641);
  static const Color cardBackground = Colors.white;
  static const Color lightGrey = Color(0xFFF5F5F5);
  static const Color greyText = Color(0xFF6C757D);
  static const Color userChatBubble = Color(0xFFDCDCDC);
  static const Color moodSad = Color(0xFF6C757D);
  static const Color moodNeutral = Color(0xFF3498DB);
  static const Color moodHappy = Color(0xFF2ECC71);
  static const Color moodExcited = Color(0xFFF39C12);
  static const Color moodAngry = Color(0xFFE74C3C);
}

// Dummy Data Structures
enum ConversationType {
  therapy,
  wellness,
  copingSkills,
  sleep,
  relationships,
  fitness,
}

class AiChat {
  final String id;
  final String title;
  final String lastMessage;
  final String time;
  final Color color;
  final IconData icon;
  final ConversationType type;

  AiChat({
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.time,
    required this.color,
    required this.icon,
    required this.type,
  });
}

class Message {
  final String text;
  final bool isUser;
  final String? time;
  final bool isSuggestion;
  final String? citation;

  Message({
    required this.text,
    required this.isUser,
    this.time,
    this.isSuggestion = false,
    this.citation,
  });
}

// Mood tracking data
class MoodEntry {
  final DateTime date;
  final int moodLevel; // 1-5
  final String note;
  final List<String> tags;

  MoodEntry({
    required this.date,
    required this.moodLevel,
    required this.note,
    required this.tags,
  });
}

// Meditation session data
class MeditationSession {
  final String id;
  final String title;
  final String description;
  final String duration;
  final IconData icon;
  final Color color;
  final bool isCompleted;

  MeditationSession({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.icon,
    required this.color,
    this.isCompleted = false,
  });
}

final List<AiChat> dummyChats = [
  AiChat(
    id: 'c1',
    title: 'SuperDoctor AI',
    lastMessage: 'Let\'s talk about your goals for the week.',
    time: '2m ago',
    color: AppColors.primaryOrange,
    icon: FontAwesomeIcons.bolt,
    type: ConversationType.therapy,
  ),
  AiChat(
    id: 'c2',
    title: 'Weekly Checkup',
    lastMessage: 'Your mood score improved by 15%.',
    time: '2h ago',
    color: AppColors.primaryGreen,
    icon: FontAwesomeIcons.calendarCheck,
    type: ConversationType.wellness,
  ),
  AiChat(
    id: 'c3',
    title: 'Coping with Stress',
    lastMessage: 'Remember the 5-4-3-2-1 technique.',
    time: 'Yesterday',
    color: AppColors.darkGreen,
    icon: FontAwesomeIcons.handHoldingHeart,
    type: ConversationType.copingSkills,
  ),
  AiChat(
    id: 'c4',
    title: 'Mindfulness Practice',
    lastMessage: 'Have you tried the 10-minute meditation?',
    time: '01/10/24',
    color: Colors.blueAccent,
    icon: FontAwesomeIcons.solidSun,
    type: ConversationType.wellness,
  ),
  AiChat(
    id: 'c5',
    title: 'More data in each why',
    lastMessage: 'This is an example of why we use dummy data.',
    time: '20/09/24',
    color: Colors.purple,
    icon: FontAwesomeIcons.brain,
    type: ConversationType.relationships,
  ),
];

final List<Message> dummyMessages = [
  Message(
    text:
        'I\'ve been feeling quite stressed about my new project at work. I feel overwhelmed.',
    isUser: true,
  ),
  Message(
    text:
        'I understand. Dealing with a new project can be challenging. Could you tell me more about what specifically is causing the feeling of being overwhelmed?',
    isUser: false,
    citation: 'Cognitive Behavioral Therapy (CBT)',
  ),
  Message(
    text:
        'It\'s the sheer volume of tasks and the tight deadline. It feels impossible to finish everything.',
    isUser: true,
  ),
  Message(
    text:
        'That sounds like a lot to handle. We can use a technique to break down the problem. Let\'s try task chunking. Before that, how was your day generally?',
    isUser: false,
  ),
];

// Mood tracking data
final List<MoodEntry> moodEntries = [
  MoodEntry(
    date: DateTime.now().subtract(const Duration(days: 1)),
    moodLevel: 3,
    note: 'Felt a bit tired but overall okay',
    tags: ['Tired', 'Work', 'Neutral'],
  ),
  MoodEntry(
    date: DateTime.now().subtract(const Duration(days: 2)),
    moodLevel: 4,
    note: 'Had a great workout and productive day',
    tags: ['Energetic', 'Productive', 'Happy'],
  ),
  MoodEntry(
    date: DateTime.now().subtract(const Duration(days: 3)),
    moodLevel: 2,
    note: 'Stressed about deadlines',
    tags: ['Stressed', 'Work', 'Anxious'],
  ),
  MoodEntry(
    date: DateTime.now().subtract(const Duration(days: 4)),
    moodLevel: 5,
    note: 'Amazing day with friends',
    tags: ['Social', 'Happy', 'Excited'],
  ),
  MoodEntry(
    date: DateTime.now().subtract(const Duration(days: 5)),
    moodLevel: 3,
    note: 'Just a normal day',
    tags: ['Neutral', 'Routine'],
  ),
];

// Meditation sessions data
final List<MeditationSession> meditationSessions = [
  MeditationSession(
    id: 'm1',
    title: 'Breathing Basics',
    description: 'Learn fundamental breathing techniques to calm your mind',
    duration: '5 min',
    icon: FontAwesomeIcons.wind,
    color: Colors.blue,
    isCompleted: true,
  ),
  MeditationSession(
    id: 'm2',
    title: 'Body Scan Relaxation',
    description:
        'Release tension throughout your body with this guided practice',
    duration: '10 min',
    icon: FontAwesomeIcons.person,
    color: Colors.green,
  ),
  MeditationSession(
    id: 'm3',
    title: 'Sleep Meditation',
    description: 'Drift into a peaceful sleep with this calming practice',
    duration: '15 min',
    icon: FontAwesomeIcons.moon,
    color: Colors.indigo,
  ),
  MeditationSession(
    id: 'm4',
    title: 'Anxiety Relief',
    description: 'Techniques to manage and reduce anxiety symptoms',
    duration: '8 min',
    icon: FontAwesomeIcons.shieldHalved,
    color: Colors.purple,
  ),
  MeditationSession(
    id: 'm5',
    title: 'Morning Mindfulness',
    description: 'Start your day with clarity and intention',
    duration: '7 min',
    icon: FontAwesomeIcons.sun,
    color: Colors.orange,
  ),
];

// --- Animation Helper Widget ---
class FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double begin;
  final double end;
  final int? index;
  final Duration delay;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.begin = 0.0,
    this.end = 1.0,
    this.index,
    this.delay = const Duration(milliseconds: 100),
  });

  @override
  FadeInAnimationState createState() => FadeInAnimationState();
}

class FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacity = Tween<double>(
      begin: widget.begin,
      end: widget.end,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _position = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Start animation with delay based on index
    final startDelay = widget.index != null
        ? widget.delay * widget.index!
        : Duration.zero;
    Future.delayed(startDelay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _position, child: widget.child),
    );
  }
}

// --- Main Application Widget ---

// --- Screen 1: Welcome Screen ---

class AIITherapyChattbottScreen extends StatelessWidget {
  const AIITherapyChattbottScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FadeInAnimation(
          duration: const Duration(milliseconds: 800),
          child: Text(
            'AI Therapy Chatbot',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),

      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(''),
              const SizedBox(height: 40),
              FadeInAnimation(
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.darkGreen, width: 4),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.robot,
                      size: 80,
                      color: AppColors.darkGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
              FadeInAnimation(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 800),
                child: Text(
                  'Meet your personal, secure, and always-available AI Doctor Fred.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              FadeInAnimation(
                delay: const Duration(milliseconds: 600),
                duration: const Duration(milliseconds: 800),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyConversationsScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'Talk to Doctor Fred AI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Screen 2: My Conversations Screen ---

class MyConversationsScreen extends StatelessWidget {
  const MyConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Conversations'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInAnimation(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _StatBlock(
                      value: '1,571',
                      label: 'Chats',
                      color: Colors.white,
                    ),
                    _StatBlock(value: '22', label: 'Days', color: Colors.white),
                    _StatBlock(
                      value: '1 Share',
                      label: 'Insights',
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'My Conversations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(dummyChats.length, (index) {
              return FadeInAnimation(
                index: index,
                delay: const Duration(milliseconds: 100),
                child: _ConversationListTile(chat: dummyChats[index]),
              );
            }),
            const SizedBox(height: 24),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: _UpgradeToProCard(),
            ),
          ],
        ),
      ),
    );
  }
}

// Private helper for MyConversationsScreen
class _StatBlock extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatBlock({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: color.withValues(alpha: 0.8)),
        ),
      ],
    );
  }
}

// Private helper for MyConversationsScreen
class _ConversationListTile extends StatelessWidget {
  final AiChat chat;

  const _ConversationListTile({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: chat.color.withValues(alpha: 0.1),
          child: FaIcon(chat.icon, color: chat.color, size: 20),
        ),
        title: Text(
          chat.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(chat.lastMessage, overflow: TextOverflow.ellipsis),
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 14,
          color: AppColors.greyText,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen(chat: chat)),
          );
        },
      ),
    );
  }
}

// Private helper for MyConversationsScreen
class _UpgradeToProCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.darkGreen,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            FaIcon(FontAwesomeIcons.solidStar, color: Colors.yellow, size: 30),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Upgrade to Pro',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Unlock all features and priority support.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 3: My AI Chats Screen (Home/Dashboard) ---

class AITherapyChatbot extends StatelessWidget {
  const AITherapyChatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My AI Chats'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.circleUser),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Tracker Card
            FadeInAnimation(
              duration: const Duration(milliseconds: 600),
              child: _MoodTrackerCard(),
            ),
            const SizedBox(height: 20),
            // Meditation Card
            FadeInAnimation(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 600),
              child: _MeditationCard(),
            ),
            const SizedBox(height: 20),
            ...List.generate(dummyChats.length, (index) {
              return FadeInAnimation(
                index: index,
                delay: const Duration(milliseconds: 100),
                child: AiChatCard(chat: dummyChats[index]),
              );
            }),
            const SizedBox(height: 30),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Recommended Topics',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 600),
              child: _RecommendedTopicTile(
                title: 'Sleep Hygiene',
                subtitle: 'New techniques for better rest.',
                icon: FontAwesomeIcons.bed,
                color: Colors.indigo,
              ),
            ),
            FadeInAnimation(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 600),
              child: _RecommendedTopicTile(
                title: 'Emotional Resilience',
                subtitle: 'Build stronger emotional defenses.',
                icon: FontAwesomeIcons.shieldHalved,
                color: AppColors.primaryGreen,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FadeInAnimation(
        delay: const Duration(milliseconds: 800),
        duration: const Duration(milliseconds: 600),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewConversationScreen()),
            );
          },
          label: const Text(
            'New Conversation',
            style: TextStyle(color: Colors.white),
          ),
          icon: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
          backgroundColor: AppColors.primaryOrange,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}

// Mood Tracker Card for Dashboard
class _MoodTrackerCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.faceSmile,
                      color: AppColors.primaryGreen,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Mood Tracker',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoodTrackerScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(color: AppColors.primaryOrange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MoodIcon(
                  icon: FontAwesomeIcons.faceFrown,
                  color: AppColors.moodSad,
                  label: 'Sad',
                ),
                _MoodIcon(
                  icon: FontAwesomeIcons.faceMeh,
                  color: AppColors.moodNeutral,
                  label: 'Neutral',
                ),
                _MoodIcon(
                  icon: FontAwesomeIcons.faceSmile,
                  color: AppColors.moodHappy,
                  label: 'Happy',
                ),
                _MoodIcon(
                  icon: FontAwesomeIcons.faceLaugh,
                  color: AppColors.moodExcited,
                  label: 'Excited',
                ),
                _MoodIcon(
                  icon: FontAwesomeIcons.faceAngry,
                  color: AppColors.moodAngry,
                  label: 'Angry',
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Your mood has improved by 15% this week',
              style: TextStyle(color: AppColors.greyText),
            ),
          ],
        ),
      ),
    );
  }
}

// Mood Icon Widget
class _MoodIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _MoodIcon({
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, color: color, size: 28),
        const SizedBox(height: 5),
        Text(label, style: TextStyle(color: AppColors.greyText, fontSize: 12)),
      ],
    );
  }
}

// Meditation Card for Dashboard
class _MeditationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.spa,
                      color: Colors.purple,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Meditation',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeditationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(color: AppColors.primaryOrange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.purple.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: Colors.purple,
                          size: 30,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '45 min',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        Text(
                          'This week',
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.fire,
                          color: Colors.green,
                          size: 30,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '7 day',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'Streak',
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for a single chat item on the MyAiChatsScreen
class AiChatCard extends StatelessWidget {
  final AiChat chat;

  const AiChatCard({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final randomUserImageUrl =
        'https://randomuser.me/api/portraits/${Random().nextBool() ? 'men' : 'women'}/${Random().nextInt(100)}.jpg';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(randomUserImageUrl),
          onBackgroundImageError: (exception, stackTrace) => FaIcon(
            FontAwesomeIcons.circleUser,
            size: 40,
            color: AppColors.primaryGreen,
          ),
        ),
        title: Text(
          chat.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          chat.lastMessage,
          style: TextStyle(color: AppColors.greyText),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              chat.time,
              style: TextStyle(color: AppColors.greyText, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: chat.color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'AI',
                style: TextStyle(
                  color: chat.color,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen(chat: chat)),
          );
        },
      ),
    );
  }
}

// Private helper for MyAiChatsScreen
class _RecommendedTopicTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _RecommendedTopicTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.1),
          child: FaIcon(icon, color: color, size: 20),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(color: AppColors.greyText)),
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 14,
          color: AppColors.greyText,
        ),
        onTap: () {
          // Navigate to a dedicated topic screen or start a new chat
        },
      ),
    );
  }
}

// --- Screen 4: New Conversation Screen ---

class NewConversationScreen extends StatefulWidget {
  const NewConversationScreen({super.key});

  @override
  State<NewConversationScreen> createState() => _NewConversationScreenState();
}

enum ConversationMode { qa, aiChat, therapy }

class _NewConversationScreenState extends State<NewConversationScreen> {
  ConversationMode selectedMode = ConversationMode.aiChat;
  ConversationType selectedType = ConversationType.wellness;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Conversation'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInAnimation(
              duration: const Duration(milliseconds: 600),
              child: _AiMascotHeader(),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 600),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Ask me anything about your wellness...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: AppColors.greyText,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Conversation Mode',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 600),
              child: _ModeSelector(
                selectedMode: selectedMode,
                onModeSelected: (mode) {
                  setState(() {
                    selectedMode = mode;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 600),
              child: _LimitedKnowledgeCard(),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Conversation Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 600),
              child: _ConversationTypeSelector(
                selectedType: selectedType,
                onTypeSelected: (type) {
                  setState(() {
                    selectedType = type;
                  });
                },
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: FadeInAnimation(
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 600),
                child: ElevatedButton.icon(
                  onPressed: () {
                    final newChat = AiChat(
                      id: 'new',
                      title: 'New ${selectedType.name} Chat',
                      lastMessage: 'Starting a new conversation...',
                      time: 'Now',
                      color: AppColors.primaryGreen,
                      icon: FontAwesomeIcons.lightbulb,
                      type: selectedType,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(chat: newChat),
                      ),
                    );
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Create Conversation',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Private helper for NewConversationScreen
class _AiMascotHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FaIcon(
              FontAwesomeIcons.robot,
              size: 40,
              color: AppColors.primaryGreen,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Doctor Fred AI',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  'The AI for your emotional well-being.',
                  style: TextStyle(color: AppColors.greyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Private helper for NewConversationScreen
class _ModeSelector extends StatelessWidget {
  final ConversationMode selectedMode;
  final ValueChanged<ConversationMode> onModeSelected;

  const _ModeSelector({
    required this.selectedMode,
    required this.onModeSelected,
  });

  Widget _buildToggle(String label, ConversationMode mode) {
    final isSelected = selectedMode == mode;
    return GestureDetector(
      onTap: () => onModeSelected(mode),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightGrey),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildToggle('Q&A', ConversationMode.qa),
        _buildToggle('AI Chat', ConversationMode.aiChat),
        _buildToggle('Therapy', ConversationMode.therapy),
      ],
    );
  }
}

// Private helper for NewConversationScreen
class _LimitedKnowledgeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.primaryOrange.withValues(alpha: 0.15),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            FaIcon(
              FontAwesomeIcons.triangleExclamation,
              color: AppColors.primaryOrange,
              size: 20,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                'Limited knowledge: Data current up to 2023. May not know latest events.',
                style: TextStyle(color: Colors.black.withValues(alpha: 0.87)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Private helper for NewConversationScreen
class _ConversationTypeSelector extends StatelessWidget {
  final ConversationType selectedType;
  final ValueChanged<ConversationType> onTypeSelected;

  const _ConversationTypeSelector({
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: ConversationType.values.map((type) {
          final isSelected = selectedType == type;
          String title = type.name.splitMapJoin(
            RegExp(r'[A-Z]'),
            onMatch: (m) => ' ${m.group(0)}',
            onNonMatch: (n) => n,
          );
          title = title[0].toUpperCase() + title.substring(1);

          return ListTile(
            title: Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected
                ? FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: AppColors.primaryGreen,
                  )
                : FaIcon(FontAwesomeIcons.circle, color: AppColors.lightGrey),
            onTap: () => onTypeSelected(type),
          );
        }).toList(),
      ),
    );
  }
}

// --- Screen 5: Chat Screen ---

class ChatScreen extends StatelessWidget {
  final AiChat chat;
  final String doctorImage = 'https://randomuser.me/api/portraits/men/11.jpg';

  const ChatScreen({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(doctorImage),
              radius: 18,
            ),
            const SizedBox(width: 8),
            Text(
              chat.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.video,
              color: AppColors.primaryOrange,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoCallScreen()),
              );
            },
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.phone,
              color: AppColors.primaryOrange,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final message = dummyMessages[index];
                return FadeInAnimation(
                  index: index,
                  delay: const Duration(milliseconds: 100),
                  child: MessageBubble(
                    message: message,
                    doctorImage: doctorImage,
                  ),
                );
              },
            ),
          ),
          FadeInAnimation(
            delay: const Duration(milliseconds: 200),
            duration: const Duration(milliseconds: 600),
            child: _AdditionalChatFeatures(),
          ),
          ChatInput(),
        ],
      ),
    );
  }
}

// Private helper for ChatScreen
class MessageBubble extends StatelessWidget {
  final Message message;
  final String doctorImage;

  const MessageBubble({
    super.key,
    required this.message,
    required this.doctorImage,
  });

  @override
  Widget build(BuildContext context) {
    final userImage =
        'https://randomuser.me/api/portraits/women/${Random().nextInt(100)}.jpg';

    final alignment = message.isUser
        ? Alignment.centerRight
        : Alignment.centerLeft;
    final color = message.isUser
        ? AppColors.userChatBubble
        : AppColors.primaryGreen;
    final textColor = message.isUser ? Colors.black : Colors.white;
    final borderRadius = BorderRadius.circular(16);

    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: message.isUser
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser) ...[
              CircleAvatar(
                backgroundImage: NetworkImage(doctorImage),
                radius: 18,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Column(
                crossAxisAlignment: message.isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: message.isUser
                          ? borderRadius.copyWith(bottomRight: Radius.zero)
                          : borderRadius.copyWith(bottomLeft: Radius.zero),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(color: textColor, fontSize: 16),
                    ),
                  ),
                  if (message.citation != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Source: ${message.citation}',
                          style: TextStyle(
                            color: Colors.black.withValues(alpha: 0.54),
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (message.isUser) ...[
              const SizedBox(width: 8),
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
                radius: 18,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Private helper for ChatScreen
class _AdditionalChatFeatures extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            _SuggestionChip(
              text: 'Give me a quick tip',
              color: Colors.blueAccent,
            ),
            _SuggestionChip(
              text: 'What is task chunking?',
              color: AppColors.primaryGreen,
            ),
            _SuggestionChip(
              text: 'I feel good today',
              color: AppColors.primaryOrange,
            ),
          ],
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TrackerItem(
                  icon: FontAwesomeIcons.solidHeart,
                  title: 'Heart Health',
                  value: '85%',
                  color: Colors.red,
                ),
                _TrackerItem(
                  icon: FontAwesomeIcons.solidFaceSmile,
                  title: 'Mood Score',
                  value: '7/10',
                  color: Colors.deepPurple,
                ),
                _TrackerItem(
                  icon: FontAwesomeIcons.clock,
                  title: 'Focus Time',
                  value: '2h 15m',
                  color: AppColors.primaryOrange,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Private helper for ChatScreen
class _SuggestionChip extends StatelessWidget {
  final String text;
  final Color color;

  const _SuggestionChip({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.w600),
      ),
      backgroundColor: color.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      onPressed: () {
        // Send suggestion as user message
      },
    );
  }
}

// Private helper for ChatScreen
class _TrackerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _TrackerItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(title, style: TextStyle(color: AppColors.greyText, fontSize: 12)),
      ],
    );
  }
}

// Private helper for ChatScreen
class ChatInput extends StatelessWidget {
  const ChatInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.lightGrey, width: 1)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.microphone,
                color: AppColors.greyText,
              ),
              onPressed: () {},
            ),
            Expanded(
              child: Card(
                elevation: 0,
                color: AppColors.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: FaIcon(
                          FontAwesomeIcons.paperclip,
                          color: AppColors.greyText,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: FaIcon(
                FontAwesomeIcons.paperPlane,
                color: AppColors.primaryOrange,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 6: Video Call/Selfie Screen ---

class VideoCallScreen extends StatelessWidget {
  const VideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Camera/Video View (Simulated)
          Container(
            color: Colors.black,
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.video,
                size: 100,
                color: Colors.white.withValues(alpha: 0.54),
              ),
            ),
          ),
          // Face Detection Overlay and User Image (Placeholder)
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width * 0.9 * 1.5,
              child: CustomPaint(
                painter: FaceDetectionPainter(),
                child: Center(
                  child: ClipOval(
                    child: Image.network(
                      'https://randomuser.me/api/portraits/women/90.jpg',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Top Stats Overlay
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _StatPill(
                    icon: FontAwesomeIcons.clock,
                    value: '18s',
                    color: Colors.white,
                  ),
                  _StatPill(
                    icon: FontAwesomeIcons.solidHeart,
                    value: '68 bpm',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
          // Bottom Controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _CallControlButton(
                  icon: FontAwesomeIcons.solidCircle,
                  color: AppColors.primaryOrange,
                  onPressed: () {
                    // Capture action
                  },
                ),
                _CallControlButton(
                  icon: FontAwesomeIcons.phone,
                  color: Colors.red,
                  onPressed: () => Navigator.pop(context),
                ),
                _CallControlButton(
                  icon: FontAwesomeIcons.cameraRotate,
                  color: Colors.white,
                  onPressed: () {
                    // Flip camera
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Private helper for VideoCallScreen
class _StatPill extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const _StatPill({
    required this.icon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          FaIcon(icon, color: color, size: 16),
          const SizedBox(width: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Private helper for VideoCallScreen
class _CallControlButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _CallControlButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Colors.white.withValues(alpha: 0.1),
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: FaIcon(icon, size: 30.0, color: color),
    );
  }
}

// Custom Painter to simulate the Face Detection Outline
class FaceDetectionPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 3;

    final paint = Paint()
      ..color = AppColors.primaryOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    // Draw the main oval/circle outline (simulating the face tracker)
    canvas.drawCircle(center, radius, paint);

    // Draw small corner arcs (for extra design touch)
    _drawArcCorners(canvas, paint, center, radius);
  }

  void _drawArcCorners(
    Canvas canvas,
    Paint paint,
    Offset center,
    double radius,
  ) {
    final cornerLength = 0.1 * radius;
    final cornerArcStart = 0.9 * radius;

    // Helper to draw corners
    void drawCorner(double angle, double xSign, double ySign) {
      final x = center.dx + xSign * cornerArcStart * cos(angle);
      final y = center.dy + ySign * cornerArcStart * sin(angle);

      canvas.drawLine(
        Offset(x, y),
        Offset(
          x + xSign * cornerLength * cos(angle),
          y + ySign * cornerLength * sin(angle),
        ),
        paint,
      );
      canvas.drawLine(
        Offset(x, y),
        Offset(
          x + xSign * cornerLength * cos(angle + pi / 2),
          y + ySign * cornerLength * sin(angle + pi / 2),
        ),
        paint,
      );
    }

    // Top Right
    drawCorner(pi / 4, 1, -1);
    // Top Left
    drawCorner(pi / 4, -1, -1);
    // Bottom Left
    drawCorner(pi / 4, -1, 1);
    // Bottom Right
    drawCorner(pi / 4, 1, 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- Screen 7: Mood Tracker Screen ---

class MoodTrackerScreen extends StatelessWidget {
  const MoodTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Tracker'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInAnimation(
              duration: const Duration(milliseconds: 600),
              child: _MoodOverviewCard(),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Recent Entries',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(moodEntries.length, (index) {
              return FadeInAnimation(
                index: index,
                delay: const Duration(milliseconds: 100),
                child: _MoodEntryCard(entry: moodEntries[index]),
              );
            }),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: _MoodInsightsCard(),
            ),
          ],
        ),
      ),
      floatingActionButton: FadeInAnimation(
        delay: const Duration(milliseconds: 300),
        duration: const Duration(milliseconds: 600),
        child: FloatingActionButton(
          onPressed: () {
            // Show mood entry dialog
          },
          backgroundColor: AppColors.primaryOrange,
          child: const FaIcon(FontAwesomeIcons.plus, color: Colors.white),
        ),
      ),
    );
  }
}

// Mood Overview Card
class _MoodOverviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Mood This Week',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            // Simple mood chart
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _MoodBar(height: 0.4, mood: 2, day: 'Mon'),
                  _MoodBar(height: 0.6, mood: 3, day: 'Tue'),
                  _MoodBar(height: 0.8, mood: 4, day: 'Wed'),
                  _MoodBar(height: 0.3, mood: 2, day: 'Thu'),
                  _MoodBar(height: 0.9, mood: 5, day: 'Fri'),
                  _MoodBar(height: 0.7, mood: 4, day: 'Sat'),
                  _MoodBar(height: 0.5, mood: 3, day: 'Sun'),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Average Mood: 3.4/5',
                  style: TextStyle(color: AppColors.greyText),
                ),
                Text(
                  'Improvement: +15%',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Mood Bar Widget
class _MoodBar extends StatelessWidget {
  final double height;
  final int mood;
  final String day;

  const _MoodBar({required this.height, required this.mood, required this.day});

  @override
  Widget build(BuildContext context) {
    Color barColor;
    switch (mood) {
      case 1:
        barColor = AppColors.moodAngry;
        break;
      case 2:
        barColor = AppColors.moodSad;
        break;
      case 3:
        barColor = AppColors.moodNeutral;
        break;
      case 4:
        barColor = AppColors.moodHappy;
        break;
      case 5:
        barColor = AppColors.moodExcited;
        break;
      default:
        barColor = AppColors.moodNeutral;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 30,
          height: 120 * height,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(day, style: TextStyle(color: AppColors.greyText, fontSize: 12)),
      ],
    );
  }
}

// Mood Entry Card
class _MoodEntryCard extends StatelessWidget {
  final MoodEntry entry;

  const _MoodEntryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    IconData moodIcon;
    Color moodColor;

    switch (entry.moodLevel) {
      case 1:
        moodIcon = FontAwesomeIcons.faceAngry;
        moodColor = AppColors.moodAngry;
        break;
      case 2:
        moodIcon = FontAwesomeIcons.faceFrown;
        moodColor = AppColors.moodSad;
        break;
      case 3:
        moodIcon = FontAwesomeIcons.faceMeh;
        moodColor = AppColors.moodNeutral;
        break;
      case 4:
        moodIcon = FontAwesomeIcons.faceSmile;
        moodColor = AppColors.moodHappy;
        break;
      case 5:
        moodIcon = FontAwesomeIcons.faceLaugh;
        moodColor = AppColors.moodExcited;
        break;
      default:
        moodIcon = FontAwesomeIcons.faceMeh;
        moodColor = AppColors.moodNeutral;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: FaIcon(moodIcon, color: moodColor, size: 28),
        title: Text(
          '${entry.date.day}/${entry.date.month}/${entry.date.year}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(entry.note),
        trailing: Wrap(
          spacing: 4,
          children: entry.tags.map((tag) {
            return Chip(
              label: Text(
                tag,
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              backgroundColor: moodColor.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Mood Insights Card
class _MoodInsightsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mood Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.cloudSun,
                          color: Colors.blue,
                          size: 30,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Weather',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'Sunny days improve mood',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.dumbbell,
                          color: Colors.green,
                          size: 30,
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Exercise',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          '30 min activity boosts mood',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.lightbulb,
                    color: Colors.purple,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Recommendation',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Try morning meditation to improve your mood throughout the day',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.greyText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 8: Meditation Screen ---

class MeditationScreen extends StatelessWidget {
  const MeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditation'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInAnimation(
              duration: const Duration(milliseconds: 600),
              child: _MeditationStatsCard(),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Recommended for You',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: _FeaturedMeditationCard(),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'All Sessions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ...List.generate(meditationSessions.length, (index) {
              return FadeInAnimation(
                index: index,
                delay: const Duration(milliseconds: 100),
                child: _MeditationSessionCard(
                  session: meditationSessions[index],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Meditation Stats Card
class _MeditationStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Meditation Journey',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _MeditationStat(
                  value: '7',
                  label: 'Day Streak',
                  icon: FontAwesomeIcons.fire,
                  color: Colors.orange,
                ),
                _MeditationStat(
                  value: '45',
                  label: 'Minutes',
                  icon: FontAwesomeIcons.clock,
                  color: Colors.blue,
                ),
                _MeditationStat(
                  value: '12',
                  label: 'Sessions',
                  icon: FontAwesomeIcons.spa,
                  color: Colors.purple,
                ),
              ],
            ),
            const SizedBox(height: 15),
            LinearProgressIndicator(
              value: 0.7,
              backgroundColor: AppColors.lightGrey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryGreen),
            ),
            const SizedBox(height: 5),
            Text(
              '70% of weekly goal (60 min)',
              style: TextStyle(color: AppColors.greyText, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// Meditation Stat Widget
class _MeditationStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _MeditationStat({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, color: color, size: 30),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(color: AppColors.greyText)),
      ],
    );
  }
}

// Featured Meditation Card
class _FeaturedMeditationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.purple.withValues(alpha: 0.8), Colors.purple],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Featured',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    const Spacer(),
                    FaIcon(FontAwesomeIcons.bookmark, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Deep Relaxation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Release tension and find inner peace',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                const Spacer(),
                Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.clock,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    const Text('15 min', style: TextStyle(color: Colors.white)),
                    const SizedBox(width: 20),
                    FaIcon(
                      FontAwesomeIcons.headphones,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    const Text('Audio', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Meditation Session Card
class _MeditationSessionCard extends StatelessWidget {
  final MeditationSession session;

  const _MeditationSessionCard({required this.session});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: session.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: FaIcon(session.icon, color: session.color, size: 24),
          ),
        ),
        title: Text(
          session.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(session.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              session.duration,
              style: TextStyle(
                color: AppColors.greyText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            if (session.isCompleted)
              FaIcon(
                FontAwesomeIcons.solidCircleCheck,
                color: AppColors.primaryGreen,
              )
            else
              FaIcon(FontAwesomeIcons.circle, color: AppColors.lightGrey),
          ],
        ),
        onTap: () {
          // Start meditation session
        },
      ),
    );
  }
}

// --- Screen 9: Profile Screen ---

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String profileImage =
        'https://randomuser.me/api/portraits/men/11.jpg';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.gear),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInAnimation(
              duration: const Duration(milliseconds: 600),
              child: _ProfileHeader(profileImage: profileImage),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 100),
              duration: const Duration(milliseconds: 600),
              child: _ProfileStatsCard(),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 200),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Account Settings',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: const Duration(milliseconds: 300),
              duration: const Duration(milliseconds: 600),
              child: _SettingsTile(
                icon: FontAwesomeIcons.bell,
                title: 'Notifications',
                subtitle: 'Manage your notification preferences',
                onTap: () {},
              ),
            ),
            FadeInAnimation(
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 600),
              child: _SettingsTile(
                icon: FontAwesomeIcons.lock,
                title: 'Privacy & Security',
                subtitle: 'Manage your data and privacy settings',
                onTap: () {},
              ),
            ),
            FadeInAnimation(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 600),
              child: _SettingsTile(
                icon: FontAwesomeIcons.creditCard,
                title: 'Subscription',
                subtitle: 'Manage your subscription plan',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),
            FadeInAnimation(
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 600),
              child: const Text(
                'Support',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            FadeInAnimation(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 600),
              child: _SettingsTile(
                icon: FontAwesomeIcons.circleQuestion,
                title: 'Help Center',
                subtitle: 'Find answers to common questions',
                onTap: () {},
              ),
            ),
            FadeInAnimation(
              delay: const Duration(milliseconds: 800),
              duration: const Duration(milliseconds: 600),
              child: _SettingsTile(
                icon: FontAwesomeIcons.comments,
                title: 'Contact Us',
                subtitle: 'Reach out to our support team',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 30),
            FadeInAnimation(
              delay: const Duration(milliseconds: 900),
              duration: const Duration(milliseconds: 600),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Log out
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Header
class _ProfileHeader extends StatelessWidget {
  final String profileImage;

  const _ProfileHeader({required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImage),
            ),
            const SizedBox(height: 15),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              'john.doe@example.com',
              style: TextStyle(color: AppColors.greyText),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.crown,
                        color: AppColors.primaryGreen,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Pro Member',
                        style: TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Stats Card
class _ProfileStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Progress',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ProfileStat(
                  value: '28',
                  label: 'Days Active',
                  icon: FontAwesomeIcons.calendarCheck,
                  color: Colors.blue,
                ),
                _ProfileStat(
                  value: '156',
                  label: 'Sessions',
                  icon: FontAwesomeIcons.comments,
                  color: Colors.green,
                ),
                _ProfileStat(
                  value: '4.2',
                  label: 'Avg Mood',
                  icon: FontAwesomeIcons.faceSmile,
                  color: Colors.orange,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.trophy,
                    color: AppColors.primaryOrange,
                    size: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Achievement Unlocked!',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '7-day meditation streak',
                          style: TextStyle(color: AppColors.greyText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Profile Stat Widget
class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;

  const _ProfileStat({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FaIcon(icon, color: color, size: 30),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(color: AppColors.greyText)),
      ],
    );
  }
}

// Settings Tile
class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: FaIcon(icon, color: AppColors.primaryGreen, size: 24),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: FaIcon(
          FontAwesomeIcons.chevronRight,
          size: 16,
          color: AppColors.greyText,
        ),
        onTap: onTap,
      ),
    );
  }
}
