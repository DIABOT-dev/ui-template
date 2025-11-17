import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Helper function to map mood strings to Font Awesome Icons
IconData getMoodIcon(String mood) {
  switch (mood) {
    case 'Overjoyed':
      return FontAwesomeIcons.faceLaughBeam;
    case 'Happy':
      return FontAwesomeIcons.faceSmileBeam;
    case 'Neutral':
      return FontAwesomeIcons.faceMeh;
    case 'Sad':
      return FontAwesomeIcons.faceFrownOpen;
    case 'Depressed':
      return FontAwesomeIcons.faceSadTear;
    default:
      return FontAwesomeIcons.faceSmile; // Default icon
  }
}

// Helper function to get color for mood
Color getMoodColor(String mood) {
  switch (mood) {
    case 'Overjoyed':
      return Colors.yellow.shade700;
    case 'Happy':
      return Colors.green.shade600;
    case 'Neutral':
      return Colors.grey.shade500;
    case 'Sad':
      return Colors.blue.shade600;
    case 'Depressed':
      return Colors.indigo.shade800;
    default:
      return Colors.blue;
  }
}

// Helper function to get month name
String getMonthName(int month) {
  const monthNames = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];
  return monthNames[month - 1];
}

// Dummy data models
class MoodEntry {
  final DateTime date;
  final String mood;
  final String note;
  final List<String> factors;
  final List<String> activities;

  MoodEntry({
    required this.date,
    required this.mood,
    required this.note,
    required this.factors,
    required this.activities,
  });
}

// Mood History Screen
class MoodHistoryScreen extends StatefulWidget {
  const MoodHistoryScreen({super.key});

  @override
  State<MoodHistoryScreen> createState() => _MoodHistoryScreenState();
}

class _MoodHistoryScreenState extends State<MoodHistoryScreen> with TickerProviderStateMixin {
  final DateTime now = DateTime.now();
  late DateTime focusedMonth;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Dummy data for mood entries
  List<MoodEntry> allMoods = [
    MoodEntry(
      date: DateTime(2024, 1, 1),
      mood: 'Overjoyed',
      note: 'Had a great day at work. Completed all tasks and received appreciation from the team.',
      factors: ['Work', 'Exercise', 'Social'],
      activities: ['Morning Meditation', 'Jogging', 'Reading'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 3),
      mood: 'Happy',
      note: 'Spent quality time with family. Went out for dinner and watched a movie together.',
      factors: ['Family', 'Leisure'],
      activities: ['Family Dinner', 'Movie Night'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 5),
      mood: 'Sad',
      note: 'Feeling down due to bad weather. Stayed indoors all day.',
      factors: ['Weather', 'Health'],
      activities: ['Resting', 'Watching TV'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 7),
      mood: 'Neutral',
      note: 'Regular day. Nothing special happened.',
      factors: ['Routine'],
      activities: ['Work', 'Grocery Shopping'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 8),
      mood: 'Depressed',
      note: 'Feeling overwhelmed with work and personal issues.',
      factors: ['Work', 'Stress'],
      activities: ['Work', 'Therapy Session'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 10),
      mood: 'Overjoyed',
      note: 'Received good news about a promotion at work!',
      factors: ['Work', 'Achievement'],
      activities: ['Celebration Dinner', 'Called Friends'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 12),
      mood: 'Happy',
      note: 'Had a productive day and finished all my tasks ahead of schedule.',
      factors: ['Work', 'Productivity'],
      activities: ['Work', 'Evening Walk'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 15),
      mood: 'Sad',
      note: 'Missing my friends who live far away.',
      factors: ['Social', 'Loneliness'],
      activities: ['Video Call', 'Journaling'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 18),
      mood: 'Neutral',
      note: 'Quiet day. Did some chores around the house.',
      factors: ['Routine'],
      activities: ['Cleaning', 'Cooking'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 20),
      mood: 'Depressed',
      note: 'Feeling unmotivated and tired. Slept most of the day.',
      factors: ['Health', 'Fatigue'],
      activities: ['Resting', 'Listening to Music'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 22),
      mood: 'Overjoyed',
      note: 'Went on a hiking trip with friends. Beautiful weather and scenery!',
      factors: ['Nature', 'Social', 'Exercise'],
      activities: ['Hiking', 'Photography', 'Picnic'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 25),
      mood: 'Happy',
      note: 'Finished reading a great book. Learned a lot from it.',
      factors: ['Learning', 'Leisure'],
      activities: ['Reading', 'Book Club Meeting'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 28),
      mood: 'Sad',
      note: 'Argument with a close friend. Feeling upset about it.',
      factors: ['Relationship', 'Conflict'],
      activities: ['Journaling', 'Meditation'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 29),
      mood: 'Neutral',
      note: 'Resolving the conflict with my friend. Feeling better.',
      factors: ['Relationship', 'Communication'],
      activities: ['Talking with Friend', 'Reflecting'],
    ),
    MoodEntry(
      date: DateTime(2024, 1, 31),
      mood: 'Overjoyed',
      note: 'Month ended on a high note! Made plans for February.',
      factors: ['Planning', 'Optimism'],
      activities: ['Planning', 'Celebrating'],
    ),
    // February moods
    MoodEntry(
      date: DateTime(2024, 2, 2),
      mood: 'Happy',
      note: 'Started February with positive energy. Set new goals.',
      factors: ['Motivation', 'Planning'],
      activities: ['Goal Setting', 'Morning Run'],
    ),
    MoodEntry(
      date: DateTime(2024, 2, 5),
      mood: 'Neutral',
      note: 'Regular work day. Nothing special to report.',
      factors: ['Routine'],
      activities: ['Work', 'Gym'],
    ),
    MoodEntry(
      date: DateTime(2024, 2, 8),
      mood: 'Sad',
      note: 'Feeling under the weather. Caught a cold.',
      factors: ['Health', 'Weather'],
      activities: ['Resting', 'Taking Medicine'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    focusedMonth = DateTime(now.year, now.month, 1);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void goToPreviousMonth() {
    setState(() {
      focusedMonth = DateTime(focusedMonth.year, focusedMonth.month - 1, 1);
    });
    _animationController.reset();
    _animationController.forward();
  }

  void goToNextMonth() {
    setState(() {
      focusedMonth = DateTime(focusedMonth.year, focusedMonth.month + 1, 1);
    });
    _animationController.reset();
    _animationController.forward();
  }

  Map<int, MoodEntry> getMoodsForMonth(DateTime month) {
    final Map<int, MoodEntry> moods = {};
    for (var entry in allMoods) {
      if (entry.date.year == month.year && entry.date.month == month.month) {
        moods[entry.date.day] = entry;
      }
    }
    return moods;
  }

  List<DateTime> getDaysInMonth(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    List<DateTime> days = [];
    int weekdayOfFirstDay = firstDayOfMonth.weekday;
    int daysToPrepend = weekdayOfFirstDay == 7 ? 6 : weekdayOfFirstDay - 1;

    for (int i = daysToPrepend; i > 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i)));
    }

    for (int i = 0; i <= lastDayOfMonth.day - firstDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    int daysToAppend = 7 - (days.length % 7);
    if (daysToAppend == 7) daysToAppend = 0;

    for (int i = 1; i <= daysToAppend; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i)));
    }

    return days;
  }

  Widget buildMoodCalendar() {
    final currentMonthMoods = getMoodsForMonth(focusedMonth);
    final daysInView = getDaysInMonth(focusedMonth);
    const List<String> weekdayAbbreviations = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.chevronLeft, size: 16),
                  onPressed: goToPreviousMonth,
                ),
                Text(
                  '${getMonthName(focusedMonth.month)} ${focusedMonth.year}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.chevronRight, size: 16),
                  onPressed: goToNextMonth,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekdayAbbreviations.map((day) {
                return Text(
                  day,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade600,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.0,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
              ),
              itemCount: daysInView.length,
              itemBuilder: (context, index) {
                final day = daysInView[index];
                final isCurrentMonth = day.month == focusedMonth.month;
                final isToday = day.year == now.year && day.month == now.month && day.day == now.day;
                final moodForDay = currentMonthMoods[day.day];

                return GestureDetector(
                  onTap: () {
                    if (isCurrentMonth && moodForDay != null) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              MoodDetailScreen(moodEntry: moodForDay),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(0.0, 1.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;
                            var tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve),
                            );
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    decoration: BoxDecoration(
                      color: isToday
                          ? Colors.blue.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: isToday
                          ? Border.all(color: Colors.blue, width: 1.5)
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${day.day}',
                          style: TextStyle(
                            color: isCurrentMonth
                                ? Colors.black87
                                : Colors.grey.withValues(alpha: 0.6),
                            fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                        if (moodForDay != null && isCurrentMonth)
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: Icon(
                              getMoodIcon(moodForDay.mood),
                              size: 20,
                              color: getMoodColor(moodForDay.mood),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMoodListView() {
    final currentMonthListMoods = allMoods.where((entry) =>
    entry.date.year == focusedMonth.year && entry.date.month == focusedMonth.month).toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'All Moods (${currentMonthListMoods.length})',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: currentMonthListMoods.length,
              itemBuilder: (context, index) {
                final entry = currentMonthListMoods[index];
                final dateFormatted = '${entry.date.day.toString().padLeft(2, '0')} ${getMonthName(entry.date.month).substring(0, 3).toUpperCase()}';
                final timeFormatted = '${entry.date.hour.toString().padLeft(2, '0')}:${entry.date.minute.toString().padLeft(2, '0')} ${entry.date.hour < 12 ? 'AM' : 'PM'}';

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) =>
                                MoodDetailScreen(moodEntry: entry),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'mood_icon_${entry.date.toIso8601String()}',
                              child: Material(
                                color: Colors.transparent,
                                child: Icon(
                                  getMoodIcon(entry.mood),
                                  size: 32,
                                  color: getMoodColor(entry.mood),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    entry.mood,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    dateFormatted,
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  timeFormatted,
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '115sys',
                                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isCalendarView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.black87, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mood History',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.chartLine, color: Colors.black87, size: 20),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                  const MoodAnalysisScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(1.0, 0.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end).chain(
                      CurveTween(curve: curve),
                    );
                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.ellipsisVertical, color: Colors.black87, size: 20),
            onPressed: () {
              // Handle more options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildToggleButton('List View', !isCalendarView),
                const SizedBox(width: 16),
                buildToggleButton('Calendar View', isCalendarView),
              ],
            ),
          ),
          Expanded(
            child: isCalendarView ? buildMoodCalendar() : buildMoodListView(),
          ),
        ],
      ),
    );
  }

  Widget buildToggleButton(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isCalendarView = text == 'Calendar View';
        });
        _animationController.reset();
        _animationController.forward();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Mood Detail Screen
class MoodDetailScreen extends StatefulWidget {
  final MoodEntry moodEntry;

  const MoodDetailScreen({super.key, required this.moodEntry});

  @override
  State<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends State<MoodDetailScreen> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.elasticOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted =
        '${widget.moodEntry.date.day} ${getMonthName(widget.moodEntry.date.month)} ${widget.moodEntry.date.year}';
    final timeFormatted = '${widget.moodEntry.date.hour.toString().padLeft(2, '0')}:${widget.moodEntry.date.minute.toString().padLeft(2, '0')} ${widget.moodEntry.date.hour < 12 ? 'AM' : 'PM'}';

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.black87, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mood Details',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood icon and name with animation
            Center(
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Hero(
                  tag: 'mood_icon_${widget.moodEntry.date.toIso8601String()}',
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: getMoodColor(widget.moodEntry.mood).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: getMoodColor(widget.moodEntry.mood).withValues(alpha: 0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Icon(
                        getMoodIcon(widget.moodEntry.mood),
                        size: 80,
                        color: getMoodColor(widget.moodEntry.mood),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: Text(
                  widget.moodEntry.mood,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: getMoodColor(widget.moodEntry.mood),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: Text(
                  dateFormatted,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SlideTransition(
              position: _slideAnimation,
              child: Center(
                child: Text(
                  timeFormatted,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Additional details
            SlideTransition(
              position: _slideAnimation,
              child: const Text(
                'Notes',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Text(
                  widget.moodEntry.note,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _slideAnimation,
              child: const Text(
                'Factors',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SlideTransition(
              position: _slideAnimation,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: widget.moodEntry.factors.map((factor) {
                  return _buildFactorChip(factor);
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _slideAnimation,
              child: const Text(
                'Activities',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: widget.moodEntry.activities.map((activity) {
                    return _buildActivityItem(activity);
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SlideTransition(
              position: _slideAnimation,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                        const MoodAnalysisScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end).chain(
                            CurveTween(curve: curve),
                          );
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesomeIcons.chartLine,
                        color: Colors.blue,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'View Mood Analysis',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactorChip(String label) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActivityItem(String activity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.circleCheck,
            color: Colors.green,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              activity,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Mood Analysis Screen
class MoodAnalysisScreen extends StatefulWidget {
  const MoodAnalysisScreen({super.key});

  @override
  State<MoodAnalysisScreen> createState() => _MoodAnalysisScreenState();
}

class _MoodAnalysisScreenState extends State<MoodAnalysisScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeInOut,
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeController.forward();
    _scaleController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.black87, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mood Analysis',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User profile card
            FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'John Doe',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Member since Jan 2024',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        FontAwesomeIcons.chartLine,
                        color: Colors.blue,
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Mood statistics
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Mood Statistics',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildBarChart(),
                    const SizedBox(height: 16),
                    const Text(
                      'Mood Distribution',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 7),
            // Mood insights
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Insights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 9),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildInsightItem(
                      icon: FontAwesomeIcons.faceSmileBeam,
                      color: Colors.green,
                      title: 'Most Frequent Mood',
                      value: 'Happy',
                    ),
                    const SizedBox(height: 16),
                    _buildInsightItem(
                      icon: FontAwesomeIcons.chartBar,
                      color: Colors.blue,
                      title: 'Average Mood Score',
                      value: '7.2/10',
                    ),
                    const SizedBox(height: 16),
                    _buildInsightItem(
                      icon: FontAwesomeIcons.calendarCheck,
                      color: Colors.purple,
                      title: 'Best Day',
                      value: 'Friday',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Recommendations
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                'Recommendations',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    _buildRecommendationItem(
                      title: 'Try Meditation',
                      description: 'Meditation can help improve your mood and reduce stress.',
                    ),
                    const SizedBox(height: 16),
                    _buildRecommendationItem(
                      title: 'Exercise Regularly',
                      description: 'Physical activity releases endorphins that can boost your mood.',
                    ),
                    const SizedBox(height: 16),
                    _buildRecommendationItem(
                      title: 'Connect with Friends',
                      description: 'Social interaction is important for mental wellbeing.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarChart() {
    // Dummy data for the bar chart
    final List<Map<String, dynamic>> moodData = [
      {'mood': 'Overjoyed', 'count': 5, 'color': Colors.yellow.shade700},
      {'mood': 'Happy', 'count': 8, 'color': Colors.green.shade600},
      {'mood': 'Neutral', 'count': 4, 'color': Colors.grey.shade500},
      {'mood': 'Sad', 'count': 3, 'color': Colors.blue.shade600},
      {'mood': 'Depressed', 'count': 2, 'color': Colors.indigo.shade800},
    ];

    // Find the maximum count to scale the bars
    final maxCount = moodData.map((e) => e['count'] as int).reduce((a, b) => a > b ? a : b);

    return Column(
      children: moodData.map((data) {
        final percentage = data['count'] / maxCount;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  data['mood'],
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: percentage,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          color: data['color'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${data['count']}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInsightItem({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationItem({
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            FontAwesomeIcons.lightbulb,
            color: Colors.amber,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Main function to run the app (for testing purposes)
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MoodHistoryScreen(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}