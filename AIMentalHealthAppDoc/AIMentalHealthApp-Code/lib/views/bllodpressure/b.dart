import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

// Helper for opacity to Alpha conversion
int _alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}

// Dummy Data Generators
final Random _random = Random();

String getRandomUserImageUrl() {
  final int gender = _random.nextInt(2);
  final String genderStr = gender == 0 ? 'men' : 'women';
  final int id = _random.nextInt(100);
  return 'https://randomuser.me/api/portraits/$genderStr/$id.jpg';
}

List<FlSpot> generateRandomSpots({
  int count = 7,
  double minY = 0,
  double maxY = 100,
}) {
  return List.generate(count, (i) {
    return FlSpot(i.toDouble(), minY + _random.nextDouble() * (maxY - minY));
  });
}

// Reusable AppBar
PreferredSizeWidget buildAppBar({
  required BuildContext context,
  String title = '',
  List<Widget>? actions,
  bool showBackArrow = true,
}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: showBackArrow
        ? IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.chevronLeft,
              color: Colors.black87,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : null,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
    centerTitle: false,
    actions: actions,
  );
}

// Reusable white card widget
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final Color backgroundColor;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = 15.0,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(_alphaFromOpacity(0.08)),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}

// --- Blood Pressure Screen (Main Screen) ---
class BloodddddPressureScreen extends StatefulWidget {
  const BloodddddPressureScreen({super.key});

  @override
  State<BloodddddPressureScreen> createState() =>
      _BloodddddPressureScreenState();
}

class _BloodddddPressureScreenState extends State<BloodddddPressureScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  String bloodPressureStatus = 'Above normal. Eat less sugar!';
  int currentSystolic = 121;
  int currentDiastolic = 80;
  int currentOxygen = 70;
  int currentCholesterol = 50;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
      appBar: buildAppBar(
        context: context,
        title: 'Blood Pressure',
        showBackArrow: false,
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.gear,
              color: Colors.black87,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
            // Blood Pressure Reading Card
            AppCard(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$currentSystolic',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A5A9A),
                        ),
                      ),
                      Text(
                        '/ $currentDiastolic sys',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    bloodPressureStatus,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.redAccent.withAlpha(_alphaFromOpacity(0.8)),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Animated progress circle
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 180,
                            height: 180,
                            child: CircularProgressIndicator(
                              value: 0.7 * _animation.value,
                              strokeWidth: 10,
                              backgroundColor: Colors.grey.withAlpha(
                                _alphaFromOpacity(0.2),
                              ),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                const Color(0xFF8E8DCC),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.heartPulse,
                                color: Color(0xFF8E8DCC),
                                size: 40,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${(15 * _animation.value).round()} Sec Left',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                          const Positioned(
                            left: 0,
                            top: 80,
                            child: Text(
                              '0s',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          const Positioned(
                            right: 0,
                            top: 80,
                            child: Text(
                              '20s',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 11),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMeasurementItem(
                        FontAwesomeIcons.droplet,
                        'Oxygen',
                        '$currentOxygen spO2',
                        Colors.redAccent,
                      ),
                      _buildMeasurementItem(
                        FontAwesomeIcons.capsules,
                        'Cholesterol',
                        '$currentCholesterol mg',
                        Colors.orange,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 9),

            // Swipe to start reading button
            GestureDetector(
              onHorizontalDragEnd: (details) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starting reading...')),
                );
              },
              child: AppCard(
                backgroundColor: const Color(0xFF5A5A9A),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 11.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(_alphaFromOpacity(0.3)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.solidFlag,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Swipe to start reading...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 11),

            // Mental Health Section
            const Text(
              'Mental Health',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(_)=>MoodTrackerScreen()));

              },
              child: AppCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Mood Tracker',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(_)=>MeditationScreen()));

              },
              child: AppCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Meditation Sessions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Blood Pressure History Navigation
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BloodPressureHistoryScreen(),
                  ),
                );
              },
              child: AppCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Blood Pressure History',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Risks and Recommendations Section
            const Text(
              'All Risks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildRiskCard(
              'Major Depression',
              'Lower your blood pressure by exercising regularly.',
              const Color(0xFF5A5A9A),
            ),
            _buildRiskCard(
              'Anxiety Disorder',
              'Play video games to relax your mind.',
              const Color(0xFF8E8DCC),
            ),
            _buildRiskCard(
              'Social Trauma',
              'Interact more with your friends and family.',
              Colors.green,
            ),
            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllRisksScreen(),
                    ),
                  );
                },
                child: Text(
                  'See All Risks',
                  style: TextStyle(
                    color: const Color(0xFF5A5A9A),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementItem(
    IconData icon,
    String title,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Row(
          children: [
            FaIcon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildRiskCard(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withAlpha(_alphaFromOpacity(0.1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: color,
                  size: 20,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Mood Tracker Screen ---
class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  State<MoodTrackerScreen> createState() => _MoodTrackerScreenState();
}

class _MoodTrackerScreenState extends State<MoodTrackerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> moods = [
    {'emoji': '😊', 'label': 'Happy', 'color': Colors.yellow},
    {'emoji': '😔', 'label': 'Sad', 'color': Colors.blue},
    {'emoji': '😠', 'label': 'Angry', 'color': Colors.red},
    {'emoji': '😰', 'label': 'Anxious', 'color': Colors.purple},
    {'emoji': '😴', 'label': 'Tired', 'color': Colors.grey},
    {'emoji': '🤗', 'label': 'Excited', 'color': Colors.orange},
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
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
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Mood Tracker'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood selection section
            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 20),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                          itemCount: moods.length,
                          itemBuilder: (context, index) {
                            final mood = moods[index];
                            return GestureDetector(
                              onTap: () {
                                _showMoodConfirmation(mood);
                              },
                              child: AnimatedBuilder(
                                animation: _scaleAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale:
                                        _scaleAnimation.value *
                                        (1.0 - (index * 0.05)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: mood['color'].withAlpha(
                                          _alphaFromOpacity(0.1),
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: mood['color'].withAlpha(
                                            _alphaFromOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            mood['emoji'],
                                            style: const TextStyle(
                                              fontSize: 32,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            mood['label'],
                                            style: TextStyle(
                                              color: mood['color'],
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Mood history chart
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Mood This Week',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                const style = TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                );
                                Widget text;
                                switch (value.toInt()) {
                                  case 0:
                                    text = const Text('Mon', style: style);
                                    break;
                                  case 1:
                                    text = const Text('Tue', style: style);
                                    break;
                                  case 2:
                                    text = const Text('Wed', style: style);
                                    break;
                                  case 3:
                                    text = const Text('Thu', style: style);
                                    break;
                                  case 4:
                                    text = const Text('Fri', style: style);
                                    break;
                                  case 5:
                                    text = const Text('Sat', style: style);
                                    break;
                                  case 6:
                                    text = const Text('Sun', style: style);
                                    break;
                                  default:
                                    text = const Text('');
                                }
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: text,
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              getTitlesWidget: (value, meta) {
                                const style = TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                );
                                String? text;
                                if (value == 1) {
                                  text = 'Sad';
                                } else if (value == 3) {
                                  text = 'Neutral';
                                } else if (value == 5) {
                                  text = 'Happy';
                                }
                                return text == null
                                    ? const SizedBox.shrink()
                                    : SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        child: Text(text, style: style),
                                      );
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        minX: 0,
                        maxX: 6,
                        minY: 0,
                        maxY: 6,
                        lineBarsData: [
                          LineChartBarData(
                            spots: const [
                              FlSpot(0, 3),
                              FlSpot(1, 2),
                              FlSpot(2, 4),
                              FlSpot(3, 5),
                              FlSpot(4, 3),
                              FlSpot(5, 4),
                              FlSpot(6, 5),
                            ],
                            isCurved: true,
                            barWidth: 3,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF5A5A9A), Color(0xFF8E8ED0)],
                            ),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, bar, index) {
                                return FlDotCirclePainter(
                                  radius: 5,
                                  color: const Color(0xFF5A5A9A),
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(
                                    0xFF5A5A9A,
                                  ).withValues(alpha: 0.3),
                                  const Color(
                                    0xFF5A5A9A,
                                  ).withValues(alpha: 0.05),
                                ],
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
            const SizedBox(height: 20),

            // Mood insights
            const Text(
              'Mood Insights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            AppCard(
              child: Column(
                children: [
                  _buildInsightItem(
                    'You\'ve been feeling happier on weekends',
                    FontAwesomeIcons.chartLine,
                    Colors.green,
                  ),
                  const SizedBox(height: 15),
                  _buildInsightItem(
                    'Try meditation to improve your mood consistency',
                    FontAwesomeIcons.brain,
                    const Color(0xFF8E8DCC),
                  ),
                  const SizedBox(height: 15),
                  _buildInsightItem(
                    'Your mood dips mid-week - plan something fun on Wednesdays',
                    FontAwesomeIcons.calendarDay,
                    Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Mood journal
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mood Journal',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Write about your day...',
                      hintStyle: TextStyle(
                        color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey.withAlpha(_alphaFromOpacity(0.3)),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Color(0xFF5A5A9A)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Journal entry saved!')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A5A9A),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Save Entry',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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

  void _showMoodConfirmation(Map<String, dynamic> mood) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(mood['emoji'], style: const TextStyle(fontSize: 60)),
                const SizedBox(height: 10),
                Text(
                  'You\'re feeling ${mood['label']}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Mood recorded: ${mood['label']}'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mood['color'],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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

  Widget _buildInsightItem(String text, IconData icon, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(_alphaFromOpacity(0.1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: FaIcon(icon, color: color, size: 20)),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

// --- Meditation Screen ---
class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  bool isPlaying = false;
  int selectedDuration = 5; // in minutes
  int remainingSeconds = 5 * 60;
  String selectedType = 'Breathing';

  final List<Map<String, dynamic>> meditationTypes = [
    {'name': 'Breathing', 'icon': FontAwesomeIcons.wind, 'color': Colors.blue},
    {
      'name': 'Mindfulness',
      'icon': FontAwesomeIcons.brain,
      'color': Colors.purple,
    },
    {'name': 'Sleep', 'icon': FontAwesomeIcons.moon, 'color': Colors.indigo},
    {
      'name': 'Anxiety Relief',
      'icon': FontAwesomeIcons.heart,
      'color': Colors.red,
    },
    {'name': 'Focus', 'icon': FontAwesomeIcons.eye, 'color': Colors.green},
  ];

  final List<int> durations = [1, 3, 5, 10, 15, 20];

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _breathingController, curve: Curves.easeInOut),
    );

    _progressController = AnimationController(
      duration: Duration(seconds: remainingSeconds),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.linear),
    );

    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _breathingController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _breathingController.forward();
      }
    });
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void _toggleMeditation() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _breathingController.forward();
        _progressController.forward();
      } else {
        _breathingController.stop();
        _progressController.stop();
      }
    });
  }

  void _resetMeditation() {
    setState(() {
      isPlaying = false;
      remainingSeconds = selectedDuration * 60;
      _progressController.reset();
      _progressController.duration = Duration(seconds: remainingSeconds);
      _breathingController.reset();
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSecs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSecs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Meditation'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Meditation player
            AppCard(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    selectedType,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Breathing animation
                  AnimatedBuilder(
                    animation: _breathingAnimation,
                    builder: (context, child) {
                      return Container(
                        width: 180 * _breathingAnimation.value,
                        height: 180 * _breathingAnimation.value,
                        decoration: BoxDecoration(
                          color: Colors.blue.withAlpha(_alphaFromOpacity(0.1)),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            isPlaying ? 'Breathe In' : 'Ready?',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue.withAlpha(
                                _alphaFromOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  // Progress indicator
                  AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return Column(
                        children: [
                          LinearProgressIndicator(
                            value: 1.0 - _progressAnimation.value,
                            backgroundColor: Colors.grey.withAlpha(
                              _alphaFromOpacity(0.2),
                            ),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xFF5A5A9A),
                            ),
                            minHeight: 8,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _formatTime(
                              (remainingSeconds * _progressAnimation.value)
                                  .round(),
                            ),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  // Control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: _resetMeditation,
                        icon: const FaIcon(
                          FontAwesomeIcons.rotateLeft,
                          size: 24,
                        ),
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 20),
                      FloatingActionButton(
                        onPressed: _toggleMeditation,
                        backgroundColor: const Color(0xFF5A5A9A),
                        child: FaIcon(
                          isPlaying
                              ? FontAwesomeIcons.pause
                              : FontAwesomeIcons.play,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 20),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const MeditationLibraryScreen(),
                            ),
                          );
                        },
                        icon: const FaIcon(FontAwesomeIcons.list, size: 24),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Meditation type selection
            const Text(
              'Meditation Type',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: meditationTypes.length,
                itemBuilder: (context, index) {
                  final type = meditationTypes[index];
                  final isSelected = type['name'] == selectedType;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedType = type['name'];
                      });
                    },
                    child: Container(
                      width: 100,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? type['color'].withAlpha(_alphaFromOpacity(0.2))
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isSelected
                              ? type['color']
                              : Colors.grey.withAlpha(_alphaFromOpacity(0.3)),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(type['icon'], color: type['color'], size: 30),
                          const SizedBox(height: 8),
                          Text(
                            type['name'],
                            style: TextStyle(
                              color: isSelected
                                  ? type['color']
                                  : Colors.black87,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Duration selection
            const Text(
              'Duration',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: durations.map((duration) {
                final isSelected = duration == selectedDuration;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDuration = duration;
                      remainingSeconds = duration * 60;
                      _progressController.reset();
                      _progressController.duration = Duration(
                        seconds: remainingSeconds,
                      );
                    });
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF5A5A9A)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF5A5A9A)
                            : Colors.grey.withAlpha(_alphaFromOpacity(0.3)),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$duration min',
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Meditation stats
            const Text(
              'Your Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            AppCard(
              child: Column(
                children: [
                  _buildStatItem(
                    'Current Streak',
                    '7 days',
                    FontAwesomeIcons.fire,
                    Colors.orange,
                  ),
                  const SizedBox(height: 15),
                  _buildStatItem(
                    'Total Time',
                    '3h 45m',
                    FontAwesomeIcons.clock,
                    const Color(0xFF5A5A9A),
                  ),
                  const SizedBox(height: 15),
                  _buildStatItem(
                    'Sessions Completed',
                    '24',
                    FontAwesomeIcons.circleCheck,
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(_alphaFromOpacity(0.1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: FaIcon(icon, color: color, size: 20)),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Meditation Library Screen ---
class MeditationLibraryScreen extends StatelessWidget {
  const MeditationLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Meditation Library'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            AppCard(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search meditations...',
                  hintStyle: TextStyle(
                    color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryCard(
                    'Sleep',
                    FontAwesomeIcons.moon,
                    Colors.indigo,
                  ),
                  _buildCategoryCard(
                    'Anxiety',
                    FontAwesomeIcons.heart,
                    Colors.red,
                  ),
                  _buildCategoryCard(
                    'Focus',
                    FontAwesomeIcons.eye,
                    Colors.green,
                  ),
                  _buildCategoryCard(
                    'Stress',
                    FontAwesomeIcons.brain,
                    Colors.purple,
                  ),
                  _buildCategoryCard(
                    'Breathing',
                    FontAwesomeIcons.wind,
                    Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Popular meditations
            const Text(
              'Popular Meditations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildMeditationCard(
              'Deep Sleep',
              'Fall asleep peacefully with this guided meditation',
              '15 min',
              FontAwesomeIcons.moon,
              Colors.indigo,
            ),
            _buildMeditationCard(
              'Anxiety Relief',
              'Release tension and find calm in moments of stress',
              '10 min',
              FontAwesomeIcons.heart,
              Colors.red,
            ),
            _buildMeditationCard(
              'Morning Focus',
              'Start your day with clarity and intention',
              '5 min',
              FontAwesomeIcons.sun,
              Colors.orange,
            ),
            _buildMeditationCard(
              'Body Scan',
              'Release physical tension and connect with your body',
              '20 min',
              FontAwesomeIcons.person,
              Colors.green,
            ),
            const SizedBox(height: 20),

            // Recently played
            const Text(
              'Recently Played',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildMeditationCard(
              'Evening Wind Down',
              'Release the day and prepare for restful sleep',
              '12 min',
              FontAwesomeIcons.cloudMoon,
              Colors.purple,
            ),
            _buildMeditationCard(
              'Quick Calm',
              'A short meditation for moments of stress',
              '3 min',
              FontAwesomeIcons.bolt,
              Colors.yellow,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, Color color) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(_alphaFromOpacity(0.1)),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: color.withAlpha(_alphaFromOpacity(0.3))),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildMeditationCard(
    String title,
    String description,
    String duration,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color.withAlpha(_alphaFromOpacity(0.1)),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: FaIcon(icon, color: color, size: 30)),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.8)),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 5),
                IconButton(
                  onPressed: () {
                    // Play meditation
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.circlePlay,
                    color: color,
                    size: 24,
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

// --- Settings Screen ---
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Settings'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section
            AppCard(
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://randomuser.me/api/portraits/men/11.jpg',
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Alex Johnson',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'alex.johnson@example.com',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.withAlpha(
                              _alphaFromOpacity(0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Settings sections
            const Text(
              'Account',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingItem(
              'Personal Information',
              FontAwesomeIcons.user,
              () {},
            ),
            _buildSettingItem(
              'Notification Settings',
              FontAwesomeIcons.bell,
              () {},
            ),
            _buildSettingItem(
              'Privacy & Security',
              FontAwesomeIcons.lock,
              () {},
            ),
            const SizedBox(height: 20),

            const Text(
              'Health Data',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingItem(
              'Health Records',
              FontAwesomeIcons.fileMedical,
              () {},
            ),
            _buildSettingItem(
              'Data Sharing',
              FontAwesomeIcons.shareNodes,
              () {},
            ),
            _buildSettingItem(
              'Connected Devices',
              FontAwesomeIcons.bluetooth,
              () {},
            ),
            const SizedBox(height: 20),

            const Text(
              'Support',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingItem(
              'Help Center',
              FontAwesomeIcons.circleQuestion,
              () {},
            ),
            _buildSettingItem('Contact Us', FontAwesomeIcons.envelope, () {}),
            _buildSettingItem(
              'Terms of Service',
              FontAwesomeIcons.fileContract,
              () {},
            ),
            const SizedBox(height: 20),

            // App info
            AppCard(
              child: Column(
                children: [
                  const Text(
                    'Mindful Health Tracker',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Version 1.2.3',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.8)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5A5A9A),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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

  Widget _buildSettingItem(String title, IconData icon, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppCard(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 5.0,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF5A5A9A,
                    ).withAlpha(_alphaFromOpacity(0.1)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: FaIcon(
                      icon,
                      color: const Color(0xFF5A5A9A),
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- Blood Pressure History Screen ---
class BloodPressureHistoryScreen extends StatelessWidget {
  const BloodPressureHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Blood Pressure History'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimeFilterChip('1 Day', true),
                    _buildTimeFilterChip('1 Week', false),
                    _buildTimeFilterChip('1 Month', false),
                    _buildTimeFilterChip('1 Year', false),
                    _buildTimeFilterChip('All', false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Dummy Chart Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Blood Pressure Trends',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: false),
                        titlesData: const FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: generateRandomSpots(
                              count: 7,
                              minY: 100,
                              maxY: 140,
                            ),
                            isCurved: true,
                            barWidth: 3,
                            color: const Color(0xFF5A5A9A),
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Color(
                                0xFF5A5A9A,
                              ).withAlpha(_alphaFromOpacity(0.2)),
                            ),
                          ),
                          LineChartBarData(
                            spots: generateRandomSpots(
                              count: 7,
                              minY: 60,
                              maxY: 90,
                            ),
                            isCurved: true,
                            barWidth: 3,
                            color: const Color(0xFF8E8DCC),
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(
                              show: true,
                              color: Color(
                                0xFF8E8DCC,
                              ).withAlpha(_alphaFromOpacity(0.2)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // History List
            const Text(
              'Recent Readings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            _buildHistoryItem(
              'Jan 12, 2028',
              129,
              68,
              'Stage 2',
              Colors.redAccent,
            ),
            _buildHistoryItem('Jan 11, 2028', 118, 77, 'Normal', Colors.green),
            _buildHistoryItem(
              'Jan 10, 2028',
              114,
              68,
              '3 AI Suggestion',
              const Color(0xFF5A5A9A),
            ),
            _buildHistoryItem(
              'Jan 09, 2028',
              135,
              85,
              'High',
              Colors.deepOrange,
            ),
            _buildHistoryItem('Jan 08, 2028', 110, 70, 'Normal', Colors.green),
            _buildHistoryItem(
              'Jan 07, 2028',
              120,
              75,
              'Pre-hypertension',
              Colors.orange,
            ),

            const SizedBox(height: 20),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BloodPressureDetailsScreen(),
                    ),
                  );
                },
                child: Text(
                  'View All History',
                  style: TextStyle(
                    color: const Color(0xFF5A5A9A),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeFilterChip(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF5A5A9A) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: isSelected
            ? null
            : Border.all(color: Colors.grey.withAlpha(_alphaFromOpacity(0.3))),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildHistoryItem(
    String date,
    int systolic,
    int diastolic,
    String status,
    Color statusColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '$systolic',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      ' sys $diastolic dia',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withAlpha(_alphaFromOpacity(0.15)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FaIcon(
                  FontAwesomeIcons.chevronRight,
                  color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Blood Pressure Details Screen ---
class BloodPressureDetailsScreen extends StatelessWidget {
  const BloodPressureDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Blood Pressure Details'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Jan 12, 2028',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.calendarDays,
                        color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: false,
                          horizontalInterval: 20,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: Colors.grey.withAlpha(
                                _alphaFromOpacity(0.1),
                              ),
                              strokeWidth: 1,
                            );
                          },
                        ),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                String text;
                                switch (value.toInt()) {
                                  case 0:
                                    text = 'Wed';
                                    break;
                                  case 1:
                                    text = 'Thu';
                                    break;
                                  case 2:
                                    text = 'Fri';
                                    break;
                                  case 3:
                                    text = 'Sat';
                                    break;
                                  case 4:
                                    text = 'Sun';
                                    break;
                                  case 5:
                                    text = 'Mon';
                                    break;
                                  case 6:
                                    text = 'Tue';
                                    break;
                                  default:
                                    return Container();
                                }
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  child: Text(
                                    text,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 20,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                );
                              },
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withAlpha(
                                _alphaFromOpacity(0.2),
                              ),
                              width: 1,
                            ),
                            left: BorderSide(
                              color: Colors.grey.withAlpha(
                                _alphaFromOpacity(0.2),
                              ),
                              width: 1,
                            ),
                          ),
                        ),
                        minX: 0,
                        maxX: 6,
                        minY: 60,
                        maxY: 160,
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 120),
                              FlSpot(1, 125),
                              FlSpot(2, 130),
                              FlSpot(3, 118),
                              FlSpot(4, 140),
                              FlSpot(5, 122),
                              FlSpot(6, 129),
                            ],
                            isCurved: true,
                            color: const Color(0xFF5A5A9A),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              getDotPainter: (spot, percent, bar, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: const Color(0xFF5A5A9A),
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 75),
                              FlSpot(1, 80),
                              FlSpot(2, 82),
                              FlSpot(3, 70),
                              FlSpot(4, 90),
                              FlSpot(5, 78),
                              FlSpot(6, 80),
                            ],
                            isCurved: true,
                            color: const Color(0xFF8E8DCC),
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(
                              getDotPainter: (spot, percent, bar, index) {
                                return FlDotCirclePainter(
                                  radius: 4,
                                  color: const Color(0xFF8E8DCC),
                                  strokeWidth: 2,
                                  strokeColor: Colors.white,
                                );
                              },
                            ),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circle,
                        size: 10,
                        color: const Color(0xFF5A5A9A),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '129-141 sys',
                        style: TextStyle(color: Colors.black87),
                      ),
                      const SizedBox(width: 20),
                      FaIcon(
                        FontAwesomeIcons.circle,
                        size: 10,
                        color: const Color(0xFF8E8DCC),
                      ),
                      const SizedBox(width: 5),
                      const Text(
                        '70-99 mmHg',
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Highlights
            const Text(
              'Highlights',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHighlightItem(
                    'You recorded blood pressure on 4 days in a row.',
                    Colors.green,
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Your Average BP for these days:',
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _buildDayCircle('Sun', false),
                      _buildDayCircle('Mon', false),
                      _buildDayCircle('Tue', true),
                      _buildDayCircle('Wed', true),
                      _buildDayCircle('Thu', true),
                      _buildDayCircle('Fri', true),
                      _buildDayCircle('Sat', false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Risks Section
            const Text(
              'Risks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            _buildRiskCard(
              'High Blood Pressure',
              'Your average blood pressure is elevated. Consult your doctor.',
              Colors.redAccent,
            ),
            _buildRiskCard(
              'Potential Heart Disease',
              'Consistently high readings may indicate risk. Seek medical advice.',
              Colors.orange,
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AllRisksScreen(),
                    ),
                  );
                },
                child: Text(
                  'See All Risks',
                  style: TextStyle(
                    color: const Color(0xFF5A5A9A),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightItem(String text, Color iconColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FaIcon(FontAwesomeIcons.circleCheck, color: iconColor, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCircle(String day, bool recorded) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: recorded
              ? const Color(0xFF8E8DCC)
              : Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            day.substring(0, 1),
            style: TextStyle(
              color: recorded ? Colors.white : Colors.black54,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRiskCard(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withAlpha(_alphaFromOpacity(0.1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: color,
                  size: 20,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

// --- All Risks Screen ---
class AllRisksScreen extends StatelessWidget {
  const AllRisksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'All Risks'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Health Risks',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Risk categories
            _buildRiskCategory('Cardiovascular Risks', [
              _buildRiskItem(
                'High Blood Pressure',
                'Elevated readings could lead to heart disease',
                Colors.redAccent,
              ),
              _buildRiskItem(
                'Heart Disease',
                'Based on your cholesterol levels',
                Colors.orange,
              ),
              _buildRiskItem(
                'Stroke Risk',
                'Irregular blood pressure patterns detected',
                Colors.deepOrange,
              ),
            ]),

            const SizedBox(height: 20),

            _buildRiskCategory('Mental Health Risks', [
              _buildRiskItem(
                'Major Depression',
                'Lower your blood pressure by exercising regularly',
                const Color(0xFF5A5A9A),
              ),
              _buildRiskItem(
                'Anxiety Disorder',
                'Play video games to relax your mind',
                const Color(0xFF8E8DCC),
              ),
              _buildRiskItem(
                'Social Trauma',
                'Interact more with your friends and family',
                Colors.green,
              ),
            ]),

            const SizedBox(height: 20),

            _buildRiskCategory('Lifestyle Risks', [
              _buildRiskItem(
                'Sedentary Lifestyle',
                'You\'ve been inactive for 5+ hours daily',
                Colors.blue,
              ),
              _buildRiskItem(
                'Poor Diet',
                'High sugar intake detected in food logs',
                Colors.purple,
              ),
              _buildRiskItem(
                'Sleep Deprivation',
                'Average sleep time is less than 6 hours',
                Colors.indigo,
              ),
            ]),

            const SizedBox(height: 30),

            // Recommendation section
            const Text(
              'Recommendations',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRecommendationItem(
                    'Exercise Regularly',
                    'Aim for 30 minutes of moderate activity 5 days a week',
                    FontAwesomeIcons.dumbbell,
                  ),
                  const SizedBox(height: 15),
                  _buildRecommendationItem(
                    'Balanced Diet',
                    'Reduce sugar and sodium intake, increase fruits and vegetables',
                    FontAwesomeIcons.appleWhole,
                  ),
                  const SizedBox(height: 15),
                  _buildRecommendationItem(
                    'Regular Checkups',
                    'Schedule monthly appointments with your healthcare provider',
                    FontAwesomeIcons.stethoscope,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Consult doctor button
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contacting healthcare provider...'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5A5A9A),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Consult a Doctor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  Widget _buildRiskCategory(String title, List<Widget> risks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        ...risks,
      ],
    );
  }

  Widget _buildRiskItem(String title, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withAlpha(_alphaFromOpacity(0.1)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.triangleExclamation,
                  color: color,
                  size: 20,
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
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),
            FaIcon(
              FontAwesomeIcons.chevronRight,
              color: Colors.grey.withAlpha(_alphaFromOpacity(0.6)),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(
    String title,
    String description,
    IconData icon,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF5A5A9A).withAlpha(_alphaFromOpacity(0.1)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: FaIcon(icon, color: const Color(0xFF5A5A9A), size: 20),
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
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
