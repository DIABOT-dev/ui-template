import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

// --- Data Models and Helpers ---

// Helper function to convert opacity double (0.0 - 1.0) to an Alpha integer (0 - 255)
int _alphaFromOpacity(double opacity) => (255 * opacity).round();

// Custom Color Palette based on the design
class AppColors {
  static const Color primaryPurple = Color(0xFF7C54E7);
  static const Color secondaryOrange = Color(0xFFFF9A68);
  static const Color accentGreen = Color(0xFF56C596);
  static const Color darkBrown = Color(0xFF59453C);
  static const Color lightBackground = Color(0xFFF7F7F7);
  static const Color cardWhite = Colors.white;
  static const Color textDark = Color(0xFF333333);
  static const Color textLight = Color(0xFF888888);

  // Chart Colors (Wedge Chart/Insights)
  static const Color chartDeepBrown = Color(0xFF59453C);
  static const Color chartLightBrown = Color(0xFFCCB39B);
  static const Color chartYellow = Color(0xFFF7E64B);
  static const Color chartDarkGreen = Color(0xFF287E56);
  static const Color chartBlue = Color(0xFF5D8BF4);
}

// Enhanced User Data
class User {
  final String name;
  final String avatarUrl;
  final int age;
  final double height; // in cm
  final double weight; // in kg
  final List<String> sleepGoals;

  User({
    required this.name,
    required this.avatarUrl,
    required this.age,
    required this.height,
    required this.weight,
    required this.sleepGoals,
  });
}

// Enhanced Sleep Log Data
class SleepLog {
  final String category;
  final double hours;
  final Color color;
  final String description;
  final IconData icon;

  SleepLog({
    required this.category,
    required this.hours,
    required this.color,
    required this.description,
    required this.icon,
  });
}

// Sleep Session Data
class SleepSession {
  final DateTime date;
  final DateTime bedtime;
  final DateTime wakeupTime;
  final double qualityScore; // 0-100
  final List<SleepLog> sleepStages;
  final List<String> factors;

  SleepSession({
    required this.date,
    required this.bedtime,
    required this.wakeupTime,
    required this.qualityScore,
    required this.sleepStages,
    required this.factors,
  });

  Duration get duration => wakeupTime.difference(bedtime);
}

// Sleep Insight Data
class SleepInsight {
  final String title;
  final String description;
  final String status;
  final String value;
  final IconData icon;
  final Color color;
  final List<String> recommendations;

  SleepInsight({
    required this.title,
    required this.description,
    required this.status,
    required this.value,
    required this.icon,
    required this.color,
    required this.recommendations,
  });
}

// Enum for sleep cycle status
enum SleepStatus {
  pending,
  inProgress,
  completed,
  failed,
}

// --- Custom Painter for Wedge Chart (Screen 2) ---

class WedgeChartPainter extends CustomPainter {
  final List<SleepLog> data;
  WedgeChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    double totalHours = data.fold(0, (sum, item) => sum + item.hours);
    double startAngle = -math.pi / 2;
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width, size.height) / 2;

    for (var log in data) {
      final sweepAngle = (log.hours / totalHours) * 2 * math.pi;
      final paint = Paint()
        ..color = log.color
        ..style = PaintingStyle.fill;

      // Draw the arc segment
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true, // Use center point to draw wedges
        paint,
      );
      startAngle += sweepAngle;
    }

    // Draw the white circle in the middle
    final centerPaint = Paint()..color = AppColors.cardWhite;
    canvas.drawCircle(center, radius * 0.45, centerPaint);
  }

  @override
  bool shouldRepaint(covariant WedgeChartPainter oldDelegate) => true;
}

// --- Main Application Widget ---

class SleepQuality extends StatelessWidget {
  const SleepQuality({super.key});

  @override
  Widget build(BuildContext context) {
    // Enhanced Data setup
    final List<SleepLog> sleepData = [
      SleepLog(
        category: 'Light Sleep',
        hours: 2.5,
        color: AppColors.chartYellow,
        description: 'Light sleep is important for memory consolidation and learning.',
        icon: FontAwesomeIcons.cloudMoon,
      ),
      SleepLog(
        category: 'REM',
        hours: 1.5,
        color: AppColors.secondaryOrange,
        description: 'REM sleep is crucial for emotional regulation and creativity.',
        icon: FontAwesomeIcons.brain,
      ),
      SleepLog(
        category: 'Deep Sleep',
        hours: 1.0,
        color: AppColors.chartDarkGreen,
        description: 'Deep sleep is vital for physical restoration and immune function.',
        icon: FontAwesomeIcons.bed,
      ),
      SleepLog(
        category: 'Awake',
        hours: 0.5,
        color: AppColors.chartDeepBrown,
        description: 'Brief awakenings are normal but should be minimal.',
        icon: FontAwesomeIcons.eye,
      ),
    ];

    // Enhanced user data
    final User currentUser = User(
      name: 'Alex Johnson',
      avatarUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
      age: 32,
      height: 178,
      weight: 75,
      sleepGoals: ['8 hours per night', 'Consistent bedtime', 'Reduce screen time before bed'],
    );

    return MaterialApp(
      title: 'Sleep Quality',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: AppColors.lightBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryPurple,
            foregroundColor: AppColors.cardWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: SleepQualityOverviewScreen(sleepData: sleepData, user: currentUser),
    );
  }
}

// --- Screen 1: Sleep Quality Overview (Radial Progress and Wedge Chart) ---

class SleepQualityOverviewScreen extends StatefulWidget {
  final List<SleepLog> sleepData;
  final User user;
  const SleepQualityOverviewScreen({super.key, required this.sleepData, required this.user});

  @override
  State<SleepQualityOverviewScreen> createState() => _SleepQualityOverviewScreenState();
}

class _SleepQualityOverviewScreenState extends State<SleepQualityOverviewScreen> with SingleTickerProviderStateMixin {
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
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Top Purple Section
                Container(
                  height: 375,
                  padding: const EdgeInsets.only(top: 50, left: 24, right: 24, bottom: 1),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryPurple,
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                  ),
                  child: Stack(
                    children: [
                      // Decorative elements
                      Positioned(
                        top: 50,
                        right: -30,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.1)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 50,
                        left: -40,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.1)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),

                      // App Bar
                      Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(widget.user.avatarUrl),
                            ),
                          ],
                        ),
                      ),

                      // Radial Progress Content
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 21),
                            Text(
                              'Sleep Quality',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.8)),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  '20',
                                  style: TextStyle(
                                    fontSize: 80,
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.cardWhite,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryOrange.withAlpha(_alphaFromOpacity(0.3)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      '-5%',
                                      style: TextStyle(
                                        color: AppColors.cardWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'You are Insomniac',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.secondaryOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Bottom Cards
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildSleepMetricCard(
                                  context,
                                  'Sleep Time',
                                  '8.5h',
                                  AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.1)),
                                  AppColors.cardWhite,
                                  FontAwesomeIcons.clock,
                                ),
                                _buildSleepMetricCard(
                                  context,
                                  'Deep Sleep',
                                  '7.0h',
                                  AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.1)),
                                  AppColors.cardWhite,
                                  FontAwesomeIcons.heart,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Body Content
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Title
                      Text(
                        'Sleep Quality Details',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 7),

                      // Wedge Chart Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Chart Area
                            SizedBox(
                              width: 150,
                              height: 150,
                              child: CustomPaint(
                                painter: WedgeChartPainter(widget.sleepData),
                                child: const Center(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('5.5h', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                      Text('Total', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),

                            // Legend
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.sleepData.map((log) => _buildLegendItem(log)).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Weekly Sleep Pattern Chart
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.cardWhite,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Weekly Sleep Pattern',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 150,
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
                                          if (value == 0) {
                                            return const Text('');
                                          }
                                          return Text(
                                            '${value.toInt()}h',
                                            style: const TextStyle(
                                              color: Colors.grey,
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
                                  minX: 0,
                                  maxX: 6,
                                  minY: 0,
                                  maxY: 10,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: [
                                        const FlSpot(0, 7.5),
                                        const FlSpot(1, 6.8),
                                        const FlSpot(2, 8.2),
                                        const FlSpot(3, 7.0),
                                        const FlSpot(4, 5.5),
                                        const FlSpot(5, 8.0),
                                        const FlSpot(6, 8.5),
                                      ],
                                      isCurved: true,
                                      color: AppColors.primaryPurple,
                                      barWidth: 3,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(
                                        show: true,
                                        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                                          radius: 4,
                                          color: AppColors.primaryPurple,
                                          strokeWidth: 2,
                                          strokeColor: AppColors.cardWhite,
                                        ),
                                      ),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        color: AppColors.primaryPurple.withAlpha(_alphaFromOpacity(0.1)),
                                      ),
                                    ),
                                  ],
                                ),
                                duration: const Duration(milliseconds: 250),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Navigation Buttons
                      _buildNavigationButton(
                        context,
                        'View Calendar & Logs',
                        AppColors.primaryPurple,
                            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SleepCalendarScreen())),
                        icon: FontAwesomeIcons.calendarDays,
                      ),
                      const SizedBox(height: 10),
                      _buildNavigationButton(
                        context,
                        'Start Sleep Session',
                        AppColors.darkBrown,
                            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const StartSleepSessionScreen())),
                        icon: FontAwesomeIcons.moon,
                      ),
                      const SizedBox(height: 10),
                      _buildNavigationButton(
                        context,
                        'View Sleep Insights',
                        AppColors.accentGreen,
                            () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SleepInsightsScreen())),
                        icon: FontAwesomeIcons.lightbulb,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSleepMetricCard(
      BuildContext context,
      String title,
      String value,
      Color backgroundColor,
      Color textColor,
      IconData icon,
      ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: textColor.withAlpha(_alphaFromOpacity(0.7))),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(color: textColor, fontSize: 20),
              ),
            ],
          ),
          FaIcon(icon, color: textColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildLegendItem(SleepLog log) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: log.color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(log.category, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(
                  log.description,
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text('${log.hours}h', style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// --- Screen 3: Calendar and Log Tracker ---

class SleepCalendarScreen extends StatefulWidget {
  const SleepCalendarScreen({super.key});

  @override
  State<SleepCalendarScreen> createState() => _SleepCalendarScreenState();
}

class _SleepCalendarScreenState extends State<SleepCalendarScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Enhanced Calendar Data
  final List<int> days = const [
    26, 27, 28, 29, 30, 31, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16,
    17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29,
  ];

  // Enhanced Sleep Sessions
  final List<SleepSession> sleepSessions = [
    SleepSession(
      date: DateTime(2025, 1, 15),
      bedtime: DateTime(2025, 1, 14, 23, 30),
      wakeupTime: DateTime(2025, 1, 15, 7, 45),
      qualityScore: 85,
      sleepStages: [
        SleepLog(category: 'Light Sleep', hours: 2.5, color: AppColors.chartYellow, description: '', icon: FontAwesomeIcons.cloudMoon),
        SleepLog(category: 'REM', hours: 1.5, color: AppColors.secondaryOrange, description: '', icon: FontAwesomeIcons.brain),
        SleepLog(category: 'Deep Sleep', hours: 3.0, color: AppColors.chartDarkGreen, description: '', icon: FontAwesomeIcons.bed),
        SleepLog(category: 'Awake', hours: 0.5, color: AppColors.chartDeepBrown, description: '', icon: FontAwesomeIcons.eye),
      ],
      factors: ['Stressful day', 'Late meal', 'Room temperature'],
    ),
    SleepSession(
      date: DateTime(2025, 1, 14),
      bedtime: DateTime(2025, 1, 13, 22, 45),
      wakeupTime: DateTime(2025, 1, 14, 6, 30),
      qualityScore: 72,
      sleepStages: [
        SleepLog(category: 'Light Sleep', hours: 3.0, color: AppColors.chartYellow, description: '', icon: FontAwesomeIcons.cloudMoon),
        SleepLog(category: 'REM', hours: 1.0, color: AppColors.secondaryOrange, description: '', icon: FontAwesomeIcons.brain),
        SleepLog(category: 'Deep Sleep', hours: 2.0, color: AppColors.chartDarkGreen, description: '', icon: FontAwesomeIcons.bed),
        SleepLog(category: 'Awake', hours: 0.5, color: AppColors.chartDeepBrown, description: '', icon: FontAwesomeIcons.eye),
      ],
      factors: ['Screen time before bed', 'Caffeine in the afternoon'],
    ),
  ];

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
        title: const Text('Sleep Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bars),
            onPressed: () {},
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
              // Month Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('January 2025', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      IconButton(icon: const FaIcon(FontAwesomeIcons.chevronLeft, size: 16), onPressed: () {}),
                      IconButton(icon: const FaIcon(FontAwesomeIcons.chevronRight, size: 16), onPressed: () {}),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Calendar Grid Card
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Weekday labels
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Su', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Mo', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Tu', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('We', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Th', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Fr', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                        Text('Sa', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Days Grid
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemCount: days.length,
                      itemBuilder: (context, index) {
                        bool isCurrentMonth = days[index] < 32 && days[index] > 5;
                        bool isToday = days[index] == 15 && isCurrentMonth;
                        bool hasData = (days[index] == 14 || days[index] == 15) && isCurrentMonth;
                        return Center(
                          child: Container(
                            width: 40,
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isToday ? AppColors.primaryPurple : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border: isCurrentMonth && days[index] == 14
                                  ? Border.all(color: AppColors.primaryPurple, width: 2)
                                  : null,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(
                                  '${days[index]}',
                                  style: TextStyle(
                                    color: isToday
                                        ? AppColors.cardWhite
                                        : isCurrentMonth
                                        ? Colors.black87
                                        : Colors.grey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (hasData)
                                  Positioned(
                                    bottom: 2,
                                    child: Container(
                                      width: 4,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: isToday ? AppColors.cardWhite : AppColors.primaryPurple,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Sleep Logs Section
              const Text(
                'Recent Sleep Sessions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Sleep Logs List
              ...sleepSessions.map((session) => _buildSleepSessionCard(context, session)),

              const SizedBox(height: 20),

              // Add Sleep Log Button
              _buildNavigationButton(
                context,
                'Add New Sleep Log',
                AppColors.accentGreen,
                    () => debugPrint('Adding new log...'),
                icon: FontAwesomeIcons.plus,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSleepSessionCard(BuildContext context, SleepSession session) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${session.date.day}/${session.date.month}/${session.date.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getQualityColor(session.qualityScore).withAlpha(_alphaFromOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${session.qualityScore}%',
                    style: TextStyle(
                      color: _getQualityColor(session.qualityScore),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(FontAwesomeIcons.moon, size: 16, color: Colors.grey),
                const SizedBox(width: 5),
                Text(
                  '${session.bedtime.hour}:${session.bedtime.minute.toString().padLeft(2, '0')} - ${session.wakeupTime.hour}:${session.wakeupTime.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  '${session.duration.inHours}h ${session.duration.inMinutes % 60}m',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Sleep stages
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: session.sleepStages.map((stage) {
                return Column(
                  children: [
                    FaIcon(stage.icon, color: stage.color, size: 16),
                    const SizedBox(height: 2),
                    Text(
                      '${stage.hours}h',
                      style: TextStyle(
                        color: stage.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            // Factors
            if (session.factors.isNotEmpty)
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: session.factors.map((factor) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      factor,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  Color _getQualityColor(double score) {
    if (score >= 80) return AppColors.accentGreen;
    if (score >= 60) return AppColors.secondaryOrange;
    return AppColors.chartDeepBrown;
  }
}

// --- Screen 4: Start Sleep Session (Timer/Brown Screen) ---

class StartSleepSessionScreen extends StatefulWidget {
  const StartSleepSessionScreen({super.key});

  @override
  State<StartSleepSessionScreen> createState() => _StartSleepSessionScreenState();
}

class _StartSleepSessionScreenState extends State<StartSleepSessionScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;
  bool _isTimerRunning = false;
  int _seconds = 0;
  SleepStatus _status = SleepStatus.pending;

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
      backgroundColor: AppColors.darkBrown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: AppColors.cardWhite),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.solidMoon),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Text(
            'Start Sleeping',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.9)),
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 50),

          // Circular Timer
          GestureDetector(
            onTap: () {
              setState(() {
                _isTimerRunning = !_isTimerRunning;
                if (_isTimerRunning) {
                  _status = SleepStatus.inProgress;
                  _startTimer();
                } else {
                  _status = SleepStatus.pending;
                }
              });
            },
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isTimerRunning ? _pulseAnimation.value : 1.0,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppColors.chartLightBrown.withAlpha(_alphaFromOpacity(0.15)),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.chartLightBrown.withAlpha(_alphaFromOpacity(0.2)),
                        width: 5,
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                              color: AppColors.chartLightBrown,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: FaIcon(
                                _isTimerRunning ? FontAwesomeIcons.pause : FontAwesomeIcons.solidCirclePlay,
                                color: AppColors.darkBrown.withAlpha(_alphaFromOpacity(0.8)),
                                size: 60,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _formatDuration(_seconds),
                            style: const TextStyle(
                              color: AppColors.cardWhite,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 50),

          // Status Text
          Text(
            _getStatusText(),
            style: TextStyle(
              color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.8)),
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 30),

          // Start Group Session Button
          GestureDetector(
            onTap: () {
              // Start group session logic
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.1)),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.3))),
              ),
              child: const Text(
                'Start Group Session',
                style: TextStyle(color: AppColors.cardWhite, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Sleep Settings
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.1)),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
            Column(
            children: [
            const FaIcon(FontAwesomeIcons.temperatureLow, color: AppColors.cardWhite, size: 20),
            const SizedBox(height: 5),
            Text(
              '20°C',
              style: TextStyle(color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.8))),
            ),
            ],
          ),
          Column(
              children: [
              const FaIcon(FontAwesomeIcons.volumeLow, color: AppColors.cardWhite, size: 20),
          const SizedBox(height: 5),
          Text(
            'Quiet',
            style: TextStyle(color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.8)))),
            ],
          ),
          Column(
            children: [
              const FaIcon(FontAwesomeIcons.lightbulb, color: AppColors.cardWhite, size: 20),
              const SizedBox(height: 5),
              Text(
                'Dim',
                style: TextStyle(color: AppColors.cardWhite.withAlpha(_alphaFromOpacity(0.8)))),
                ],
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

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_isTimerRunning) {
        setState(() {
          _seconds++;
        });
        _startTimer();
      }
    });
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _getStatusText() {
    switch (_status) {
      case SleepStatus.pending:
        return 'Tap to start tracking your sleep';
      case SleepStatus.inProgress:
        return 'Tracking your sleep...';
      case SleepStatus.completed:
        return 'Sleep session completed';
      case SleepStatus.failed:
        return 'Sleep session failed';
    }
  }
}

// --- Screen 8: Sleep Insights with Charts ---

class SleepInsightsScreen extends StatefulWidget {
  const SleepInsightsScreen({super.key});

  @override
  State<SleepInsightsScreen> createState() => _SleepInsightsScreenState();
}

class _SleepInsightsScreenState extends State<SleepInsightsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // Enhanced Insight Items
  final List<SleepInsight> insightItems = [
    SleepInsight(
      title: 'Loud Talking',
      description: 'Your sleep was disrupted by loud talking episodes during the night.',
      status: 'Fixed',
      value: '12/day',
      icon: FontAwesomeIcons.microphone,
      color: AppColors.chartDeepBrown,
      recommendations: [
        'Use white noise machine to mask external sounds',
        'Consider earplugs for better sleep',
        'Discuss with family members about keeping noise levels down'
      ],
    ),
    SleepInsight(
      title: 'Temp Adjustment',
      description: 'Room temperature fluctuations are affecting your sleep quality.',
      status: 'Change your status',
      value: '02:00',
      icon: FontAwesomeIcons.temperatureThreeQuarters,
      color: AppColors.secondaryOrange,
      recommendations: [
        'Maintain room temperature between 18-22°C',
        'Use breathable bedding materials',
        'Consider a smart thermostat for temperature regulation'
      ],
    ),
    SleepInsight(
      title: 'Temp Irregularity',
      description: 'Your body temperature is irregular during sleep cycles.',
      status: 'Next step is to buy an A/C',
      value: '4x',
      icon: FontAwesomeIcons.fire,
      color: AppColors.chartBlue,
      recommendations: [
        'Invest in air conditioning for better temperature control',
        'Use cooling gel pads or pillows',
        'Take a warm bath before sleep to regulate body temperature'
      ],
    ),
    SleepInsight(
      title: 'Sleep Consistency',
      description: 'Your bedtime varies significantly from night to night.',
      status: 'Needs improvement',
      value: '2.5h',
      icon: FontAwesomeIcons.clock,
      color: AppColors.primaryPurple,
      recommendations: [
        'Establish a consistent sleep schedule',
        'Set reminders for bedtime',
        'Avoid screens 1 hour before bed'
      ],
    ),
  ];

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
        title: const Text('Sleep Insights', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sleep Score Over Time Chart
              Container(
                height: 200,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sleep Score Over Time',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 15),
                    Expanded(
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
                                  if (value == 0) {
                                    return const Text('');
                                  }
                                  return Text(
                                    '${value.toInt()}',
                                    style: const TextStyle(
                                      color: Colors.grey,
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
                                  toY: 75,
                                  color: AppColors.primaryPurple,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 1,
                              barRods: [
                                BarChartRodData(
                                  toY: 82,
                                  color: AppColors.primaryPurple,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 2,
                              barRods: [
                                BarChartRodData(
                                  toY: 68,
                                  color: AppColors.secondaryOrange,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 3,
                              barRods: [
                                BarChartRodData(
                                  toY: 90,
                                  color: AppColors.accentGreen,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 4,
                              barRods: [
                                BarChartRodData(
                                  toY: 72,
                                  color: AppColors.secondaryOrange,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 5,
                              barRods: [
                                BarChartRodData(
                                  toY: 85,
                                  color: AppColors.primaryPurple,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ),
                            BarChartGroupData(
                              x: 6,
                              barRods: [
                                BarChartRodData(
                                  toY: 78,
                                  color: AppColors.primaryPurple,
                                  width: 22,
                                  borderRadius: BorderRadius.circular(4),
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

              const SizedBox(height: 11),

              // Sleep Factors Chart
              Container(
                height: 255,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.cardWhite,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sleep Factors Impact',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 21),
                    Expanded(
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: [
                            PieChartSectionData(
                              color: AppColors.primaryPurple,
                              value: 35,
                              title: 'Stress',
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardWhite,
                              ),
                              radius: 60,
                            ),
                            PieChartSectionData(
                              color: AppColors.secondaryOrange,
                              value: 25,
                              title: 'Caffeine',
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardWhite,
                              ),
                              radius: 60,
                            ),
                            PieChartSectionData(
                              color: AppColors.chartBlue,
                              value: 20,
                              title: 'Exercise',
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardWhite,
                              ),
                              radius: 60,
                            ),
                            PieChartSectionData(
                              color: AppColors.accentGreen,
                              value: 20,
                              title: 'Diet',
                              titleStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.cardWhite,
                              ),
                              radius: 60,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Suggestions Section
              Text(
                'Suggestions',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 15),

              // Suggestion Cards
              ...insightItems.map((item) => _buildInsightCard(context, item)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard(BuildContext context, SleepInsight item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.cardWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: item.color.withAlpha(_alphaFromOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FaIcon(item.icon, color: item.color, size: 20),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.description,
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: item.color.withAlpha(_alphaFromOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    item.value,
                    style: TextStyle(
                      color: item.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status: ${item.status}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showRecommendations(context, item);
                    },
                    child: const Text(
                      'View Recommendations',
                      style: TextStyle(
                        color: AppColors.primaryPurple,
                        fontWeight: FontWeight.bold,
                      ),
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

  void _showRecommendations(BuildContext context, SleepInsight item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: item.color.withAlpha(_alphaFromOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FaIcon(item.icon, color: item.color, size: 20),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Recommendations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ...item.recommendations.map((rec) => Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text(rec)),
                  ],
                ),
              )),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryPurple,
                    foregroundColor: AppColors.cardWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// --- Common Widget for Navigation Buttons ---

Widget _buildNavigationButton(
    BuildContext context,
    String text,
    Color color,
    VoidCallback onTap, {
      IconData? icon,
    }) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(15),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(_alphaFromOpacity(0.3)),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FaIcon(icon, color: AppColors.cardWhite, size: 20),
              ),
            Text(
              text,
              style: const TextStyle(
                color: AppColors.cardWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}