import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

// Note: You must add these dependencies to your pubspec.yaml file:
// dependencies:
//   flutter:
//     sdk: flutter
//   font_awesome_flutter: ^10.6.0
//   fl_chart: ^0.63.0

// --- 1. Helper Function for Opacity Constraint ---
int _alphaFromOpacity(double opacity) {
  return (opacity * 255).round();
}

// --- 2. Enums and Data Models ---

enum Mood {
  happy,
  overjoyed,
  neutral,
  bad,
  depressed,
}

class MoodEntry {
  final Mood mood;
  final String note;
  final DateTime date;
  final double energy;
  final double sleep;

  const MoodEntry({
    required this.mood,
    required this.note,
    required this.date,
    required this.energy,
    required this.sleep,
  });
}

// --- 3. Constants and Colors ---

const Color kYellow = Color(0xFFF9DC5C);
const Color kPurple = Color(0xFF906AD6);
const Color kOrange = Color(0xFFE58752);
const Color kBrown = Color(0xFF9B6A56);
const Color kGreen = Color(0xFF86BC59);
const Color kDarkBrown = Color(0xFF4C362B);
const Color kLightGrey = Color(0xFFF0F0F0);
const Color kBackground = Color(0xFFFFFFFF);

final Map<Mood, Map<String, dynamic>> moodConfig = {
  Mood.happy: {'color': kYellow, 'label': 'I\'m Feeling Happy', 'icon': FontAwesomeIcons.solidFaceSmile},
  Mood.overjoyed: {'color': kGreen, 'label': 'I\'m Feeling Overjoyed', 'icon': FontAwesomeIcons.solidFaceGrinBeam},
  Mood.neutral: {'color': kBrown, 'label': 'I\'m Feeling Neutral', 'icon': FontAwesomeIcons.solidFaceMeh},
  Mood.bad: {'color': kOrange, 'label': 'I\'m Feeling Bad', 'icon': FontAwesomeIcons.solidFaceFrown},
  Mood.depressed: {'color': kPurple, 'label': 'I\'m Feeling Depressed', 'icon': FontAwesomeIcons.solidFaceSadTear},
};

final List<MoodEntry> dummyMoodData = [
  MoodEntry(mood: Mood.happy, note: 'Had a great day at work. Met all my deadlines and had a nice chat with colleagues.', date: DateTime(2025, 10, 1), energy: 0.8, sleep: 0.7),
  MoodEntry(mood: Mood.overjoyed, note: 'Landed the new client! Celebrating with friends tonight.', date: DateTime(2025, 9, 30), energy: 0.9, sleep: 0.6),
  MoodEntry(mood: Mood.neutral, note: 'Just a regular Tuesday. Not much going on, keeping busy.', date: DateTime(2025, 9, 29), energy: 0.5, sleep: 0.5),
  MoodEntry(mood: Mood.depressed, note: 'Feeling overwhelmed by the workload and lack of sleep.', date: DateTime(2025, 9, 28), energy: 0.2, sleep: 0.3),
  MoodEntry(mood: Mood.happy, note: 'Morning walk was nice and peaceful. Got coffee afterwards.', date: DateTime(2025, 9, 27), energy: 0.7, sleep: 0.8),
];

IconData getMoodIcon(Mood mood) {
  return moodConfig[mood]!['icon'];
}

// --- 4. Reusable Widgets (White Card and Pill Button) ---

class WhiteCard extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const WhiteCard({
    required this.child,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.all(20.0),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(_alphaFromOpacity(0.05)),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PillButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool isDarkText;

  const PillButton({
    required this.text,
    required this.onPressed,
    this.color = kDarkBrown,
    this.isDarkText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const StadiumBorder(),
          elevation: 5,
          shadowColor: Colors.black.withAlpha(_alphaFromOpacity(0.15)),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isDarkText ? kDarkBrown : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

// --- 5. Main App Setup ---

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: kDarkBrown),
          titleTextStyle: TextStyle(
            color: kDarkBrown,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: kDarkBrown,
          secondary: kOrange,
        ),
      ),
      home: const MoodTracker(),
    );
  }
}

// --- 6. Screens ---

class MoodTracker extends StatefulWidget {
  const MoodTracker({super.key});

  @override
  State<MoodTracker> createState() => _MoodTrackerState();
}

class _MoodTrackerState extends State<MoodTracker> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

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

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
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
      backgroundColor: kYellow,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              children: [
                // Top Nav/Profile
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
                        radius: 20,
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.chartLine, color: kDarkBrown),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MoodStatsScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Main Mood Display
                const Text(
                  'Happy',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: kDarkBrown,
                  ),
                ),
                const SizedBox(height: 20),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(_alphaFromOpacity(0.3)),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: FaIcon(getMoodIcon(Mood.happy), size: 80, color: kDarkBrown),
                  ),
                ),
                const SizedBox(height: 50),

                // Main Content Card
                Expanded(
                  child: WhiteCard(
                    padding: const EdgeInsets.all(0),
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            'What is the secret behind your happiness today?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: kDarkBrown,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // Mood Selector Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: Mood.values.map((mood) {
                            final config = moodConfig[mood]!;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HowAreYouFeelingScreen(selectedMood: mood)),
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: mood == Mood.happy
                                      ? config['color'].withAlpha(_alphaFromOpacity(0.2))
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  children: [
                                    FaIcon(
                                      config['icon'],
                                      color: mood == Mood.happy ? config['color'] : kLightGrey,
                                      size: 30,
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      mood.name.substring(0, 1).toUpperCase() + mood.name.substring(1),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: mood == Mood.happy ? kDarkBrown : kDarkBrown.withAlpha(_alphaFromOpacity(0.5)),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 30),

                        // Daily Goals/Suggestions Area
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                            color: kLightGrey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Daily goals',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kDarkBrown,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  _buildGoalTile('Go for a 15-minute walk', true),
                                  _buildGoalTile('Call a family member', false),
                                  _buildGoalTile('Read a chapter of a book', true),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
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

  Widget _buildGoalTile(String text, bool isCompleted) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          FaIcon(
            isCompleted ? FontAwesomeIcons.circleCheck : FontAwesomeIcons.circle,
            color: isCompleted ? kGreen : kDarkBrown.withAlpha(_alphaFromOpacity(0.5)),
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              decoration: isCompleted ? TextDecoration.lineThrough : null,
              color: isCompleted ? kDarkBrown.withAlpha(_alphaFromOpacity(0.5)) : kDarkBrown,
            ),
          ),
        ],
      ),
    );
  }
}

class MoodStatsScreen extends StatefulWidget {
  const MoodStatsScreen({super.key});

  @override
  State<MoodStatsScreen> createState() => _MoodStatsScreenState();
}

class _MoodStatsScreenState extends State<MoodStatsScreen> with SingleTickerProviderStateMixin {
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

  Widget _buildStatItem(String label, Color color) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 16,
          width: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: color.withAlpha(_alphaFromOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  List<FlSpot> _getMoodSpots() {
    final sortedData = List<MoodEntry>.from(dummyMoodData)
      ..sort((a, b) => a.date.compareTo(b.date));

    final recentData = sortedData.length > 7 ? sortedData.sublist(sortedData.length - 7) : sortedData;

    return recentData.asMap().entries.map((entry) {
      final index = entry.key;
      final moodEntry = entry.value;
      double moodValue;
      switch (moodEntry.mood) {
        case Mood.depressed:
          moodValue = 1;
          break;
        case Mood.bad:
          moodValue = 2;
          break;
        case Mood.neutral:
          moodValue = 3;
          break;
        case Mood.happy:
          moodValue = 4;
          break;
        case Mood.overjoyed:
          moodValue = 5;
          break;
      }
      return FlSpot(index.toDouble(), moodValue);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: kDarkBrown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Mood Stats'),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your journey through the data',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Main Chart Card
              WhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mood History', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kDarkBrown)),
                    const SizedBox(height: 10),
                    const Text('Last 7 Days', style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 20),
                    // Mood Line Chart
                    SizedBox(
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
                                  const style = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12);
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
                                  const style = TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12);
                                  switch (value.toInt()) {
                                    case 1:
                                      return const Text('Depressed', style: style);
                                    case 2:
                                      return const Text('Bad', style: style);
                                    case 3:
                                      return const Text('Neutral', style: style);
                                    case 4:
                                      return const Text('Happy', style: style);
                                    case 5:
                                      return const Text('Overjoyed', style: style);
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
                              spots: _getMoodSpots(),
                              isCurved: true,
                              color: kDarkBrown,
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                  radius: 4,
                                  color: kDarkBrown,
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                ),
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                color: kDarkBrown.withAlpha(_alphaFromOpacity(0.1)),
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 250),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),

                    // Mood Summary Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Happy', kYellow),
                        _buildStatItem('Neutral', kBrown),
                        _buildStatItem('Bad', kOrange),
                        _buildStatItem('Depressed', kPurple),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Mood Tags Card
              WhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Top Mood Tags', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kDarkBrown)),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildTag('Friends', kOrange),
                        _buildTag('Work', kPurple),
                        _buildTag('Family', kGreen),
                        _buildTag('Sleep', kYellow),
                        _buildTag('Exercise', kDarkBrown),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Read History Button
              Center(
                child: PillButton(
                  text: 'Read History',
                  color: kDarkBrown,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyMoodScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HowAreYouFeelingScreen extends StatefulWidget {
  final Mood selectedMood;

  const HowAreYouFeelingScreen({required this.selectedMood, super.key});

  @override
  State<HowAreYouFeelingScreen> createState() => _HowAreYouFeelingScreenState();
}

class _HowAreYouFeelingScreenState extends State<HowAreYouFeelingScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _emojiController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  double _moodLevel = 3.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _emojiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _animationController.forward();
    _emojiController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emojiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = moodConfig[widget.selectedMood]!;
    final Color backgroundColor = config['color'];
    final String label = config['label'];
    final IconData emojiIcon = config['icon'];

    final Color textColor = widget.selectedMood == Mood.depressed ||
        widget.selectedMood == Mood.bad ||
        widget.selectedMood == Mood.neutral
        ? Colors.white
        : kDarkBrown;

    final Color dotColor = widget.selectedMood == Mood.depressed ||
        widget.selectedMood == Mood.bad ||
        widget.selectedMood == Mood.neutral
        ? Colors.white
        : kDarkBrown;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.arrowLeft, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'How are you feeling this day?',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: AnimatedBuilder(
                      animation: _emojiController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + 0.1 * (1 - _emojiController.value),
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(_alphaFromOpacity(0.3)),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: FaIcon(emojiIcon, size: 100, color: textColor),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Mood Slider/Dots
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(5, (index) {
                          final isSelected = (index + 1) == _moodLevel.round();
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            child: FaIcon(
                              isSelected ? FontAwesomeIcons.solidCircle : FontAwesomeIcons.circle,
                              color: isSelected
                                  ? dotColor
                                  : dotColor.withAlpha(_alphaFromOpacity(0.5)),
                              size: 10,
                            ),
                          );
                        }),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: dotColor,
                          inactiveTrackColor: dotColor.withAlpha(_alphaFromOpacity(0.5)),
                          thumbColor: dotColor,
                          overlayColor: dotColor.withAlpha(_alphaFromOpacity(0.2)),
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10.0),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                          trackHeight: 3.0,
                        ),
                        child: Slider(
                          value: _moodLevel,
                          min: 1,
                          max: 5,
                          divisions: 4,
                          onChanged: (double value) {
                            setState(() {
                              _moodLevel = value;
                            });
                            _emojiController.reset();
                            _emojiController.forward();
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Set Mood Button
                  Center(
                    child: PillButton(
                      text: 'Set Mood',
                      color: Colors.white,
                      isDarkText: true,
                      onPressed: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
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

class MyMoodScreen extends StatefulWidget {
  const MyMoodScreen({super.key});

  @override
  State<MyMoodScreen> createState() => _MyMoodScreenState();
}

class _MyMoodScreenState extends State<MyMoodScreen> with SingleTickerProviderStateMixin {
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
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Dark Brown Header
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: kDarkBrown,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.sliders, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FilterScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'My Mood',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Your mood log',
                    style: TextStyle(
                      color: Colors.white.withAlpha(_alphaFromOpacity(0.8)),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Mood List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20.0),
                itemCount: dummyMoodData.length,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    curve: Curves.easeInOut,
                    child: MoodEntryCard(entry: dummyMoodData[index]),
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

class MoodEntryCard extends StatelessWidget {
  final MoodEntry entry;

  const MoodEntryCard({required this.entry, super.key});

  @override
  Widget build(BuildContext context) {
    final config = moodConfig[entry.mood]!;
    final Color moodColor = config['color'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: WhiteCard(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Indicator
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 5,
                  height: 30,
                  decoration: BoxDecoration(
                    color: moodColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 5),
                FaIcon(getMoodIcon(entry.mood), color: moodColor, size: 24),
                const SizedBox(height: 5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 5,
                  height: 30,
                  decoration: BoxDecoration(
                    color: moodColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.mood.name.substring(0, 1).toUpperCase() + entry.mood.name.substring(1),
                    style: TextStyle(
                      color: moodColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    entry.note,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: kDarkBrown),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${entry.date.day}/${entry.date.month}/${entry.date.year}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            // Action Icons
            Column(
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.pen, size: 16, color: kDarkBrown.withAlpha(_alphaFromOpacity(0.7))),
                  onPressed: () {},
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.trash, size: 16, color: kOrange.withAlpha(_alphaFromOpacity(0.7))),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  double _energyLevel = 0.5;
  double _sleepLevel = 0.5;
  final List<String> _selectedTags = ['work', 'friends'];

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

  Widget _buildFilterRow(String start, String end, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            FaIcon(icon, color: kDarkBrown, size: 18),
            const SizedBox(width: 10),
            Text(
              '$start - $end',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kDarkBrown
              ),
            ),
          ],
        ),
        const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey, size: 14),
      ],
    );
  }

  Widget _buildSlider(double value, ValueChanged<double> onChanged, Color color) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: color,
        inactiveTrackColor: color.withAlpha(_alphaFromOpacity(0.3)),
        thumbColor: color,
        overlayColor: color.withAlpha(_alphaFromOpacity(0.1)),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8.0),
        overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
        trackHeight: 3.0,
      ),
      child: Slider(
        value: value,
        min: 0,
        max: 1,
        divisions: 10,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSelectableTag(String tag) {
    final isSelected = _selectedTags.contains(tag);
    final color = isSelected ? kDarkBrown : Colors.grey;

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTags.remove(tag);
          } else {
            _selectedTags.add(tag);
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kDarkBrown : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withAlpha(_alphaFromOpacity(0.5))),
        ),
        child: Text(
          tag.substring(0, 1).toUpperCase() + tag.substring(1),
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark, color: kDarkBrown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Filter Entries'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Apply',
              style: TextStyle(color: kDarkBrown, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter mood entries based on metrics and tags.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),

              // Date Range Picker
              WhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Date Range', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    _buildFilterRow(
                      'Jan 1, 2024',
                      'Jan 20, 2024',
                      FontAwesomeIcons.calendar,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Energy Slider
              WhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Energy Level', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    _buildSlider(
                      _energyLevel,
                          (value) => setState(() => _energyLevel = value),
                      kOrange,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Low', style: TextStyle(color: kDarkBrown.withAlpha(_alphaFromOpacity(0.7)))),
                        Text('High', style: TextStyle(color: kDarkBrown.withAlpha(_alphaFromOpacity(0.7)))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Sleep Slider
              WhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sleep Quality', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    _buildSlider(
                      _sleepLevel,
                          (value) => setState(() => _sleepLevel = value),
                      kPurple,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Poor', style: TextStyle(color: kDarkBrown.withAlpha(_alphaFromOpacity(0.7)))),
                        Text('Excellent', style: TextStyle(color: kDarkBrown.withAlpha(_alphaFromOpacity(0.7)))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tags Filter
              WhiteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Tags', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildSelectableTag('work'),
                        _buildSelectableTag('friends'),
                        _buildSelectableTag('family'),
                        _buildSelectableTag('exercise'),
                        _buildSelectableTag('food'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Suggestions Button
              Center(
                child: PillButton(
                  text: 'View AI Suggestions',
                  color: kDarkBrown,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AISuggestionsScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AISuggestionsScreen extends StatefulWidget {
  const AISuggestionsScreen({super.key});

  @override
  State<AISuggestionsScreen> createState() => _AISuggestionsScreenState();
}

class _AISuggestionsScreenState extends State<AISuggestionsScreen> with SingleTickerProviderStateMixin {
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

  Widget _buildSuggestionCard(
      BuildContext context, {
        required String title,
        required String description,
        required String action,
        required String imageUrl,
      }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: WhiteCard(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 70,
                        height: 70,
                        color: kLightGrey,
                        child: const Center(child: FaIcon(FontAwesomeIcons.user, color: Colors.grey)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kDarkBrown,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          description,
                          style: const TextStyle(color: Colors.grey, fontSize: 14),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: PillButton(
                  text: action,
                  onPressed: () {},
                  color: kGreen,
                  isDarkText: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Dark Header
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
              decoration: const BoxDecoration(
                color: kDarkBrown,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const FaIcon(FontAwesomeIcons.robot, color: Colors.white, size: 28),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'AI Suggestions',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Personalized advice for you',
                    style: TextStyle(
                      color: Colors.white.withAlpha(_alphaFromOpacity(0.8)),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Suggestions List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  _buildSuggestionCard(
                    context,
                    title: 'Increase Morning Routine',
                    description: 'Your data suggests mornings with structured routines lead to higher daily mood scores.',
                    action: 'Add 10 min stretch',
                    imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
                  ),
                  _buildSuggestionCard(
                    context,
                    title: 'Address Low Sleep Quality',
                    description: 'When sleep is poor, your depressed mood entries increase by 40%. Focus on sleep hygiene.',
                    action: 'Read sleep guide',
                    imageUrl: 'https://randomuser.me/api/portraits/men/88.jpg',
                  ),
                  _buildSuggestionCard(
                    context,
                    title: 'Social Interaction Boost',
                    description: 'Social tags correlate strongly with positive mood. Plan one social event this week.',
                    action: 'Schedule call',
                    imageUrl: 'https://randomuser.me/api/portraits/women/12.jpg',
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