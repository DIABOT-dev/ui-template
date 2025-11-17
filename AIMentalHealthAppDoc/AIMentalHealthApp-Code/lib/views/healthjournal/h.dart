import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

// --- Global Helpers and Constants ---

/// Converts a decimal opacity (0.0 to 1.0) to an alpha value (0 to 255).
int _alphaFromOpacity(double opacity) {
  return (opacity * 255).round();
}

// Custom Color Palette extracted from the design image
const Color primaryBrown = Color(0xFF7F5E4B);
const Color accentGreen = Color(0xFF75A253);
const Color secondaryOrange = Color(0xFFD77D57);
const Color backgroundLightGrey = Color(0xFFF7F7F7);
const Color textDark = Color(0xFF4A4A4A);
const Color textLightGrey = Color(0xFFAAAAAA);
const Color cardWhite = Colors.white;
const Color accentBlue = Color(0xFF5D8BF4);
const Color accentPurple = Color(0xFF9B72CF);

/// Placeholder function to generate random person image URLs as requested.
String getPersonImageUrl(int seed) {
  return 'https://randomuser.me/api/portraits/men/$seed.jpg';
}

// --- Enum Definitions (Lowercase values as requested) ---

enum JournalType { text, voice, photo }

enum Mood {
  verysad,
  sad,
  neutral,
  happy,
  veryhappy,
}

// --- Data Models ---

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final Mood mood;
  final JournalType type;
  final List<String> tags;
  final String? imageUrl;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
    required this.type,
    this.tags = const [],
    this.imageUrl,
  });
}

// --- Sample Data ---

final List<JournalEntry> sampleJournalEntries = [
  JournalEntry(
    id: '1',
    title: 'Feeling Good Today',
    content: 'Had a great day at work. Met all my deadlines and had a nice chat with colleagues. Feeling productive and happy.',
    date: DateTime(2024, 11, 12, 9, 41),
    mood: Mood.happy,
    type: JournalType.text,
    tags: ['work', 'productive', 'social'],
  ),
  JournalEntry(
    id: '2',
    title: 'A Little Bit Stressed',
    content: 'Feeling overwhelmed with the workload today. Too many deadlines approaching and not enough time. Need to prioritize better.',
    date: DateTime(2024, 11, 11, 18, 20),
    mood: Mood.sad,
    type: JournalType.text,
    tags: ['stress', 'work', 'overwhelmed'],
  ),
  JournalEntry(
    id: '3',
    title: 'Morning Meditation',
    content: 'Started my day with a 20-minute meditation session. Feeling centered and ready to face the day.',
    date: DateTime(2024, 11, 10, 7, 30),
    mood: Mood.veryhappy,
    type: JournalType.text,
    tags: ['meditation', 'morning', 'wellness'],
  ),
  JournalEntry(
    id: '4',
    title: 'Difficult Conversation',
    content: 'Had a tough conversation with a friend today. It was necessary but emotionally draining.',
    date: DateTime(2024, 11, 9, 16, 45),
    mood: Mood.neutral,
    type: JournalType.text,
    tags: ['friends', 'emotional', 'communication'],
  ),
  JournalEntry(
    id: '5',
    title: 'Weekend Hike',
    content: 'Went for a beautiful hike in the mountains. Nature always helps me clear my mind and feel refreshed.',
    date: DateTime(2024, 11, 8, 14, 15),
    mood: Mood.veryhappy,
    type: JournalType.photo,
    tags: ['nature', 'exercise', 'weekend'],
    imageUrl: 'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?ixlib=rb-4.0.3',
  ),
];

// --- Common Widgets ---

/// A custom card widget for a modern, rounded look with animations.
class CustomCard extends StatefulWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final double? elevation;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.color = cardWhite,
    this.elevation,
    this.onTap,
  });

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _animationController.forward();
        });
      },
      onExit: (_) {
        setState(() {
          _animationController.reverse();
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: widget.padding,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(_alphaFromOpacity(0.05)),
                      blurRadius: widget.elevation ?? 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}

// --- Screen 1: Home/Dashboard (Health Journal) ---

class HealthJournal extends StatefulWidget {
  const HealthJournal({super.key});

  @override
  State<HealthJournal> createState() => _HealthJournalState();
}

class _HealthJournalState extends State<HealthJournal> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 325,
                decoration: const BoxDecoration(
                  color: primaryBrown,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative shapes to match design
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: primaryBrown.withAlpha(_alphaFromOpacity(0.1)),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(150),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: primaryBrown.withAlpha(_alphaFromOpacity(0.1)),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(100),
                            bottomLeft: Radius.circular(100),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 40, left: 12, right: 24, bottom: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // App Bar
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BackButton(color: Colors.white,),
                              IconButton(
                                icon: const Icon(Icons.grading_rounded,
                                    color: cardWhite, size: 30),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const JournalStatsScreen()),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Health Journal',
                            style: TextStyle(
                                color: cardWhite,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '34',
                                style: TextStyle(
                                    color: cardWhite,
                                    fontSize: 65,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: accentGreen.withAlpha(_alphaFromOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    '+12%',
                                    style: TextStyle(
                                        color: cardWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Journals this year',
                            style: TextStyle(
                                color: cardWhite,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                          const SizedBox(height: 4),
                          // Journal Statistics row
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              StatDot(color: accentGreen, label: 'Happy', count: 18),
                              StatDot(color: secondaryOrange, label: 'Mixed', count: 10),
                              StatDot(color: textLightGrey, label: 'Sad', count: 6),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(14.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewJournalTypeScreen()),
                    ),
                    child: const CustomCard(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Start New Journal',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Icon(Icons.add_circle,
                              color: primaryBrown, size: 30),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  // Recent Entries Preview
                  const Text('Recent Entries',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textDark)),
                  const SizedBox(height: 5),
                  ...sampleJournalEntries.take(3).map((entry) {
                    return RecentEntryCard(
                      title: entry.title,
                      date: '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                      moodColor: _getMoodColor(entry.mood),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JournalDetailScreen(entry: entry)),
                      ),
                    );
                  }),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyJournalsScreen()),
                    ),
                    child: const Text('View All Journals',
                        style: TextStyle(color: primaryBrown)),
                  ),
                  const SizedBox(height: 20),
                  // Mood Insights
                  const Text('Mood Insights',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: textDark)),
                  const SizedBox(height: 10),
                  CustomCard(
                    child: SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(
                            show: true,
                            drawVerticalLine: false,
                            getDrawingHorizontalLine: (value) => FlLine(
                              color: Colors.grey.withAlpha(_alphaFromOpacity(0.2)),
                              strokeWidth: 1,
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const style = TextStyle(color: textLightGrey, fontWeight: FontWeight.bold, fontSize: 12);
                                  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                                  if (value.toInt() >= 0 && value.toInt() < days.length) {
                                    return Text(days[value.toInt()], style: style);
                                  }
                                  return const Text('');
                                },
                                reservedSize: 30,
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const style = TextStyle(color: textLightGrey, fontWeight: FontWeight.bold, fontSize: 12);
                                  switch (value.toInt()) {
                                    case 1:
                                      return const Text('Very Sad', style: style);
                                    case 2:
                                      return const Text('Sad', style: style);
                                    case 3:
                                      return const Text('Neutral', style: style);
                                    case 4:
                                      return const Text('Happy', style: style);
                                    case 5:
                                      return const Text('Very Happy', style: style);
                                  }
                                  return const Text('');
                                },
                                reservedSize: 80,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: 6,
                          minY: 0,
                          maxY: 6,
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                const FlSpot(0, 3),
                                const FlSpot(1, 4),
                                const FlSpot(2, 2),
                                const FlSpot(3, 3),
                                const FlSpot(4, 5),
                                const FlSpot(5, 4),
                                const FlSpot(6, 3),
                              ],
                              isCurved: true,
                              color: primaryBrown,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                  radius: 4,
                                  color: primaryBrown,
                                  strokeWidth: 2,
                                  strokeColor: cardWhite,
                                ),
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: primaryBrown.withAlpha(_alphaFromOpacity(0.1)),
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMoodColor(Mood mood) {
    switch (mood) {
      case Mood.verysad:
        return Colors.blueGrey;
      case Mood.sad:
        return textLightGrey;
      case Mood.neutral:
        return secondaryOrange;
      case Mood.happy:
        return accentGreen;
      case Mood.veryhappy:
        return accentGreen;
    }
  }
}

class StatDot extends StatelessWidget {
  final Color color;
  final String label;
  final int count;

  const StatDot({
    super.key,
    required this.color,
    required this.label,
    this.count = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text('$count', style: const TextStyle(color: cardWhite, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: cardWhite)),
      ],
    );
  }
}

class RecentEntryCard extends StatelessWidget {
  final String title;
  final String date;
  final Color moodColor;
  final VoidCallback onTap;

  const RecentEntryCard({
    super.key,
    required this.title,
    required this.date,
    required this.moodColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: CustomCard(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: moodColor, shape: BoxShape.circle),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    Text(date,
                        style: const TextStyle(color: textLightGrey, fontSize: 13)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16, color: textLightGrey),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Screen 2: Journal Stats ---

class JournalStatsScreen extends StatefulWidget {
  const JournalStatsScreen({super.key});

  @override
  State<JournalStatsScreen> createState() => _JournalStatsScreenState();
}

class _JournalStatsScreenState extends State<JournalStatsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Journal Stats',
            style: TextStyle(
                color: textDark, fontWeight: FontWeight.bold, fontSize: 22)),
        actions: const [
          Icon(Icons.more_vert, color: textDark),
          SizedBox(width: 16),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('The Journal Stats',
                  style: TextStyle(fontSize: 16, color: textLightGrey)),
              const Text('Jan 2024 to Nov 2024',
                  style: TextStyle(
                      fontSize: 16,
                      color: textLightGrey,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 11),
              // Statistics Cards Row
              Row(
                children: [
                  Expanded(
                      child: StatMetricCard(
                          count: 44,
                          label: 'Happy',
                          color: accentGreen,
                          icon: Icons.tag_faces)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: StatMetricCard(
                          count: 32,
                          label: 'Mixed',
                          color: secondaryOrange,
                          icon: Icons.sentiment_neutral)),
                  const SizedBox(width: 16),
                  Expanded(
                      child: StatMetricCard(
                          count: 81,
                          label: 'Sad',
                          color: primaryBrown,
                          icon: Icons.sentiment_dissatisfied)),
                ],
              ),
              const SizedBox(height: 12),
              // Mood Distribution Chart
              const Text('Mood Distribution',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 7),
              CustomCard(
                child: SizedBox(
                  height: 200,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const style = TextStyle(color: textLightGrey, fontWeight: FontWeight.bold, fontSize: 12);
                              switch (value.toInt()) {
                                case 0:
                                  return const Text('Very Sad', style: style);
                                case 1:
                                  return const Text('Sad', style: style);
                                case 2:
                                  return const Text('Neutral', style: style);
                                case 3:
                                  return const Text('Happy', style: style);
                                case 4:
                                  return const Text('Very Happy', style: style);
                              }
                              return const Text('');
                            },
                            reservedSize: 40,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value == 0) {
                                return const Text('');
                              }
                              return Text(
                                value.toInt().toString(),
                                style: const TextStyle(
                                  color: textLightGrey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              );
                            },
                            reservedSize: 30,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(
                          x: 0,
                          barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: Colors.blueGrey,
                              width: 22,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 1,
                          barRods: [
                            BarChartRodData(
                              toY: 12,
                              color: textLightGrey,
                              width: 22,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 2,
                          barRods: [
                            BarChartRodData(
                              toY: 18,
                              color: secondaryOrange,
                              width: 22,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 3,
                          barRods: [
                            BarChartRodData(
                              toY: 25,
                              color: accentGreen,
                              width: 22,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                        BarChartGroupData(
                          x: 4,
                          barRods: [
                            BarChartRodData(
                              toY: 19,
                              color: accentGreen,
                              width: 22,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Activity Tracker
              const Text('Journal Activity',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 15),
              const ActivityTimelineItem(
                  date: 'Nov 15', activity: 'Wrote 3 Text Journals'),
              const ActivityTimelineItem(
                  date: 'Nov 12', activity: 'Logged Voice Note'),
              const ActivityTimelineItem(
                  date: 'Nov 10', activity: 'Reviewed past entries'),
              const ActivityTimelineItem(
                  date: 'Nov 8', activity: 'Added Photo Journal'),
              const ActivityTimelineItem(
                  date: 'Nov 5', activity: 'Shared journal with therapist'),
              const SizedBox(height: 30),
              // Journal Types
              const Text('Journal Types Distribution',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 15),
              CustomCard(
                child: SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: [
                        PieChartSectionData(
                          color: accentGreen,
                          value: 65,
                          title: 'Text',
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: cardWhite,
                          ),
                          radius: 60,
                        ),
                        PieChartSectionData(
                          color: secondaryOrange,
                          value: 20,
                          title: 'Voice',
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: cardWhite,
                          ),
                          radius: 60,
                        ),
                        PieChartSectionData(
                          color: primaryBrown,
                          value: 15,
                          title: 'Photo',
                          titleStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: cardWhite,
                          ),
                          radius: 60,
                        ),
                      ],
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

class StatMetricCard extends StatelessWidget {
  final int count;
  final String label;
  final Color color;
  final IconData icon;

  const StatMetricCard({
    super.key,
    required this.count,
    required this.label,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(icon, color: cardWhite, size: 30),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '$count',
                        style: const TextStyle(
                            color: cardWhite,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 5),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'entries',
                          style: TextStyle(
                              color: cardWhite,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class ActivityTimelineItem extends StatelessWidget {
  final String date;
  final String activity;

  const ActivityTimelineItem({
    super.key,
    required this.date,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(date,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: primaryBrown)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(activity, style: const TextStyle(color: textDark)),
          ),
        ],
      ),
    );
  }
}

// --- Screen 3: New Journal Type Selection ---

class NewJournalTypeScreen extends StatefulWidget {
  const NewJournalTypeScreen({super.key});

  @override
  State<NewJournalTypeScreen> createState() => _NewJournalTypeScreenState();
}

class _NewJournalTypeScreenState extends State<NewJournalTypeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
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
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('New Mental Health Journal',
            style: TextStyle(
                color: textDark, fontWeight: FontWeight.bold, fontSize: 20)),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  JournalTypeCard(
                    type: JournalType.text,
                    title: 'Text Journal',
                    description: 'Capture your thoughts and feelings with a quick note or a detailed essay.',
                    icon: Icons.edit_note,
                    color: accentGreen,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TextJournalScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  JournalTypeCard(
                    type: JournalType.voice,
                    title: 'Voice Journal',
                    description: 'Record your feelings. The voice analysis will track your tone.',
                    icon: Icons.mic_none,
                    color: primaryBrown,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VoiceJournalScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  JournalTypeCard(
                    type: JournalType.photo,
                    title: 'Photo / Video Journal',
                    description: 'Document your day with a visual memory and a brief caption.',
                    icon: Icons.camera_alt_outlined,
                    color: secondaryOrange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewJournalScreen()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  JournalTypeCard(
                    type: JournalType.text,
                    title: 'Mood Tracker',
                    description: 'Quickly log your mood and get insights over time.',
                    icon: Icons.mood,
                    color: accentBlue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddNewJournalScreen()),
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

class JournalTypeCard extends StatelessWidget {
  final JournalType type;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const JournalTypeCard({
    super.key,
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withAlpha(_alphaFromOpacity(0.1)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(description,
                      style: const TextStyle(color: textLightGrey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 4: Text Journal ---

class TextJournalScreen extends StatefulWidget {
  const TextJournalScreen({super.key});

  @override
  State<TextJournalScreen> createState() => _TextJournalScreenState();
}

class _TextJournalScreenState extends State<TextJournalScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.close, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save draft logic
            },
            child: const Text('Draft',
                style: TextStyle(color: primaryBrown, fontSize: 16)),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Say anything that's on your mind!",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 20),
              Expanded(
                child: CustomCard(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: _textController,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Start writing...',
                      hintStyle: TextStyle(color: textLightGrey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Mood Selector
              const Text('How are you feeling?',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 10),
              const MoodSelector(),
              const SizedBox(height: 20),
              // Tags Input
              const Text('Add tags',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  TagChip(label: 'Work', color: primaryBrown),
                  TagChip(label: 'Family', color: accentGreen),
                  TagChip(label: 'Health', color: secondaryOrange),
                  TagChip(label: 'Personal', color: accentBlue),
                  TagChip(label: 'Add +', color: textLightGrey),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Create journal logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyJournalsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentGreen,
                    foregroundColor: cardWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  ),
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Create Journal',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TagChip extends StatelessWidget {
  final String label;
  final Color color;

  const TagChip({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withAlpha(_alphaFromOpacity(0.1)),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withAlpha(_alphaFromOpacity(0.3))),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontWeight: FontWeight.w500),
      ),
    );
  }
}

// --- Screen 5: Voice Journal ---

class VoiceJournalScreen extends StatefulWidget {
  const VoiceJournalScreen({super.key});

  @override
  State<VoiceJournalScreen> createState() => _VoiceJournalScreenState();
}

class _VoiceJournalScreenState extends State<VoiceJournalScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _animationController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.close, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    'Today I had a hard time concentrating, I was very worried about making mistakes, very angry',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: textDark)),
                const SizedBox(height: 50),
                // Waveform Placeholder
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: primaryBrown.withAlpha(_alphaFromOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(20, (index) {
                        final height = 20.0 + (index % 5) * 8.0;
                        return Container(
                          width: 4,
                          height: height,
                          decoration: BoxDecoration(
                            color: primaryBrown,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                // Timer
                const Text('02:08',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: primaryBrown)),
                const SizedBox(height: 50),
                // Mic Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isRecording = !_isRecording;
                    });
                  },
                  child: AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _isRecording ? _pulseAnimation.value : 1.0,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isRecording ? secondaryOrange : primaryBrown,
                            boxShadow: [
                              BoxShadow(
                                color: (_isRecording ? secondaryOrange : primaryBrown)
                                    .withAlpha(_alphaFromOpacity(0.3)),
                                blurRadius: 30,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Icon(
                            _isRecording ? Icons.stop : Icons.mic,
                            color: cardWhite,
                            size: 50,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  _isRecording ? 'Recording...' : 'Ready',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: _isRecording ? secondaryOrange : textLightGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Screen 6: Add New Journal (Multi-input) ---

class AddNewJournalScreen extends StatefulWidget {
  const AddNewJournalScreen({super.key});

  @override
  State<AddNewJournalScreen> createState() => _AddNewJournalScreenState();
}

class _AddNewJournalScreenState extends State<AddNewJournalScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _textController = TextEditingController();
  Mood _selectedMood = Mood.neutral;
  final List<String> _selectedTags = ['Work', 'Personal'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Top Brown Header
            Container(
              padding: const EdgeInsets.only(
                  top: 60, left: 24, right: 24, bottom: 24),
              decoration: const BoxDecoration(
                color: primaryBrown,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: cardWhite, size: 24),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Text('Add New Journal',
                          style: TextStyle(
                              color: cardWhite,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                      const SizedBox(width: 40),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const DateCalendarRow(),
                ],
              ),
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Journal Entry Card
                    CustomCard(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: _textController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          hintText: 'Write story about your day...',
                          hintStyle: TextStyle(color: textLightGrey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text('Select Your Mood',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textDark)),
                    const SizedBox(height: 10),
                    MoodSelector(
                      onMoodSelected: (mood) {
                        setState(() {
                          _selectedMood = mood;
                        });
                      },
                      selectedMood: _selectedMood,
                    ),
                    const SizedBox(height: 20),
                    // Tags/Topics Input
                    const Text('Tags/Topics',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textDark)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ..._selectedTags.map((tag) => TagInput(
                          label: tag,
                          color: _getTagColor(tag),
                          onRemove: () {
                            setState(() {
                              _selectedTags.remove(tag);
                            });
                          },
                        )),
                        TagInput(
                          label: 'Add +',
                          color: textLightGrey,
                          onRemove: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Add Photo/Video Placeholder
                    Container(
                      height: 80,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: primaryBrown.withAlpha(_alphaFromOpacity(0.1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Add a photo / video',
                              style: TextStyle(
                                  color: primaryBrown,
                                  fontWeight: FontWeight.w600)),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: primaryBrown,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.add, color: cardWhite),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Create Journal Button
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Create journal logic
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyJournalsScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accentGreen,
                          foregroundColor: cardWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 16),
                        ),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Create Journal',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
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

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'work':
        return primaryBrown;
      case 'personal':
        return accentGreen;
      case 'health':
        return secondaryOrange;
      case 'family':
        return accentBlue;
      default:
        return accentPurple;
    }
  }
}

class DateCalendarRow extends StatelessWidget {
  const DateCalendarRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: cardWhite),
              onPressed: () {}),
          for (int i = 26; i <= 31; i++)
            CalendarDay(day: i, isSelected: i == 30),
          IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: cardWhite),
              onPressed: () {}),
        ],
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  final int day;
  final bool isSelected;
  const CalendarDay({super.key, required this.day, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: isSelected ? cardWhite : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
            color: cardWhite.withAlpha(_alphaFromOpacity(0.5)), width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tue',
                style: TextStyle(
                    color: isSelected ? primaryBrown : cardWhite, fontSize: 10)),
            Text('$day',
                style: TextStyle(
                    color: isSelected ? primaryBrown : cardWhite,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class MoodSelector extends StatelessWidget {
  final Function(Mood)? onMoodSelected;
  final Mood? selectedMood;

  const MoodSelector({
    super.key,
    this.onMoodSelected,
    this.selectedMood,
  });

  @override
  Widget build(BuildContext context) {
    // Emoji placeholders
    const Map<Mood, String> moods = {
      Mood.verysad: '😞',
      Mood.sad: '😔',
      Mood.neutral: '😐',
      Mood.happy: '😊',
      Mood.veryhappy: '😁',
    };
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: moods.entries
          .map((e) => MoodIcon(
          emoji: e.value,
          mood: e.key,
          isSelected: e.key == selectedMood,
          onTap: () {
            if (onMoodSelected != null) {
              onMoodSelected!(e.key);
            }
          }))
          .toList(),
    );
  }
}

class MoodIcon extends StatelessWidget {
  final String emoji;
  final Mood mood;
  final bool isSelected;
  final VoidCallback? onTap;

  const MoodIcon({
    super.key,
    required this.emoji,
    required this.mood,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? primaryBrown : cardWhite,
              shape: BoxShape.circle,
              border: isSelected ? null : Border.all(color: textLightGrey),
            ),
            child: Center(
                child: Text(emoji,
                    style:
                    TextStyle(fontSize: isSelected ? 30 : 24))),
          ),
          const SizedBox(height: 5),
          Text(mood.name.replaceAll('_', ' '),
              style: TextStyle(
                  fontSize: 12,
                  color: isSelected ? primaryBrown : textLightGrey)),
        ],
      ),
    );
  }
}

class TagInput extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onRemove;

  const TagInput({
    super.key,
    required this.label,
    required this.color,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: CustomCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: cardWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style:
                TextStyle(color: color, fontWeight: FontWeight.w600)),
            GestureDetector(
              onTap: onRemove,
              child: Icon(Icons.close, color: color, size: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 7: My Journals/Calendar ---

class MyJournalsScreen extends StatefulWidget {
  const MyJournalsScreen({super.key});

  @override
  State<MyJournalsScreen> createState() => _MyJournalsScreenState();
}

class _MyJournalsScreenState extends State<MyJournalsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('My Journals',
            style: TextStyle(
                color: textDark, fontWeight: FontWeight.bold, fontSize: 22)),
        actions: const [
          Icon(Icons.calendar_month, color: primaryBrown),
          SizedBox(width: 16),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Calendar/Date Selector
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                color: cardWhite,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.arrow_back_ios, color: textDark),
                    CalendarDaySmall(day: '26', mood: accentGreen),
                    CalendarDaySmall(day: '27', mood: secondaryOrange),
                    CalendarDaySmall(day: '28', mood: primaryBrown),
                    CalendarDaySmall(day: '29', mood: Colors.grey),
                    CalendarDaySmall(day: '30', isSelected: true),
                    Icon(Icons.arrow_forward_ios, color: textDark),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Journal Timeline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Today',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textDark)),
                    const SizedBox(height: 10),
                    ...sampleJournalEntries
                        .where((entry) =>
                    entry.date.day == DateTime.now().day &&
                        entry.date.month == DateTime.now().month)
                        .map((entry) {
                      return JournalTimelineItem(
                          time: '${entry.date.hour}:${entry.date.minute.toString().padLeft(2, '0')}',
                          title: entry.title,
                          snippet: entry.content,
                          color: _getMoodColor(entry.mood),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JournalDetailScreen(entry: entry)),
                          ));
                    }),
                    const SizedBox(height: 20),
                    const Text('Yesterday',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textDark)),
                    const SizedBox(height: 10),
                    ...sampleJournalEntries
                        .where((entry) =>
                    entry.date.day == DateTime.now().day - 1 &&
                        entry.date.month == DateTime.now().month)
                        .map((entry) {
                      return JournalTimelineItem(
                          time: '${entry.date.hour}:${entry.date.minute.toString().padLeft(2, '0')}',
                          title: entry.title,
                          snippet: entry.content,
                          color: _getMoodColor(entry.mood),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JournalDetailScreen(entry: entry)),
                          ));
                    }),
                    const SizedBox(height: 20),
                    const Text('This Week',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textDark)),
                    const SizedBox(height: 10),
                    ...sampleJournalEntries
                        .where((entry) =>
                    entry.date.day < DateTime.now().day - 1 &&
                        entry.date.month == DateTime.now().month)
                        .map((entry) {
                      return JournalTimelineItem(
                          time: '${entry.date.day}/${entry.date.month}',
                          title: entry.title,
                          snippet: entry.content,
                          color: _getMoodColor(entry.mood),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JournalDetailScreen(entry: entry)),
                          ));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getMoodColor(Mood mood) {
    switch (mood) {
      case Mood.verysad:
        return Colors.blueGrey;
      case Mood.sad:
        return textLightGrey;
      case Mood.neutral:
        return secondaryOrange;
      case Mood.happy:
        return accentGreen;
      case Mood.veryhappy:
        return accentGreen;
    }
  }
}

class CalendarDaySmall extends StatelessWidget {
  final String day;
  final bool isSelected;
  final Color mood;

  const CalendarDaySmall({
    super.key,
    required this.day,
    this.isSelected = false,
    this.mood = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: isSelected ? primaryBrown : cardWhite,
        borderRadius: BorderRadius.circular(10),
        border: isSelected
            ? null
            : Border.all(color: textLightGrey.withAlpha(50), width: 1),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('26',
                style: TextStyle(
                    color: isSelected ? cardWhite : textLightGrey,
                    fontSize: 10)),
            Text(day,
                style: TextStyle(
                    color: isSelected ? cardWhite : textDark,
                    fontWeight: FontWeight.bold)),
            if (mood != Colors.transparent)
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: mood, shape: BoxShape.circle),
              )
          ],
        ),
      ),
    );
  }
}

class JournalTimelineItem extends StatelessWidget {
  final String time;
  final String title;
  final String snippet;
  final Color color;
  final VoidCallback onTap;

  const JournalTimelineItem({
    super.key,
    required this.time,
    required this.title,
    required this.snippet,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Text(time,
                  style: const TextStyle(
                      color: textLightGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Container(
                width: 2,
                height: 100,
                color: textLightGrey.withAlpha(_alphaFromOpacity(0.5)),
              ),
            ],
          ),
          const SizedBox(width: 16),
          // Journal Card
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: CustomCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: color)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(snippet,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: textDark)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Screen 8: Edit Journal/Details ---

class JournalDetailScreen extends StatefulWidget {
  final JournalEntry entry;

  const JournalDetailScreen({super.key, required this.entry});

  @override
  State<JournalDetailScreen> createState() => _JournalDetailScreenState();
}

class _JournalDetailScreenState extends State<JournalDetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: textDark),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: textDark),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.entry.title,
                  style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 8),
              Text(
                  '${widget.entry.date.day}/${widget.entry.date.month}/${widget.entry.date.year} at ${widget.entry.date.hour}:${widget.entry.date.minute.toString().padLeft(2, '0')} - ${widget.entry.type.name.toString().split('.').last} Journal',
                  style: const TextStyle(color: textLightGrey)),
              const SizedBox(height: 20),
              // Mood indicator
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getMoodColor(widget.entry.mood).withAlpha(_alphaFromOpacity(0.1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          _getMoodEmoji(widget.entry.mood),
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.entry.mood.name.replaceAll('_', ' '),
                          style: TextStyle(
                              color: _getMoodColor(widget.entry.mood),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Tags
              if (widget.entry.tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.entry.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: primaryBrown.withAlpha(_alphaFromOpacity(0.1)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                            color: primaryBrown, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              // Journal content
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.entry.content,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ),
              // Image if available
              if (widget.entry.imageUrl != null)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: CustomCard(
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.entry.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 200,
                          color: backgroundLightGrey,
                          child: const Center(
                            child: Icon(Icons.broken_image, color: textLightGrey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              // Suggestions/AI Analysis Block
              const Text('AI Suggestions',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 15),
              SuggestionCard(
                title: 'Feeling of Overwhelm Detected',
                suggestion:
                'It seems you are facing high stress due to deadlines. Try the 5-4-3-2-1 grounding technique to manage immediate anxiety.',
                icon: Icons.lightbulb_outline,
                color: accentGreen,
              ),
              SuggestionCard(
                title: 'Negative Thought Pattern',
                suggestion:
                'The phrase "It\'s not a big deal" minimizes your feelings. Try to validate your emotions instead of dismissing them.',
                icon: Icons.psychology_outlined,
                color: secondaryOrange,
              ),
              SuggestionCard(
                title: 'Mindfulness Recommendation',
                suggestion:
                'Based on your journal patterns, practicing mindfulness for 10 minutes daily could help improve your overall mood.',
                icon: Icons.self_improvement,
                color: accentBlue,
              ),
            ],
          ),
        ),
      ),
      // Floating Action Button for Emergency
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmergencyScreen()),
        ),
        backgroundColor: secondaryOrange,
        child: const Icon(Icons.favorite_border, color: cardWhite),
      ),
    );
  }

  Color _getMoodColor(Mood mood) {
    switch (mood) {
      case Mood.verysad:
        return Colors.blueGrey;
      case Mood.sad:
        return textLightGrey;
      case Mood.neutral:
        return secondaryOrange;
      case Mood.happy:
        return accentGreen;
      case Mood.veryhappy:
        return accentGreen;
    }
  }

  String _getMoodEmoji(Mood mood) {
    switch (mood) {
      case Mood.verysad:
        return '😞';
      case Mood.sad:
        return '😔';
      case Mood.neutral:
        return '😐';
      case Mood.happy:
        return '😊';
      case Mood.veryhappy:
        return '😁';
    }
  }
}

class SuggestionCard extends StatelessWidget {
  final String title;
  final String suggestion;
  final IconData icon;
  final Color color;

  const SuggestionCard({
    super.key,
    required this.title,
    required this.suggestion,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: CustomCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color)),
                ),
              ],
            ),
            const Divider(height: 20),
            Text(suggestion, style: const TextStyle(height: 1.4)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share, color: textLightGrey, size: 16),
                label: const Text('Share Tip',
                    style: TextStyle(color: textLightGrey)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Screen 9: Emergency/Suicide Prevention ---

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
      backgroundColor: backgroundLightGrey,
      appBar: AppBar(
        backgroundColor: backgroundLightGrey,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: textDark),
          onPressed: () => Navigator.pop(context),
        ),
        actions: const [
          Icon(Icons.more_vert, color: textDark),
          SizedBox(width: 16),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Suicidal Mental Pattern Detected By AI',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: primaryBrown)),
              const SizedBox(height: 20),
              // Illustration Placeholder
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: accentGreen.withAlpha(_alphaFromOpacity(0.1)),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Center(
                    child: Image.network(
                      getPersonImageUrl(11),
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.person, color: accentGreen, size: 80),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Message Card
              CustomCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('We care about your safety.',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: secondaryOrange)),
                    const SizedBox(height: 10),
                    const Text(
                        'If you are feeling overwhelmed or are considering self-harm, please reach out immediately. We are here to support you.',
                        style: TextStyle(fontSize: 16, height: 1.4)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Emergency Contacts
              const Text('Emergency Contacts',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 15),
              CustomCard(
                child: Column(
                  children: [
                    EmergencyContactItem(
                      name: 'National Suicide Prevention Lifeline',
                      number: '988',
                      icon: Icons.phone,
                      color: secondaryOrange,
                    ),
                    const Divider(height: 1),
                    EmergencyContactItem(
                      name: 'Crisis Text Line',
                      number: 'Text HOME to 741741',
                      icon: Icons.message,
                      color: accentGreen,
                    ),
                    const Divider(height: 1),
                    EmergencyContactItem(
                      name: 'Your Therapist',
                      number: '(555) 123-4567',
                      icon: Icons.person,
                      color: accentBlue,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Call for Help Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Call function logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryOrange,
                    foregroundColor: cardWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  icon: const Icon(Icons.phone, size: 24),
                  label: const Text('Call for Help',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 15),
              // Crisis Support Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Link to crisis resources
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryBrown,
                    side: const BorderSide(color: primaryBrown, width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  icon: const Icon(Icons.link, size: 24),
                  label: const Text('Find Crisis Support Resources',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ),
              const SizedBox(height: 30),
              // Breathing Exercise
              const Text('Try a Breathing Exercise',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textDark)),
              const SizedBox(height: 15),
              CustomCard(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                          'Box breathing can help reduce stress and anxiety. Follow the pattern below:',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BreathingStep(
                            label: 'Inhale',
                            seconds: '4',
                            color: accentGreen,
                          ),
                          BreathingStep(
                            label: 'Hold',
                            seconds: '4',
                            color: secondaryOrange,
                          ),
                          BreathingStep(
                            label: 'Exhale',
                            seconds: '4',
                            color: accentBlue,
                          ),
                          BreathingStep(
                            label: 'Hold',
                            seconds: '4',
                            color: accentPurple,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Start breathing exercise
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBrown,
                          foregroundColor: cardWhite,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text('Start Exercise'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class EmergencyContactItem extends StatelessWidget {
  final String name;
  final String number;
  final IconData icon;
  final Color color;

  const EmergencyContactItem({
    super.key,
    required this.name,
    required this.number,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(_alphaFromOpacity(0.1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  number,
                  style: TextStyle(
                    color: textLightGrey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.call,
            color: color,
          ),
        ],
      ),
    );
  }
}

class BreathingStep extends StatelessWidget {
  final String label;
  final String seconds;
  final Color color;

  const BreathingStep({
    super.key,
    required this.label,
    required this.seconds,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withAlpha(_alphaFromOpacity(0.1)),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              seconds,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// --- Main App Setup ---

void main() {
  runApp(const HealthJournalApp());
}

class HealthJournalApp extends StatelessWidget {
  const HealthJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: backgroundLightGrey,
        appBarTheme: const AppBarTheme(
          color: backgroundLightGrey,
          elevation: 0,
          iconTheme: IconThemeData(color: textDark),
          titleTextStyle: TextStyle(
            color: textDark,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: primaryBrown,
          secondary: secondaryOrange,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBrown,
            foregroundColor: cardWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ),
      home: const HealthJournal(),
    );
  }
}