import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// --- Global Constants and Helpers ---

// Helper function to replace opacity with withValues
int alphaFromOpacity(double opacity) {
  return (opacity * 255).round();
}

// Custom Color Palette inspired by the design
class AppColors {
  static const Color primaryDark = Color(0xFF333333);
  static const Color accentGreen = Color(0xFF7C956B); // Earthy Olive Green
  static const Color accentOrange = Color(0xFFC68C5E); // Terracotta Brown
  static const Color lightGreen = Color(0xFF9FC497); // Sage Green (Breathe In)
  static const Color darkOrange = Color(0xFFC9865B); // Darker Orange (Breathe Out)
  static const Color backgroundLight = Color(0xFFF0F0F0);
  static const Color cardWhite = Colors.white;
  static const Color indicatorYellow = Color(0xFFDFAA52); // For pie chart
  static const Color indicatorRed = Color(0xFFB05F5F); // For pie chart
  static const Color lightText = Color(0xFF999999);
  static const Color deepBlue = Color(0xFF5B7DB1); // New color for accents
  static const Color softPurple = Color(0xFF9B7EDE); // New color for accents
  static const Color softPink = Color(0xFFE8B4D0); // For new screens
  static const Color softTeal = Color(0xFF7FCDCD); // For new screens
}

// Enum for Exercise Goals (all lowercase)
enum Goal {
  gainnewskills,
  sleepbetter,
  beabetterparent,
  boostmyenergy,
  enjoymore,
  findabalance,
  reducestress,
  improvefocus,
}

// Dummy Data Models
class Track {
  final String title;
  final String duration;
  final Color color;
  final IconData icon;
  final String description;
  final String category;
  final int completedMinutes;
  final bool isFavorite;

  Track(this.title, this.duration, this.color, this.icon, this.description,
      this.category, this.completedMinutes, this.isFavorite);
}

class Statistic {
  final String title;
  final double hours;
  final double percentage;
  final Color color;
  final int sessions;

  Statistic(this.title, this.hours, this.percentage, this.color, this.sessions);
}

class DailyProgress {
  final String day;
  final double hours;
  final int sessions;

  DailyProgress(this.day, this.hours, this.sessions);
}

class Challenge {
  final String title;
  final String description;
  final int progress;
  final int target;
  final IconData icon;
  final Color color;
  final int points;

  Challenge(this.title, this.description, this.progress, this.target, this.icon, this.color, this.points);
}

class Achievement {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool unlocked;

  Achievement(this.title, this.description, this.icon, this.color, this.unlocked);
}

final List<Track> mindfulTracks = [
  Track('Deep Reflection', '05:00', AppColors.accentOrange, FontAwesomeIcons.sun,
      'A guided meditation for self-awareness and clarity', 'Mindfulness', 15, true),
  Track('Relaxing State', '08:20', AppColors.lightGreen, FontAwesomeIcons.moon,
      'Release tension and enter a state of deep relaxation', 'Relaxation', 25, false),
  Track('Deep Meditation', '12:00', AppColors.indicatorYellow, FontAwesomeIcons.om,
      'Advanced mindfulness techniques for experienced practitioners', 'Advanced', 40, true),
  Track('Stress Reduction', '04:45', AppColors.accentGreen, FontAwesomeIcons.leaf,
      'Quick relief from daily stress and anxiety', 'Stress Relief', 10, false),
  Track('Sleep Journey', '15:30', AppColors.deepBlue, FontAwesomeIcons.bed,
      'Guided meditation for restful sleep', 'Sleep', 60, true),
  Track('Focus Boost', '06:15', AppColors.softPurple, FontAwesomeIcons.brain,
      'Enhance concentration and mental clarity', 'Focus', 20, false),
  Track('Morning Calm', '10:00', AppColors.softTeal, FontAwesomeIcons.cloudSun,
      'Start your day with peace and intention', 'Morning', 30, true),
  Track('Anxiety Relief', '07:30', AppColors.softPink, FontAwesomeIcons.heart,
      'Techniques to manage anxiety and worry', 'Anxiety', 35, false),
];

final List<Statistic> mindfulStats = [
  Statistic('Breathing', 2.21, 37, AppColors.accentGreen, 12),
  Statistic('Sleep', 4.05, 40, AppColors.indicatorYellow, 8),
  Statistic('Relax', 1.95, 23, AppColors.indicatorRed, 7),
];

final List<DailyProgress> weeklyProgress = [
  DailyProgress('Mon', 1.2, 3),
  DailyProgress('Tue', 0.8, 2),
  DailyProgress('Wed', 1.5, 4),
  DailyProgress('Thu', 0.5, 1),
  DailyProgress('Fri', 1.8, 5),
  DailyProgress('Sat', 2.3, 6),
  DailyProgress('Sun', 1.1, 3),
];

final List<Challenge> dailyChallenges = [
  Challenge('Morning Meditation', 'Complete a 10-minute morning meditation', 3, 7,
      FontAwesomeIcons.sun, AppColors.softTeal, 50),
  Challenge('Mindful Breathing', 'Practice mindful breathing 5 times today', 2, 5,
      FontAwesomeIcons.wind, AppColors.accentGreen, 30),
  Challenge('Gratitude Journal', 'Write 3 things youre grateful for', 1, 1,
      FontAwesomeIcons.book, AppColors.softPink, 20),
  Challenge('Digital Detox', 'Spend 1 hour without screens', 0, 1,
      FontAwesomeIcons.mobileScreen, AppColors.deepBlue, 40),
];

final List<Achievement> achievements = [
  Achievement('First Steps', 'Complete your first meditation', FontAwesomeIcons.award, AppColors.accentOrange, true),
  Achievement('Week Streak', 'Meditate for 7 consecutive days', FontAwesomeIcons.fire, AppColors.accentGreen, true),
  Achievement('Mindful Master', 'Complete 50 meditation sessions', FontAwesomeIcons.crown, AppColors.softPurple, false),
  Achievement('Early Riser', 'Complete 5 morning meditations', FontAwesomeIcons.cloudSun, AppColors.softTeal, false),
  Achievement('Stress Free', 'Complete 10 stress relief sessions', FontAwesomeIcons.leaf, AppColors.accentGreen, true),
];

// --- Main Application ---



// --- Shared Widgets ---

// This widget mimics the structure of a track item or a goal button
class WhiteCard extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  final Color selectedColor;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const WhiteCard({super.key,
    required this.child,
    this.isSelected = false,
    this.selectedColor = AppColors.accentGreen,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: width,
        height: height,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: isSelected ? selectedColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

// Placeholder for an asset image
class AppAssetImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final double opacity;

  const AppAssetImage(this.assetPath, {super.key, this.width, this.height, this.fit = BoxFit.cover, this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    // In a real app, this would be an Image.asset(assetPath)
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.lightText.withAlpha(alphaFromOpacity(0.1 * opacity)),
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Icon(FontAwesomeIcons.mountain, color: AppColors.lightText.withAlpha(alphaFromOpacity(0.5 * opacity))),
    );
  }
}

// Placeholder for the waveform/sound indicator
class SoundWaveform extends StatelessWidget {
  final Color color;
  const SoundWaveform({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: CustomPaint(
        painter: WaveformPainter(color: color),
        child: Container(),
      ),
    );
  }
}

// Custom Painter for the visual SoundWaveform (simplified)
class WaveformPainter extends CustomPainter {
  final Color color;
  WaveformPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withAlpha(alphaFromOpacity(0.7))
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final barCount = 40;
    final barWidth = size.width / barCount;
    final random = [0.1, 0.4, 0.8, 1.0, 0.6, 0.3, 0.7, 0.9, 0.5, 0.2];

    for (int i = 0; i < barCount; i++) {
      final heightFactor = random[i % random.length] * 0.8 + 0.2;
      final barHeight = size.height * heightFactor;
      final x = barWidth * i + barWidth / 2;
      canvas.drawLine(
        Offset(x, size.height / 2 - barHeight / 2),
        Offset(x, size.height / 2 + barHeight / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// --- 1. Dashboard Screen ---

class MindfulHourses extends StatelessWidget {
  const MindfulHourses({super.key});

  @override
  Widget build(BuildContext context) {
    // Current user's avatar
    final String avatarUrl = 'https://randomuser.me/api/portraits/men/11.jpg';
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mindful Hours', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 26)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 20,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Mindful Hours Display ---
            Container(
              height: 250,
              width: screenWidth,
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circular Progress Placeholder (using a simple CustomPaint for the ring)
                  CustomPaint(
                    size: Size(200, 200),
                    painter: RingPainter(
                      progress: 0.75, // 75% progress
                      backgroundColor: AppColors.backgroundLight,
                      progressColor: AppColors.accentGreen,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '5.21',
                        style: TextStyle(
                          fontSize: 68,
                          fontWeight: FontWeight.w900,
                          color: AppColors.primaryDark,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        'Mindful Hours',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.lightText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Goal: 7 hours',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.accentGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to New Exercise Step 1
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewExerciseGoalScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(FontAwesomeIcons.plus, color: AppColors.cardWhite),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 8),

            // --- Currently Playing Track ---
            Text('Mindful Hour History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
            SizedBox(height: 8),

            WhiteCard(
              child: Column(
                children: [
                  // Track Info and Menu
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen.withAlpha(alphaFromOpacity(0.1)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Icon(FontAwesomeIcons.brain, color: AppColors.accentGreen, size: 20),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Deep Reflection',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '00:02 / 05:00',
                              style: TextStyle(fontSize: 12, color: AppColors.lightText),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'A guided meditation for self-awareness',
                              style: TextStyle(fontSize: 12, color: AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                      Icon(FontAwesomeIcons.ellipsisVertical, color: AppColors.lightText, size: 20),
                    ],
                  ),
                  SizedBox(height: 10),

                  // Progress Bar
                  LinearProgressIndicator(
                    value: 0.4, // 40% progress
                    backgroundColor: AppColors.backgroundLight,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentOrange),
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 8,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today',
                        style: TextStyle(fontSize: 12, color: AppColors.lightText),
                      ),
                      Text(
                        '40% completed',
                        style: TextStyle(fontSize: 12, color: AppColors.accentOrange, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 9),

            // --- Recommended Tracks List (Horizontal Scroll) ---
            Text('Recommended Tracks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
            SizedBox(height: 15),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mindfulTracks.length,
                itemBuilder: (context, index) {
                  final track = mindfulTracks[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: TrackCard(track: track),
                  );
                },
              ),
            ),
            SizedBox(height: 9),

            // --- Weekly Progress ---
            Text('Weekly Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
            SizedBox(height: 15),
            WhiteCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: 9.2 hours',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                      ),
                      Text(
                        '24 sessions',
                        style: TextStyle(fontSize: 14, color: AppColors.lightText),
                      ),
                    ],
                  ),
                  SizedBox(height: 1),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weeklyProgress.length,
                      itemBuilder: (context, index) {
                        final day = weeklyProgress[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: DayProgressCard(day: day),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 9),

            // --- Quick Actions ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MeditationLibraryScreen()));
                    },
                    child: WhiteCard(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.bookOpen, color: AppColors.deepBlue, size: 15),
                          SizedBox(height: 10),
                          Text('Meditation Library', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DailyChallengeScreen()));
                    },
                    child: WhiteCard(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.trophy, color: AppColors.accentOrange, size: 30),
                          SizedBox(height: 10),
                          Text('Daily Challenges', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the Dashboard Ring
class RingPainter extends CustomPainter {
  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  RingPainter({required this.progress, required this.backgroundColor, required this.progressColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 10.0;

    // Background ring
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round; // Rounded ends for the arc

    final sweepAngle = 2 * 3.1415926535 * progress; // 360 degrees * progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.1415926535 / 2, // Start at 12 o'clock (top)
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) => true;
}

class TrackCard extends StatelessWidget {
  final Track track;
  const TrackCard({super.key, required this.track});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: track.color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(track.icon, color: Colors.white, size: 24),
                if (track.isFavorite)
                  Icon(FontAwesomeIcons.solidHeart, color: Colors.white, size: 16),
              ],
            ),
            SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  track.title,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  track.duration,
                  style: TextStyle(color: Colors.white.withAlpha(alphaFromOpacity(0.7)), fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  track.description,
                  style: TextStyle(color: Colors.white.withAlpha(alphaFromOpacity(0.7)), fontSize: 10),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DayProgressCard extends StatelessWidget {
  final DailyProgress day;
  const DayProgressCard({super.key, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              day.day,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
            ),
            SizedBox(height: 8),
            Text(
              '${day.hours}h',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.accentGreen),
            ),
            SizedBox(height: 4),
            Text(
              '${day.sessions} sessions',
              style: TextStyle(fontSize: 10, color: AppColors.lightText),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 2. Mindful Hours Stats Screen ---

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindful Hours Stats'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Total Hours Pie Chart ---
            WhiteCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CustomPaint(
                              painter: PieChartPainter(stats: mindfulStats),
                            ),
                          ),
                          Column(
                            children: [
                              Text('8.21h', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
                              Text('TOTAL', style: TextStyle(fontSize: 12, color: AppColors.lightText, letterSpacing: 1.5)),
                              SizedBox(height: 4),
                              Text('27 sessions', style: TextStyle(fontSize: 10, color: AppColors.lightText)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Divider(color: AppColors.backgroundLight),
                  // Legends
                  ...mindfulStats.map((stat) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(color: stat.color, shape: BoxShape.circle),
                        ),
                        SizedBox(width: 10),
                        Expanded(child: Text(stat.title, style: TextStyle(fontSize: 16))),
                        Text('${stat.hours}h', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
                        SizedBox(width: 10),
                        Text('${stat.percentage}%', style: TextStyle(color: AppColors.lightText)),
                        SizedBox(width: 10),
                        Text('${stat.sessions} sessions', style: TextStyle(color: AppColors.lightText, fontSize: 12)),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 30),

            // --- Daily Statistics ---
            Text('Daily Statistics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
            SizedBox(height: 15),
            ...mindfulStats.map((stat) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: WhiteCard(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: stat.color.withAlpha(alphaFromOpacity(0.15)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(FontAwesomeIcons.plus, color: stat.color, size: 20),
                    ),
                    SizedBox(width: 15),
                    Expanded(child: Text(stat.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))),
                    Text('+${stat.hours}h', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
                    SizedBox(width: 10),
                    Text('${stat.sessions} sessions', style: TextStyle(color: AppColors.lightText, fontSize: 12)),
                  ],
                ),
              ),
            )),
            SizedBox(height: 30),

            // --- Weekly Progress Chart ---
            Text('Weekly Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryDark)),
            SizedBox(height: 15),
            WhiteCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total: 9.2 hours',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                      ),
                      Text(
                        '24 sessions',
                        style: TextStyle(fontSize: 14, color: AppColors.lightText),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: weeklyProgress.length,
                      itemBuilder: (context, index) {
                        final day = weeklyProgress[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: DayProgressCard(day: day),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the Pie Chart
class PieChartPainter extends CustomPainter {
  final List<Statistic> stats;

  PieChartPainter({required this.stats});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    double startAngle = -3.1415926535 / 2; // Start at 12 o'clock

    for (var stat in stats) {
      final sweepAngle = (stat.percentage / 100) * 2 * 3.1415926535;
      final paint = Paint()
        ..color = stat.color
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) => false;
}

// --- 3. New Exercise Goal Selection Screen ---

class NewExerciseGoalScreen extends StatefulWidget {
  const NewExerciseGoalScreen({super.key});

  @override
  NewExerciseGoalScreenState createState() => NewExerciseGoalScreenState();
}

class NewExerciseGoalScreenState extends State<NewExerciseGoalScreen> {
  Goal? selectedGoal;

  final Map<Goal, String> goalMap = {
    Goal.gainnewskills: 'I want to gain new skills',
    Goal.sleepbetter: 'I want to sleep better',
    Goal.beabetterparent: 'I want to be a better parent',
    Goal.boostmyenergy: 'I want to boost my energy',
    Goal.enjoymore: 'I want to enjoy more',
    Goal.findabalance: 'I want to find a balance',
    Goal.reducestress: 'I want to reduce stress',
    Goal.improvefocus: 'I want to improve focus',
  };

  final Map<Goal, IconData> goalIcons = {
    Goal.gainnewskills: FontAwesomeIcons.bookOpen,
    Goal.sleepbetter: FontAwesomeIcons.bed,
    Goal.beabetterparent: FontAwesomeIcons.heart,
    Goal.boostmyenergy: FontAwesomeIcons.bolt,
    Goal.enjoymore: FontAwesomeIcons.faceLaugh,
    Goal.findabalance: FontAwesomeIcons.yinYang,
    Goal.reducestress: FontAwesomeIcons.spa,
    Goal.improvefocus: FontAwesomeIcons.crosshairs,
  };

  final Map<Goal, String> goalDescriptions = {
    Goal.gainnewskills: 'Develop mindfulness techniques',
    Goal.sleepbetter: 'Improve sleep quality',
    Goal.beabetterparent: 'Enhance parenting skills',
    Goal.boostmyenergy: 'Increase daily energy levels',
    Goal.enjoymore: 'Find joy in everyday moments',
    Goal.findabalance: 'Achieve work-life balance',
    Goal.reducestress: 'Lower stress and anxiety',
    Goal.improvefocus: 'Enhance concentration',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exercise', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Step 1/3', style: TextStyle(color: AppColors.lightText, fontSize: 14)),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              "What's your mindful exercise goal?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 9.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: goalMap.length,
                itemBuilder: (context, index) {
                  final goal = goalMap.keys.elementAt(index);
                  return GoalCard(
                    goal: goal,
                    title: goalMap[goal]!,
                    description: goalDescriptions[goal]!,
                    icon: goalIcons[goal]!,
                    isSelected: selectedGoal == goal,
                    onTap: () {
                      setState(() {
                        selectedGoal = goal;
                      });
                    },
                  );
                },
              ),
            ),
          ),
          // Continue Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: ElevatedButton(
              onPressed: selectedGoal == null
                  ? null
                  : () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewExerciseDurationScreen(goal: selectedGoal!)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentOrange,
                minimumSize: Size(double.infinity, 55),
                disabledBackgroundColor: AppColors.lightText.withAlpha(alphaFromOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Continue', style: TextStyle(fontSize: 18, color: AppColors.cardWhite, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Icon(FontAwesomeIcons.arrowRight, color: AppColors.cardWhite, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final Goal goal;
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const GoalCard({super.key,
    required this.goal,
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      isSelected: isSelected,
      selectedColor: AppColors.accentOrange,
      onTap: onTap,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.accentOrange.withAlpha(alphaFromOpacity(0.1)) : AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: isSelected ? AppColors.accentOrange : AppColors.primaryDark, size: 24),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryDark,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- 4. New Exercise Duration Selection Screen ---

class NewExerciseDurationScreen extends StatefulWidget {
  final Goal goal;
  const NewExerciseDurationScreen({super.key, required this.goal});

  @override
  NewExerciseDurationScreenState createState() => NewExerciseDurationScreenState();
}

class NewExerciseDurationScreenState extends State<NewExerciseDurationScreen> {
  int selectedMinutes = 25; // Default

  final List<int> quickOptions = [5, 10, 15, 20, 25, 30];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exercise', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Step 2/3', style: TextStyle(color: AppColors.lightText, fontSize: 14)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12),
              child: Text(
                "How much time do you\nhave for exercise?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                textAlign: TextAlign.center,
              ),
            ),
            // Timer Display
            Column(
              children: [
                WhiteCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 60),
                    child: Text(
                      '${selectedMinutes.toString().padLeft(2, '0')}:00',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryDark,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Minutes',
                  style: TextStyle(fontSize: 16, color: AppColors.lightText),
                ),
                SizedBox(height: 12),
        
                // Quick options
                Text(
                  'Quick options',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: quickOptions.map((minutes) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMinutes = minutes;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selectedMinutes == minutes
                                ? AppColors.accentGreen
                                : AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '$minutes min',
                            style: TextStyle(
                              color: selectedMinutes == minutes
                                  ? AppColors.cardWhite
                                  : AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
        
                SizedBox(height: 30),
                // Simple Slider for duration selection
                Slider(
                  value: selectedMinutes.toDouble(),
                  min: 5,
                  max: 60,
                  divisions: 11,
                  label: selectedMinutes.toString(),
                  activeColor: AppColors.accentGreen,
                  inactiveColor: AppColors.accentGreen.withAlpha(alphaFromOpacity(0.2)),
                  onChanged: (double value) {
                    setState(() {
                      selectedMinutes = value.round();
                    });
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.solidBell, color: AppColors.accentOrange, size: 16),
                      SizedBox(width: 8),
                      Text('Sound: Chirping Birds', style: TextStyle(color: AppColors.accentOrange)),
                    ],
                  ),
                ),
              ],
            ),
            // Continue Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewExerciseSoundscapeScreen(duration: selectedMinutes)));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentOrange,
                  minimumSize: Size(double.infinity, 55),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Continue', style: TextStyle(fontSize: 18, color: AppColors.cardWhite, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Icon(FontAwesomeIcons.arrowRight, color: AppColors.cardWhite, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 5. New Exercise Soundscapes Selection Screen ---

class NewExerciseSoundscapeScreen extends StatefulWidget {
  final int duration;
  const NewExerciseSoundscapeScreen({super.key, required this.duration});

  @override
  NewExerciseSoundscapeScreenState createState() => NewExerciseSoundscapeScreenState();
}

class NewExerciseSoundscapeScreenState extends State<NewExerciseSoundscapeScreen> {
  String? selectedSoundscape = 'Zen Garden';

  final List<String> soundscapes = ['Zen Garden', 'Mountain Stream', 'Ocean Waves', 'Rainforest', 'Desert Wind', 'Night Crickets'];

  final Map<String, String> soundscapeDescriptions = {
    'Zen Garden': 'Peaceful Japanese garden ambiance',
    'Mountain Stream': 'Flowing water in mountain terrain',
    'Ocean Waves': 'Gentle waves on a sandy beach',
    'Rainforest': 'Exotic birds and gentle rain',
    'Desert Wind': 'Calming wind in desert landscape',
    'Night Crickets': 'Soothing night sounds with crickets',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Exercise', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text('Step 3/3', style: TextStyle(color: AppColors.lightText, fontSize: 14)),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 30),
            child: Text(
              "Select Soundscapes",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryDark),
              textAlign: TextAlign.center,
            ),
          ),
          // Waveform and Controls
          SoundWaveform(color: AppColors.accentGreen),
          SizedBox(height: 30),

          // Search Bar Placeholder
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.magnifyingGlass, color: AppColors.lightText, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Search Soundscapes', style: TextStyle(color: AppColors.lightText)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          // Soundscape List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: soundscapes.length,
                itemBuilder: (context, index) {
                  final soundscape = soundscapes[index];
                  bool isSelected = selectedSoundscape == soundscape;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: WhiteCard(
                      isSelected: isSelected,
                      selectedColor: AppColors.accentOrange,
                      onTap: () {
                        setState(() {
                          selectedSoundscape = soundscape;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.accentOrange.withAlpha(alphaFromOpacity(0.1))
                                  : AppColors.backgroundLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              FontAwesomeIcons.music,
                              color: isSelected ? AppColors.accentOrange : AppColors.primaryDark,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  soundscape,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  soundscapeDescriptions[soundscape]!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.lightText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              FontAwesomeIcons.circleCheck,
                              color: AppColors.accentOrange,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Continue Button (Starts the Breathing Exercise)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BreathingExerciseScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGreen,
                minimumSize: Size(double.infinity, 55),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Start Exercise', style: TextStyle(fontSize: 18, color: AppColors.cardWhite, fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Icon(FontAwesomeIcons.play, color: AppColors.cardWhite, size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 6 & 7. Breathing Exercise Screen (Dual Phase) ---

class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  BreathingExerciseScreenState createState() => BreathingExerciseScreenState();
}

class BreathingExerciseScreenState extends State<BreathingExerciseScreen> with SingleTickerProviderStateMixin {
  bool isBreathingIn = true;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  int secondsElapsed = 0;
  int totalSeconds = 25 * 60; // 25 minutes in seconds

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5), // 5s for one cycle (In or Out)
    )..addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        setState(() {
          isBreathingIn = !isBreathingIn;
        });
        _controller.reverse();
      } else if (_controller.status == AnimationStatus.dismissed) {
        setState(() {
          isBreathingIn = !isBreathingIn;
        });
        _controller.forward();
      }
    });

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward(); // Start the first "Breathe In"

    // Start a timer to track elapsed time
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (secondsElapsed < totalSeconds) {
        setState(() {
          secondsElapsed++;
        });
      } else {
        timer.cancel();
        // Exercise completed
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExerciseCompletedScreen()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic Colors based on the phase
    final Color backgroundColor = isBreathingIn ? AppColors.lightGreen : AppColors.darkOrange;
    final Color accentColor = isBreathingIn ? AppColors.darkOrange : AppColors.lightGreen;

    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar with Sound Info
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(alphaFromOpacity(0.15)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.music, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text('Sound: Chirping Birds', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(FontAwesomeIcons.xmark, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),

              Spacer(flex: 2),

              // Breathing Prompt
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Text(
                  isBreathingIn ? 'Breathe In...' : 'Breathe Out...',
                  key: ValueKey<bool>(isBreathingIn),
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 10, color: Colors.black.withAlpha(alphaFromOpacity(0.2)))],
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Breathing Visualizer (AnimatedScale)
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(alphaFromOpacity(0.2)),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white.withAlpha(alphaFromOpacity(0.5)), width: 4),
                  ),
                  alignment: Alignment.center,
                  child: Icon(FontAwesomeIcons.lungs, color: Colors.white, size: 60),
                ),
              ),

              Spacer(flex: 2),

              // Media Controls
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: [
                    // Progress Bar (Placeholder for actual duration)
                    LinearProgressIndicator(
                      value: secondsElapsed / totalSeconds,
                      backgroundColor: Colors.white.withAlpha(alphaFromOpacity(0.3)),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(secondsElapsed), style: TextStyle(color: Colors.white.withAlpha(alphaFromOpacity(0.7)))),
                        Text(formatTime(totalSeconds), style: TextStyle(color: Colors.white.withAlpha(alphaFromOpacity(0.7)))),
                      ],
                    ),
                    SizedBox(height: 30),

                    // Control Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(FontAwesomeIcons.rotateLeft, color: Colors.white.withAlpha(alphaFromOpacity(0.7)), size: 24),
                        // Play/Pause Button
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(alphaFromOpacity(0.2)),
                                blurRadius: 10,
                              )
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              _controller.isAnimating ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                              color: accentColor,
                              size: 32,
                            ),
                            onPressed: () {
                              if (_controller.isAnimating) {
                                _controller.stop();
                              } else {
                                _controller.forward();
                              }
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Finish the exercise and navigate to the completion screen
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExerciseCompletedScreen()));
                          },
                          child: Icon(FontAwesomeIcons.forwardFast, color: Colors.white.withAlpha(alphaFromOpacity(0.7)), size: 24),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Skip and Sleep buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.solidClock, color: Colors.white.withAlpha(alphaFromOpacity(0.7)), size: 16),
                        SizedBox(width: 5),
                        Text('Skip', style: TextStyle(color: Colors.white.withAlpha(alphaFromOpacity(0.7)), fontWeight: FontWeight.w600)),
                        Container(width: 20, height: 1, color: Colors.white.withAlpha(alphaFromOpacity(0.7)), margin: EdgeInsets.symmetric(horizontal: 10)),
                        Icon(FontAwesomeIcons.bed, color: Colors.white.withAlpha(alphaFromOpacity(0.7)), size: 16),
                        SizedBox(width: 5),
                        Text('Sleep', style: TextStyle(color: Colors.white.withAlpha(alphaFromOpacity(0.7)), fontWeight: FontWeight.w600)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 8. Exercise Completed Screen ---

class ExerciseCompletedScreen extends StatelessWidget {
  const ExerciseCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.backgroundLight,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: WhiteCard(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Illustration Placeholder (Mock Asset)
                    AppAssetImage('assets/completion_illustration.png', width: 200, height: 150),
                    SizedBox(height: 30),

                    Text(
                      'Exercise Completed!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: AppColors.primaryDark,
                      ),
                    ),
                    SizedBox(height: 15),

                    // Stats/Details
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _StatItem('48', 'Mindful Score', AppColors.accentGreen),
                          Container(width: 1, height: 30, color: AppColors.lightText.withAlpha(alphaFromOpacity(0.2))),
                          _StatItem('7/10', 'Focus Level', AppColors.accentOrange),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    // More Stats
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem('25:00', 'Duration', AppColors.deepBlue),
                        _StatItem('5', 'Cycles', AppColors.softPurple),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Motivation Text
                    Text(
                      'Your mental health is improving, congratulations!',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightText,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),

                    Text(
                      '"The present moment is filled with joy and happiness. If you are attentive, you will see it."',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryDark,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30),

                    // Button
                    ElevatedButton(
                      onPressed: () {
                        // Navigate back to the Dashboard
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accentGreen,
                        minimumSize: Size(double.infinity, 55),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Got it, Thanks!', style: TextStyle(fontSize: 18, color: AppColors.cardWhite, fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          Icon(FontAwesomeIcons.check, color: AppColors.cardWhite, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _StatItem(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.lightText,
          ),
        ),
      ],
    );
  }
}

// --- 9. Profile Screen ---

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String avatarUrl = 'https://randomuser.me/api/portraits/men/11.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(avatarUrl),
                    radius: 50,
                  ),
                  SizedBox(height: 15),
                  Text(
                    'Alex Johnson',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Mindfulness Enthusiast',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.lightText,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _ProfileStat('42', 'Sessions'),
                      _ProfileStat('15', 'Streak'),
                      _ProfileStat('8.2', 'Hours'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Account Settings
            Text(
              'Account Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 15),
            WhiteCard(
              child: Column(
                children: [
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.user,
                    title: 'Personal Information',
                    onTap: () {},
                  ),
                  Divider(color: AppColors.backgroundLight),
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.bell,
                    title: 'Notification Settings',
                    onTap: () {},
                  ),
                  Divider(color: AppColors.backgroundLight),
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.lock,
                    title: 'Privacy & Security',
                    onTap: () {},
                  ),
                  Divider(color: AppColors.backgroundLight),
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.circleQuestion,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // App Settings
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 15),
            WhiteCard(
              child: Column(
                children: [
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.moon,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                      activeColor: AppColors.accentGreen,
                    ),
                  ),
                  Divider(color: AppColors.backgroundLight),
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.volumeHigh,
                    title: 'Sound Effects',
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppColors.accentGreen,
                    ),
                  ),
                  Divider(color: AppColors.backgroundLight),
                  _ProfileSettingItem(
                    icon: FontAwesomeIcons.language,
                    title: 'Language',
                    trailing: Text('English', style: TextStyle(color: AppColors.lightText)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Logout Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.indicatorRed,
                minimumSize: Size(double.infinity, 55),
              ),
              child: Text('Log Out', style: TextStyle(fontSize: 18, color: AppColors.cardWhite, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  final String value;
  final String label;

  const _ProfileStat(this.value, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.accentGreen,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: AppColors.lightText,
          ),
        ),
      ],
    );
  }
}

class _ProfileSettingItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _ProfileSettingItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: AppColors.accentGreen, size: 20),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
            if (trailing != null)
              trailing!
            else
              Icon(FontAwesomeIcons.chevronRight, color: AppColors.lightText, size: 16),
          ],
        ),
      ),
    );
  }
}

// --- 10. Meditation Library Screen ---

class MeditationLibraryScreen extends StatefulWidget {
  const MeditationLibraryScreen({super.key});

  @override
  MeditationLibraryScreenState createState() => MeditationLibraryScreenState();
}

class MeditationLibraryScreenState extends State<MeditationLibraryScreen> {
  String selectedCategory = 'All';
  List<String> categories = ['All', 'Mindfulness', 'Relaxation', 'Sleep', 'Focus', 'Anxiety'];
  List<Track> filteredTracks = mindfulTracks;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditation Library', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.magnifyingGlass, color: AppColors.lightText, size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text('Search meditations', style: TextStyle(color: AppColors.lightText)),
                  ),
                ],
              ),
            ),
          ),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = category == selectedCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                          if (category == 'All') {
                            filteredTracks = mindfulTracks;
                          } else {
                            filteredTracks = mindfulTracks.where((track) => track.category == category).toList();
                          }
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.accentGreen : AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              color: isSelected ? AppColors.cardWhite : AppColors.primaryDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 20),

          // Meditation Tracks
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView.builder(
                itemCount: filteredTracks.length,
                itemBuilder: (context, index) {
                  final track = filteredTracks[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: WhiteCard(
                      onTap: () {
                        // Navigate to exercise screen
                        Navigator.push(context, MaterialPageRoute(builder: (context) => BreathingExerciseScreen()));
                      },
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: track.color.withAlpha(alphaFromOpacity(0.2)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Icon(track.icon, color: track.color, size: 24),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        track.title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryDark,
                                        ),
                                      ),
                                    ),
                                    if (track.isFavorite)
                                      Icon(FontAwesomeIcons.solidHeart, color: AppColors.softPink, size: 16),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  track.description,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.lightText,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Text(
                                      track.duration,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.lightText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${track.completedMinutes} min completed',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.accentGreen,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- 11. Daily Challenge Screen ---

class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Challenges', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Progress',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryDark,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.accentGreen.withAlpha(alphaFromOpacity(0.2)),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '3/4 Completed',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.accentGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  LinearProgressIndicator(
                    value: 0.75,
                    backgroundColor: AppColors.backgroundLight,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGreen),
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 8,
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Points Earned: 120',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentOrange,
                        ),
                      ),
                      Text(
                        'Streak: 7 days',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBlue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            // Daily Challenges
            Text(
              'Today\'s Challenges',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 15),
            ...dailyChallenges.map((challenge) => Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: WhiteCard(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: challenge.color.withAlpha(alphaFromOpacity(0.2)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.center,
                          child: Icon(challenge.icon, color: challenge.color, size: 24),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                challenge.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                challenge.description,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.lightText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${challenge.points} pts',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentOrange,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Progress: ${challenge.progress}/${challenge.target}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.lightText,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: LinearProgressIndicator(
                            value: challenge.progress / challenge.target,
                            backgroundColor: AppColors.backgroundLight,
                            valueColor: AlwaysStoppedAnimation<Color>(challenge.color),
                            borderRadius: BorderRadius.circular(4),
                            minHeight: 6,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    if (challenge.progress < challenge.target)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: challenge.color,
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Text('Start Challenge', style: TextStyle(fontSize: 14, color: AppColors.cardWhite)),
                      ),
                  ],
                ),
              ),
            )),
            SizedBox(height: 30),

            // Achievements
            Text(
              'Your Achievements',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primaryDark,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: achievements.length,
                itemBuilder: (context, index) {
                  final achievement = achievements[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: WhiteCard(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: achievement.unlocked
                                  ? achievement.color.withAlpha(alphaFromOpacity(0.2))
                                  : AppColors.backgroundLight,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              achievement.icon,
                              color: achievement.unlocked ? achievement.color : AppColors.lightText,
                              size: 24,
                            ),
                          ),
                          SizedBox(height: 7),
                          Text(
                            achievement.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: achievement.unlocked ? AppColors.primaryDark : AppColors.lightText,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 3),
                          Text(
                            achievement.unlocked ? 'Unlocked' : 'Locked',
                            style: TextStyle(
                              fontSize: 12,
                              color: achievement.unlocked ? AppColors.accentGreen : AppColors.lightText,
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
      ),
    );
  }
}