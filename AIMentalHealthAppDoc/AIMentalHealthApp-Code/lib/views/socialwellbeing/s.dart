import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

// Helper function to convert opacity to alpha for withAlpha
int _alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}

class HealthAppUI extends StatefulWidget {
  const HealthAppUI({super.key});

  @override
  State<HealthAppUI> createState() => _HealthAppUIState();
}

class _HealthAppUIState extends State<HealthAppUI> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animationController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.deepPurple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[100],
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      home: const SocialWellbeingScreen(),
    );
  }
}

// Dummy data for social wellbeing scores and calendar
final List<int> socialScores = [60, 70, 75, 65, 80, 72, 78, 82, 85, 79, 70, 68, 73, 76, 81, 88, 90, 85, 78, 72, 65, 58, 62, 67, 71, 75, 79, 83, 86, 89];
final Map<int, List<bool>> calendarData = {
  29: [true, true, true],
  30: [true, true],
  1: [true, true, true],
  2: [true, true],
  3: [true, true, true],
  4: [true, true, true],
  5: [true, true, true],
  6: [true, true],
  7: [true, true, true],
  8: [true],
  9: [true, true, true],
  10: [true, true, true],
  11: [], // Crossed out day
  12: [true, true],
};

// Dummy data for health journal
final List<String> journalEntries = [
  "Had a great chat with an old friend today, felt really uplifted!",
  "Volunteered at the community center, met some amazing new people.",
  "Went for a walk with my dog and saw some neighbors, exchanged pleasantries.",
  "Attended a virtual book club meeting, good discussion.",
  "Caught up with family over video call, felt connected.",
  "Had coffee with a colleague, discussed work and life.",
  "Visited a local market and chatted with vendors, enjoyed the lively atmosphere.",
  "Helped a friend move, felt good to be useful.",
  "Joined an online gaming group, had some fun interactions.",
  "Sent a thoughtful card to a friend, felt happy to reach out.",
  "Participated in a group exercise class, good energy.",
  "Had a lengthy phone call with my sister, we laughed a lot.",
  "Attended a local community event, made a new acquaintance.",
  "Enjoyed a quiet evening at home, sometimes solitude is good too.",
  "Met up with an old university mate, reminisced about old times.",
  "Helped a neighbor with their garden, felt a sense of community.",
  "Had a lively discussion in an online forum, engaged with new ideas.",
  "Went to a concert with friends, fantastic night out.",
  "Had a potluck dinner with my building residents, good food and company.",
  "Joined a local photography club meeting, shared creative ideas.",
  "Spoke with a mentor, received valuable advice.",
  "Had a casual catch-up with a former classmate, nice to reconnect.",
  "Attended a workshop, learned something new and met fellow learners.",
  "Volunteered at a local animal shelter, heartwarming experience.",
  "Went on a group hike, enjoyed nature and good conversations.",
  "Had a board game night with friends, lots of fun and laughter.",
  "Shared a meal with my family, always a comfort.",
  "Participated in a charity run, felt good about contributing.",
  "Attended a cultural festival, immersed myself in different traditions.",
  "Helped out at a school fair, enjoyed the community spirit.",
];

// Dummy data for activities
enum ActivityType { social, physical, mental, emotional }

class Activity {
  final String name;
  final ActivityType type;
  final IconData icon;
  final Color color;

  Activity({required this.name, required this.type, required this.icon, required this.color});
}

final List<Activity> recentActivities = [
  Activity(name: "Coffee with Sarah", type: ActivityType.social, icon: FontAwesomeIcons.mugSaucer, color: Colors.blueAccent),
  Activity(name: "Morning run", type: ActivityType.physical, icon: FontAwesomeIcons.personRunning, color: Colors.green),
  Activity(name: "Meditation session", type: ActivityType.mental, icon: FontAwesomeIcons.brain, color: Colors.purple),
  Activity(name: "Family dinner", type: ActivityType.social, icon: FontAwesomeIcons.utensils, color: Colors.orange),
  Activity(name: "Reading a book", type: ActivityType.mental, icon: FontAwesomeIcons.bookOpen, color: Colors.indigo),
  Activity(name: "Yoga class", type: ActivityType.physical, icon: FontAwesomeIcons.spa, color: Colors.teal),
];

// Dummy data for mood tracking
enum MoodType { verySad, sad, neutral, happy, veryHappy }

class MoodEntry {
  final DateTime date;
  final MoodType mood;
  final String note;

  MoodEntry({required this.date, required this.mood, required this.note});
}

final List<MoodEntry> moodEntries = [
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 6)), mood: MoodType.neutral, note: "Feeling okay today"),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 5)), mood: MoodType.happy, note: "Had a great day with friends"),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 4)), mood: MoodType.veryHappy, note: "Amazing news at work!"),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 3)), mood: MoodType.sad, note: "Feeling a bit down"),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 2)), mood: MoodType.neutral, note: "Just a normal day"),
  MoodEntry(date: DateTime.now().subtract(const Duration(days: 1)), mood: MoodType.happy, note: "Good day overall"),
  MoodEntry(date: DateTime.now(), mood: MoodType.veryHappy, note: "Feeling great today!"),
];

// Dummy data for meditation sessions
class MeditationSession {
  final String title;
  final String description;
  final int duration;
  final IconData icon;
  final Color color;

  MeditationSession({required this.title, required this.description, required this.duration, required this.icon, required this.color});
}

final List<MeditationSession> meditationSessions = [
  MeditationSession(
    title: "Morning Calm",
    description: "Start your day with peace and clarity",
    duration: 10,
    icon: FontAwesomeIcons.sun,
    color: Colors.orange,
  ),
  MeditationSession(
    title: "Stress Relief",
    description: "Release tension and anxiety",
    duration: 15,
    icon: FontAwesomeIcons.cloud,
    color: Colors.blue,
  ),
  MeditationSession(
    title: "Deep Sleep",
    description: "Prepare your mind for restful sleep",
    duration: 20,
    icon: FontAwesomeIcons.moon,
    color: Colors.indigo,
  ),
  MeditationSession(
    title: "Focus Boost",
    description: "Enhance concentration and productivity",
    duration: 12,
    icon: FontAwesomeIcons.brain,
    color: Colors.purple,
  ),
  MeditationSession(
    title: "Anxiety Relief",
    description: "Calm your anxious thoughts",
    duration: 18,
    icon: FontAwesomeIcons.heart,
    color: Colors.pink,
  ),
  MeditationSession(
    title: "Body Scan",
    description: "Release physical tension and relax",
    duration: 25,
    icon: FontAwesomeIcons.person,
    color: Colors.teal,
  ),
];

// Dummy data for mental health resources
class MentalHealthResource {
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final Color color;

  MentalHealthResource({required this.title, required this.description, required this.category, required this.icon, required this.color});
}

final List<MentalHealthResource> mentalHealthResources = [
  MentalHealthResource(
    title: "Understanding Anxiety",
    description: "Learn about anxiety disorders and coping strategies",
    category: "Article",
    icon: FontAwesomeIcons.book,
    color: Colors.blue,
  ),
  MentalHealthResource(
    title: "Depression Support Group",
    description: "Connect with others experiencing similar challenges",
    category: "Support",
    icon: FontAwesomeIcons.peopleGroup,
    color: Colors.green,
  ),
  MentalHealthResource(
    title: "Mindfulness Exercises",
    description: "Practice mindfulness techniques for daily stress",
    category: "Exercise",
    icon: FontAwesomeIcons.spa,
    color: Colors.purple,
  ),
  MentalHealthResource(
    title: "Crisis Helpline",
    description: "24/7 support for mental health emergencies",
    category: "Hotline",
    icon: FontAwesomeIcons.phone,
    color: Colors.red,
  ),
  MentalHealthResource(
    title: "Therapy Directory",
    description: "Find licensed therapists in your area",
    category: "Directory",
    icon: FontAwesomeIcons.locationDot,
    color: Colors.teal,
  ),
  MentalHealthResource(
    title: "Mental Health Podcast",
    description: "Listen to experts discuss mental wellness topics",
    category: "Podcast",
    icon: FontAwesomeIcons.podcast,
    color: Colors.orange,
  ),
];

class SocialWellbeingScreen extends StatelessWidget {
  const SocialWellbeingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context); // If there's a previous screen
          },
        ),
        title: const Text('Social Wellbeing'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bell),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.brown[200], // A light brown background
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.solidFaceSmile,
                              color: Colors.brown, // Darker brown icon color
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 15),
                          const Text(
                            '81',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown, // Dark brown color for the number
                            ),
                          ),
                          const Text(
                            'pts',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.brown, // Dark brown color for 'pts'
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Connected and supported',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const FaIcon(FontAwesomeIcons.solidCalendarDays, color: Colors.deepPurple),
                              const SizedBox(width: 10),
                              Text(
                                'December 2025',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.chevronDown, size: 20, color: Colors.deepPurple),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildCalendarGrid(context),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Insights',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _buildInsightCard(context, "Your social score has been trending up this week!",
                  FaIcon(FontAwesomeIcons.arrowTrendUp, color: Colors.green[600]!)),
              _buildInsightCard(context, "Consider reaching out to someone you haven't spoken to in a while.",
                  FaIcon(FontAwesomeIcons.personCircleQuestion, color: Colors.orange[600]!)),
              const SizedBox(height: 20),
              Text(
                'Recent Interactions',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _buildRecentInteractionsList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SocialWellbeingGraphScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'View Detailed Analytics',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid(BuildContext context) {
    List<String> daysOfWeek = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: daysOfWeek.map((day) => Text(day, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold))).toList(),
        ),
        const SizedBox(height: 10),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 1.0,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: 35, // 5 rows * 7 days
          itemBuilder: (context, index) {
            int dayNumber;
            // Assuming December 2025 starts on a Monday (day 29 is a Monday)
            // Day 1 of December 2025 is a Monday. We need to adjust.
            // Let's simplify for the example and just fill the grid.
            if (index < 2) { // Days 29, 30 of November
              dayNumber = 29 + index;
            } else {
              dayNumber = index - 1; // December starts from index 2 for day 1
              if (dayNumber > 31) dayNumber = dayNumber - 31; // For next month, if needed
            }


            // For the sake of matching the image, let's hardcode the date range.
            // The image shows Nov 29, 30 and Dec 1-12.
            int displayDay;
            bool isCurrentMonth = true;
            if (index < 2) { // 29, 30 from previous month
              displayDay = index + 29;
              isCurrentMonth = false;
            } else if (index < 33) { // Dec 1 to Dec 31
              displayDay = index - 1; // Dec 1 is at index 2
            } else { // Next month (Jan)
              displayDay = index - 32;
            }

            // Adjust for the specific calendar layout in the image
            // Nov 29, 30, then Dec 1-5, then 6-12 (with 11 crossed out)
            if (index == 0) displayDay = 29;
            if (index == 1) displayDay = 30;
            if (index >= 2 && index <= 32) displayDay = index - 1;


            List<bool>? dots = calendarData[displayDay];
            bool isCrossedOut = (displayDay == 11 && index == 12); // Specific to image, day 11 is crossed out on the 3rd week, index 12 in the grid

            Color dayColor = (isCurrentMonth && displayDay >= 1 && displayDay <= 31) ? Colors.black87 : Colors.grey;

            return GestureDetector(
              onTap: () {
                // Handle day selection
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isCrossedOut ? Colors.red.withAlpha(_alphaFromOpacity(0.1)) : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$displayDay',
                      style: TextStyle(
                        color: isCrossedOut ? Colors.red : dayColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (dots != null && dots.isNotEmpty && !isCrossedOut)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: dots.map((_) => Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          width: 4,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )).toList(),
                      ),
                    if (isCrossedOut)
                      const FaIcon(FontAwesomeIcons.xmark, color: Colors.red, size: 16),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInsightCard(BuildContext context, String text, FaIcon icon) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentInteractionsList() {
    return Column(
      children: List.generate(recentActivities.length, (index) {
        final activity = recentActivities[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: activity.color.withAlpha(_alphaFromOpacity(0.2)),
                  child: FaIcon(activity.icon, color: activity.color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.name,
                      ),
                      Text(
                        activity.type.name.capitalizeFirst(),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${Random().nextInt(60)} min ago', // Dummy time
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class SocialWellbeingGraphScreen extends StatelessWidget {
  const SocialWellbeingGraphScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Social Wellbeing'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.gear),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.brown[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.solidFaceSmile,
                                color: Colors.brown,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '78 pts',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontSize: 40,
                                    color: Colors.brown,
                                  ),
                                ),
                                Text(
                                  'Socialize with other people more!',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Dummy graph illustration
                      Container(
                        height: 200,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[50],
                        ),
                        child: CustomPaint(
                          painter: SocialWellbeingGraphPainter(socialScores),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: ['1 Day', '1 Week', '1 Month', '1 Year'].map((text) {
                            bool isSelected = text == '1 Week'; // Highlight '1 Week' as in the image
                            return ChoiceChip(
                              label: Text(text),
                              selected: isSelected,
                              selectedColor: Theme.of(context).primaryColor,
                              labelStyle: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                              onSelected: (selected) {
                                // Handle time range selection
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Health Journal',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 100, // Fixed height for the journal card
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple[100],
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              '${Random().nextInt(365) + 1}/365', // Random day of the year
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            journalEntries[Random().nextInt(journalEntries.length)], // Random journal entry
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 15),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey[600]),
                          onPressed: () {
                            // Navigate to full journal
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Tips for Better Social Wellbeing',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _buildTipCard(context, "Reach out to 3 friends this week.", FontAwesomeIcons.peopleGroup, Colors.pink),
              _buildTipCard(context, "Join a local club or group.", FontAwesomeIcons.usersLine, Colors.teal),
              _buildTipCard(context, "Practice active listening in conversations.", FontAwesomeIcons.handshake, Colors.blueGrey),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.plus, color: Colors.white, size: 30),
                    onPressed: () {
                      // Add new entry/activity
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTipCard(BuildContext context, String text, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withAlpha(_alphaFromOpacity(0.2)),
              child: FaIcon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
              ),
            ),
            FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey[400], size: 18),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the social wellbeing graph
class SocialWellbeingGraphPainter extends CustomPainter {
  final List<int> scores;

  SocialWellbeingGraphPainter(this.scores);

  @override
  void paint(Canvas canvas, Size size) {
    if (scores.isEmpty) return;

    final Paint linePaint = Paint()
      ..color = Colors.greenAccent[700]!
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.greenAccent[400]!.withAlpha(_alphaFromOpacity(0.5)),
          Colors.greenAccent[400]!.withAlpha(_alphaFromOpacity(0.1)),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final Paint dotPaint = Paint()
      ..color = Colors.greenAccent[700]!
      ..style = PaintingStyle.fill;

    final Paint _ = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    final double maxScore = scores.reduce(max).toDouble();
    final double minScore = scores.reduce(min).toDouble();
    final double _ = maxScore - minScore;

    final double xSpacing = size.width / (scores.length - 1);

    Path path = Path();
    Path fillPath = Path();

    // Draw Y-axis labels
    final TextPainter tpY = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw horizontal grid lines and Y-axis labels
    List<int> yLabels = [30, 50, 60, 70, 80, 90];
    for (int label in yLabels) {
      double y = size.height - (label - minScore) / (maxScore - minScore) * size.height;
      if (y < 0 || y > size.height) { // Ensure label is within bounds, adjust calculation if minScore is too low
        y = size.height - (label / 100) * size.height; // Fallback for simple percentage
      }
      tpY.text = TextSpan(text: '$label', style: const TextStyle(color: Colors.grey, fontSize: 10));
      tpY.layout();
      tpY.paint(canvas, Offset(-tpY.width - 5, y - tpY.height / 2));

      // Draw dashed line
      Paint dashPaint = Paint()
        ..color = Colors.grey.withAlpha(_alphaFromOpacity(0.3))
        ..strokeWidth = 0.5;
      double dashWidth = 5;
      double dashSpace = 5;
      double startX = 0;
      while (startX < size.width) {
        canvas.drawLine(Offset(startX, y), Offset(startX + dashWidth, y), dashPaint);
        startX += dashWidth + dashSpace;
      }
    }


    for (int i = 0; i < scores.length; i++) {
      double x = i * xSpacing;
      // Normalize score to height (0 to 1) and invert because Y-axis grows downwards
      double normalizedScore = (scores[i] - minScore) / (maxScore - minScore);
      double y = size.height - (normalizedScore * size.height);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height); // Start fill from bottom
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }

      // Draw score labels at specific points (e.g., peak values like 75.2, 80.1, 40)
      if (scores[i] == 75 || scores[i] == 80 || scores[i] == 40) { // Using approximate values for example
        final TextPainter tp = TextPainter(
          text: TextSpan(
            text: scores[i].toStringAsFixed(0), // No decimal for simplicity
            style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
          ),
          textDirection: TextDirection.ltr,
        );
        tp.layout();
        canvas.drawRect(
            Rect.fromLTWH(x - tp.width / 2 - 5, y - tp.height - 10, tp.width + 10, tp.height + 5),
            Paint()..color = Colors.green.withAlpha(_alphaFromOpacity(0.2))..style = PaintingStyle.fill..maskFilter = MaskFilter.blur(BlurStyle.normal, 5) // Soft blur for background
        );
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x - tp.width / 2 - 5, y - tp.height - 10, tp.width + 10, tp.height + 5),
            const Radius.circular(5),
          ),
          Paint()..color = Colors.green.withAlpha(_alphaFromOpacity(0.2)),
        );
        tp.paint(canvas, Offset(x - tp.width / 2, y - tp.height - 7));
      }
    }

    fillPath.lineTo(size.width, size.height); // End fill path at bottom right
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    // Draw dots on the line
    for (int i = 0; i < scores.length; i++) {
      double x = i * xSpacing;
      double normalizedScore = (scores[i] - minScore) / (maxScore - minScore);
      double y = size.height - (normalizedScore * size.height);
      canvas.drawCircle(Offset(x, y), 4.0, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// NEW SCREEN: Mood Tracker Screen
class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _slideController;
  MoodType? selectedMood;
  final TextEditingController _noteController = TextEditingController();

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
        curve: Curves.easeIn,
      ),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animationController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _slideController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Mood Tracker'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.chartLine),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoodAnalyticsScreen()),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How are you feeling today?',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildMoodOption(MoodType.verySad, 'Very Sad', FontAwesomeIcons.faceSadTear, Colors.blueGrey),
                            _buildMoodOption(MoodType.sad, 'Sad', FontAwesomeIcons.faceFrown, Colors.blue),
                            _buildMoodOption(MoodType.neutral, 'Neutral', FontAwesomeIcons.faceMeh, Colors.grey),
                            _buildMoodOption(MoodType.happy, 'Happy', FontAwesomeIcons.faceSmile, Colors.green),
                            _buildMoodOption(MoodType.veryHappy, 'Very Happy', FontAwesomeIcons.faceGrinStars, Colors.yellow),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _noteController,
                          decoration: InputDecoration(
                            hintText: 'Add a note about your day...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          maxLines: 3,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (selectedMood != null) {
                                // Save mood entry
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Mood recorded successfully!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                _noteController.clear();
                                setState(() {
                                  selectedMood = null;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please select your mood'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Save Mood',
                              style: TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Recent Moods',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 10),
                _buildMoodHistoryList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodOption(MoodType mood, String label, IconData icon, Color color) {
    bool isSelected = selectedMood == mood;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = mood;
        });
      },
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? color.withAlpha(_alphaFromOpacity(0.2)) : Colors.grey[200],
              borderRadius: BorderRadius.circular(15),
              border: isSelected ? Border.all(color: color, width: 2) : null,
            ),
            child: FaIcon(
              icon,
              color: isSelected ? color : Colors.grey[600],
              size: 25,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.grey[600],
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoodHistoryList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: moodEntries.length,
      itemBuilder: (context, index) {
        final entry = moodEntries[index];
        IconData icon;
        Color color;

        switch (entry.mood) {
          case MoodType.verySad:
            icon = FontAwesomeIcons.faceSadTear;
            color = Colors.blueGrey;
            break;
          case MoodType.sad:
            icon = FontAwesomeIcons.faceFrown;
            color = Colors.blue;
            break;
          case MoodType.neutral:
            icon = FontAwesomeIcons.faceMeh;
            color = Colors.grey;
            break;
          case MoodType.happy:
            icon = FontAwesomeIcons.faceSmile;
            color = Colors.green;
            break;
          case MoodType.veryHappy:
            icon = FontAwesomeIcons.faceGrinStars;
            color = Colors.yellow;
            break;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withAlpha(_alphaFromOpacity(0.2)),
                  child: FaIcon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.mood.name.capitalizeFirst(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        entry.note,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${entry.date.day}/${entry.date.month}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// NEW SCREEN: Mood Analytics Screen
class MoodAnalyticsScreen extends StatelessWidget {
  const MoodAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Mood Analytics'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.download),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mood Overview',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 200,
                        child: MoodChart(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMoodStat('Average Mood', 'Happy', Colors.green),
                          _buildMoodStat('Best Day', 'Monday', Colors.blue),
                          _buildMoodStat('Improvement', '+12%', Colors.purple),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Mood Patterns',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _buildPatternCard(
                context,
                "Your mood tends to be better on weekends",
                FontAwesomeIcons.calendarDays,
                Colors.blue,
                "You're 30% happier on Saturdays and Sundays",
              ),
              _buildPatternCard(
                context,
                "Your mood improves after exercise",
                FontAwesomeIcons.personRunning,
                Colors.green,
                "On days you exercise, your mood is 25% better",
              ),
              _buildPatternCard(
                context,
                "Social interactions boost your mood",
                FontAwesomeIcons.peopleGroup,
                Colors.purple,
                "After social activities, your mood improves by 40%",
              ),
              const SizedBox(height: 20),
              Text(
                'Mood Insights',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _buildInsightCard(
                context,
                "Your mood has been improving over the past month",
                FontAwesomeIcons.arrowTrendUp,
                Colors.green,
              ),
              _buildInsightCard(
                context,
                "You tend to feel better in the morning",
                FontAwesomeIcons.sun,
                Colors.orange,
              ),
              _buildInsightCard(
                context,
                "Try to maintain your current routine as it's working well for you",
                FontAwesomeIcons.circleCheck,
                Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodStat(String title, String value, Color color) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPatternCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withAlpha(_alphaFromOpacity(0.2)),
                  child: FaIcon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, String text, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withAlpha(_alphaFromOpacity(0.2)),
              child: FaIcon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// NEW SCREEN: Meditation Screen
class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  bool isPlaying = false;
  int selectedSession = 0;

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
        curve: Curves.easeIn,
      ),
    );

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Meditation & Relaxation'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.headphones),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Breathing Exercise',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: AnimatedBuilder(
                            animation: _breathingAnimation,
                            builder: (context, child) {
                              return Transform.scale(
                                scale: isPlaying ? _breathingAnimation.value : 1.0,
                                child: Container(
                                  width: 150,
                                  height: 150,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withAlpha(_alphaFromOpacity(0.1)),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      isPlaying ? 'Breathe In' : 'Start',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isPlaying = !isPlaying;
                                if (isPlaying) {
                                  _breathingController.repeat(reverse: true);
                                } else {
                                  _breathingController.stop();
                                  _breathingController.reset();
                                }
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Text(
                              isPlaying ? 'Stop' : 'Start Breathing',
                              style: const TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Guided Meditations',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 10),
                _buildMeditationSessionsList(),
                const SizedBox(height: 20),
                Text(
                  'Relaxation Tips',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                ),
                const SizedBox(height: 10),
                _buildRelaxationTipCard(
                  context,
                  "Practice progressive muscle relaxation",
                  FontAwesomeIcons.person,
                  Colors.blue,
                  "Tense and then relax each muscle group in your body",
                ),
                _buildRelaxationTipCard(
                  context,
                  "Try visualization techniques",
                  FontAwesomeIcons.image,
                  Colors.green,
                  "Imagine yourself in a peaceful place",
                ),
                _buildRelaxationTipCard(
                  context,
                  "Listen to calming music",
                  FontAwesomeIcons.music,
                  Colors.purple,
                  "Nature sounds or classical music can help reduce stress",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMeditationSessionsList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: meditationSessions.length,
      itemBuilder: (context, index) {
        final session = meditationSessions[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: session.color.withAlpha(_alphaFromOpacity(0.2)),
                  child: FaIcon(session.icon, color: session.color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        session.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '${session.duration} min',
                      style: TextStyle(
                        color: session.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.play,
                        color: session.color,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MeditationPlayerScreen(session: session)),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRelaxationTipCard(BuildContext context, String title, IconData icon, Color color, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withAlpha(_alphaFromOpacity(0.2)),
                  child: FaIcon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}

// NEW SCREEN: Meditation Player Screen
class MeditationPlayerScreen extends StatefulWidget {
  final MeditationSession session;

  const MeditationPlayerScreen({super.key, required this.session});

  @override
  State<MeditationPlayerScreen> createState() => _MeditationPlayerScreenState();
}

class _MeditationPlayerScreenState extends State<MeditationPlayerScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  bool isPlaying = false;
  double progress = 0.0;
  int remainingSeconds = 0;

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
        curve: Curves.easeIn,
      ),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.session.duration * 60),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.linear,
      ),
    )..addListener(() {
      setState(() {
        progress = _progressAnimation.value;
        remainingSeconds = ((1 - progress) * widget.session.duration * 60).round();
      });
    });

    remainingSeconds = widget.session.duration * 60;
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.session.title),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: widget.session.color.withAlpha(_alphaFromOpacity(0.1)),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.session.color,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: FaIcon(
                    widget.session.icon,
                    color: widget.session.color,
                    size: 80,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                widget.session.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 10),
              Text(
                widget.session.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Column(
                children: [
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(widget.session.color),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _formatDuration(remainingSeconds),
                    style: TextStyle(
                      color: widget.session.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.backward,
                      color: widget.session.color,
                      size: 30,
                    ),
                    onPressed: () {
                      // Rewind 10 seconds
                      double newPosition = progress - 0.1;
                      if (newPosition < 0) newPosition = 0;
                      _progressController.animateTo(newPosition);
                    },
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: widget.session.color,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: FaIcon(
                        isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          isPlaying = !isPlaying;
                          if (isPlaying) {
                            _progressController.forward();
                          } else {
                            _progressController.stop();
                          }
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.forward,
                      color: widget.session.color,
                      size: 30,
                    ),
                    onPressed: () {
                      // Fast forward 10 seconds
                      double newPosition = progress + 0.1;
                      if (newPosition > 1) newPosition = 1;
                      _progressController.animateTo(newPosition);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Text(
                'Find a comfortable position, close your eyes, and focus on your breathing.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

// NEW SCREEN: Mental Health Resources Screen
class MentalHealthResourcesScreen extends StatelessWidget {
  const MentalHealthResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Mental Health Resources'),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bookmark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Crisis Support',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.red.withAlpha(_alphaFromOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.red),
                              ),
                              child: Column(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.phone,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Crisis Helpline',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '1-800-273-8255',
                                    style: TextStyle(
                                      color: Colors.red,
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
                                color: Colors.blue.withAlpha(_alphaFromOpacity(0.1)),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.blue),
                              ),
                              child: Column(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.comments,
                                    color: Colors.blue,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    'Text Support',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Text HOME to 741741',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
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
              ),
              const SizedBox(height: 20),
              Text(
                'Resources',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              _buildResourcesList(),
              const SizedBox(height: 20),
              Text(
                'Professional Help',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 10),
              Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Dr. James Wilson',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'Psychologist | 10 years experience',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: Theme.of(context).primaryColor),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'View Profile',
                                style: TextStyle(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text(
                                'Book Session',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildResourcesList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: mentalHealthResources.length,
      itemBuilder: (context, index) {
        final resource = mentalHealthResources[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: resource.color.withAlpha(_alphaFromOpacity(0.2)),
                  child: FaIcon(resource.icon, color: resource.color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              resource.title,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: resource.color.withAlpha(_alphaFromOpacity(0.1)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              resource.category,
                              style: TextStyle(
                                color: resource.color,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        resource.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey[400],
                    size: 18,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Mood Chart Widget
class MoodChart extends StatelessWidget {
  const MoodChart({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MoodChartPainter(),
      size: const Size(double.infinity, 200),
    );
  }
}

class MoodChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width;
    final double height = size.height;
    final double padding = 20;
    final double chartWidth = width - 2 * padding;
    final double chartHeight = height - 2 * padding;

    // Draw grid lines
    final Paint gridPaint = Paint()
      ..color = Colors.grey.withAlpha(_alphaFromOpacity(0.3))
      ..strokeWidth = 0.5;

    // Draw horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final double y = padding + i * (chartHeight / 4);
      canvas.drawLine(Offset(padding, y), Offset(width - padding, y), gridPaint);
    }

    // Draw vertical grid lines
    for (int i = 0; i <= 6; i++) {
      final double x = padding + i * (chartWidth / 6);
      canvas.drawLine(Offset(x, padding), Offset(x, height - padding), gridPaint);
    }

    // Draw mood line
    final Paint linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.purple.withAlpha(_alphaFromOpacity(0.5)),
          Colors.purple.withAlpha(_alphaFromOpacity(0.1)),
        ],
      ).createShader(Rect.fromLTWH(padding, padding, chartWidth, chartHeight));

    final List<Offset> points = [
      Offset(padding + 0 * (chartWidth / 6), padding + 2 * (chartHeight / 4)), // Very Sad
      Offset(padding + 1 * (chartWidth / 6), padding + 1.5 * (chartHeight / 4)), // Sad
      Offset(padding + 2 * (chartWidth / 6), padding + 2 * (chartHeight / 4)), // Neutral
      Offset(padding + 3 * (chartWidth / 6), padding + 1 * (chartHeight / 4)), // Happy
      Offset(padding + 4 * (chartWidth / 6), padding + 0.5 * (chartHeight / 4)), // Happy
      Offset(padding + 5 * (chartWidth / 6), padding + 0 * (chartHeight / 4)), // Very Happy
      Offset(padding + 6 * (chartWidth / 6), padding + 0.5 * (chartHeight / 4)), // Happy
    ];

    // Create path for the line
    final Path path = Path();
    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // Create path for the fill
    final Path fillPath = Path();
    fillPath.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      fillPath.lineTo(points[i].dx, points[i].dy);
    }
    fillPath.lineTo(points.last.dx, height - padding);
    fillPath.lineTo(points.first.dx, height - padding);
    fillPath.close();

    // Draw fill
    canvas.drawPath(fillPath, fillPaint);

    // Draw line
    canvas.drawPath(path, linePaint);

    // Draw points
    final Paint pointPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    for (final point in points) {
      canvas.drawCircle(point, 5.0, pointPaint);
    }

    // Draw labels
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // Draw mood labels
    final List<String> moodLabels = ['Very Sad', 'Sad', 'Neutral', 'Happy', 'Very Happy'];
    for (int i = 0; i < moodLabels.length; i++) {
      final double y = padding + (4 - i) * (chartHeight / 4);
      textPainter.text = TextSpan(
        text: moodLabels[i],
        style: TextStyle(color: Colors.grey[600], fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(5, y - textPainter.height / 2));
    }

    // Draw day labels
    final List<String> dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < dayLabels.length; i++) {
      final double x = padding + i * (chartWidth / 6);
      textPainter.text = TextSpan(
        text: dayLabels[i],
        style: TextStyle(color: Colors.grey[600], fontSize: 10),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, height - padding + 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

extension StringExtension on String {
  String capitalizeFirst() {
    if (isEmpty) {
      return this;
    }
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}