import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mentalhealth/widgets/d.dart';

import '../notifications/n.dart';

// Define your custom colors
const Color primaryColor = Color(0xFF5D5FEF); // Deep purple/blue
const Color accentColor = Color(0xFFF0F2FF); // Lightest purple background
const Color cardColor1 = Color(0xFFE9F8E9); // Light green for Freud Score
const Color cardColor2 = Color(0xFFFFECEF); // Light red/pink for Mood Sad
const Color healthyGreen = Color(0xFF4CAF50); // Green for healthy score
const Color sadRed = Color(0xFFEF5350); // Red for sad mood
const Color mindfulHourColor = Color(0xFFE0E7FF); // Light blue
const Color sleepQualityColor = Color(0xFFE0F7FA); // Light cyan
const Color journalColor = Color(0xFFFFF3E0); // Light orange
const Color stressLevelColor = Color(0xFFFCE4EC); // Light pink
const Color moodTrackerColor = Color(0xFFE8F5E9); // Light green for mood tracker

// Resource model class
class Resource {
  final String id;
  final String imagePath;
  final String category;
  final String title;
  final String likes;
  final String comments;

  Resource({
    required this.id,
    required this.imagePath,
    required this.category,
    required this.title,
    required this.likes,
    required this.comments,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _fabController;
  late AnimationController _headerController;
  late AnimationController _searchController;
  late AnimationController _metricsController;
  late AnimationController _trackerController;
  late AnimationController _chatbotController;
  late AnimationController _resourcesController;
  late List<AnimationController> _trackerItemControllers;
  late List<AnimationController> _resourceItemControllers;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _searchController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _metricsController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _trackerController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _chatbotController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _resourcesController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    // Initialize tracker item controllers
    _trackerItemControllers = List.generate(5, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    });

    // Initialize resource item controllers
    _resourceItemControllers = List.generate(3, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    });

    // Start animations in sequence
    _startAnimations();
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _headerController.forward();
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _searchController.forward();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      _metricsController.forward();
    });

    Future.delayed(const Duration(milliseconds: 700), () {
      _trackerController.forward();
      _startTrackerItemAnimations();
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      _chatbotController.forward();
    });

    Future.delayed(const Duration(milliseconds: 1100), () {
      _resourcesController.forward();
      _startResourceItemAnimations();
    });

    Future.delayed(const Duration(milliseconds: 1300), () {
      _fabController.forward();
    });
  }

  void _startTrackerItemAnimations() {
    for (int i = 0; i < _trackerItemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 100), () {
        if (mounted) {
          _trackerItemControllers[i].forward();
        }
      });
    }
  }

  void _startResourceItemAnimations() {
    for (int i = 0; i < _resourceItemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150), () {
        if (mounted) {
          _resourceItemControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _fabController.dispose();
    _headerController.dispose();
    _searchController.dispose();
    _metricsController.dispose();
    _trackerController.dispose();
    _chatbotController.dispose();
    _resourcesController.dispose();

    for (var controller in _trackerItemControllers) {
      controller.dispose();
    }

    for (var controller in _resourceItemControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom AppBar and User Header
            FadeTransition(
              opacity: _headerController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _headerController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 8,
                    left: 16,
                    right: 16,
                    bottom: 12,
                  ),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6A11CB),
                        Color(0xFF2575FC),
                      ],
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Left Drawer Icon
                      Builder(
                        builder: (context) => IconButton(
                          icon: const Icon(FontAwesomeIcons.bars, color: Colors.white),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Profile Avatar
                      Hero(
                        tag: 'profile_avatar',
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withAlpha(153), width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(77),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/11.jpg',
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Center Text Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 500),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withAlpha(255),
                              ),
                              child: const Text('Hi, Shinomiya!'),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber.withAlpha(255), size: 16),
                                Text(' Pro • ', style: TextStyle(color: Colors.white.withAlpha(204))),
                                Icon(FontAwesomeIcons.solidFaceSmileWink, color: Colors.green, size: 16),
                                Text(' 80% • ', style: TextStyle(color: Colors.white.withAlpha(204))),

                              ],
                            ),
                          ],
                        ),
                      ),

                      // Right Notification Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(51),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(51),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.notifications_none, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) =>  NotificationsScreenssssss()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 2),

                  // Mental Health Metrics
                  _buildSectionTitle(
                    'Mental Health Metrics',
                    _metricsController,
                  ),
                  const SizedBox(height: 2),
                  _buildAnimatedMentalHealthMetrics(),
                  const SizedBox(height: 2),

                  // Mindful Tracker
                  _buildSectionTitle(
                    'Mindful Tracker',
                    _trackerController,
                  ),
                  const SizedBox(height: 1),
                  _buildAnimatedMindfulTracker(),
                  const SizedBox(height: 6),

                  // AI Therapy Chatbot
                  _buildSectionTitle(
                    'AI Therapy Chatbot',
                    _chatbotController,
                  ),
                  const SizedBox(height: 5),
                  _buildAnimatedChatbotCard(),
                  const SizedBox(height: 6),

                  // Mindful Resources
                  _buildAnimatedResourcesSection(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget _buildSectionTitle(String title, AnimationController controller) {
    return FadeTransition(
      opacity: controller,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.3, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        )),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withAlpha(255),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        primaryColor.withAlpha(255),
                        primaryColor.withAlpha(51),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedMentalHealthMetrics() {
    return FadeTransition(
      opacity: _metricsController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _metricsController,
          curve: Curves.easeOutCubic,
        )),
        child: Row(
          children: [
            // Freud Score Card
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                transform: Matrix4.identity()..scale(1.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FreudScoreDetailsScreen()),
                    );
                  },
                  child: Hero(
                    tag: 'freud_score_card',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            healthyGreen.withAlpha(230),
                            healthyGreen.withAlpha(180),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withAlpha(51), // Using alpha (20% opacity)
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: Colors.black.withAlpha(26), // Using alpha (10% opacity)
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          // Background Pattern
                          Positioned(
                            right: -20,
                            top: -20,
                            child: Transform.rotate(
                              angle: -0.3,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(26), // Using alpha (10% opacity)
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          // Content
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(230),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.green.withAlpha(51), // Using alpha (20% opacity)
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.brain,
                                        color: healthyGreen,
                                        size: 24,
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withAlpha(153), // Using alpha (60% opacity)
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Today',
                                        style: TextStyle(
                                          color: healthyGreen,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Freud Score',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withAlpha(230),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Animated Score Display
                                SizedBox(
                                  height: 120,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      // Background Circle
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withAlpha(51), // Using alpha (20% opacity)
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      // Animated Progress Ring
                                      TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 0, end: 0.8),
                                        duration: const Duration(milliseconds: 1500),
                                        curve: Curves.elasticOut,
                                        builder: (context, value, child) {
                                          return SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: CircularProgressIndicator(
                                              value: value,
                                              strokeWidth: 8,
                                              backgroundColor: Colors.white.withAlpha(77), // Using alpha (30% opacity)
                                              valueColor: AlwaysStoppedAnimation<Color>(
                                                Colors.white.withAlpha(230),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // Score Text
                                      TweenAnimationBuilder<int>(
                                        tween: IntTween(begin: 0, end: 80),
                                        duration: const Duration(milliseconds: 1500),
                                        builder: (context, value, child) {
                                          return Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$value',
                                                style: TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                'Healthy',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
                                                ),
                                              ),
                                            ],
                                          );
                                        },
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
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Mood Card
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                transform: Matrix4.identity()..scale(1.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        sadRed.withAlpha(230),
                        sadRed.withAlpha(180),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withAlpha(51), // Using alpha (20% opacity)
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: Colors.black.withAlpha(26), // Using alpha (10% opacity)
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background Pattern
                      Positioned(
                        left: -20,
                        bottom: -20,
                        child: Transform.rotate(
                          angle: 0.3,
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(26), // Using alpha (10% opacity)
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(230),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.red.withAlpha(51), // Using alpha (20% opacity)
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.faceSadTear,
                                    color: sadRed,
                                    size: 24,
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(153), // Using alpha (60% opacity)
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'This Week',
                                    style: TextStyle(
                                      color: sadRed,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Mood',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withAlpha(230),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Sad',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Animated Mood Chart
                            SizedBox(
                              height: 80,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Mood Icons
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.faceFrown,
                                        color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
                                        size: 20,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Mon',
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(153), // Using alpha (60% opacity)
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 8),
                                  // Animated Bars
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildAnimatedMoodBar(8, 0),
                                        _buildAnimatedMoodBar(12, 1),
                                        _buildAnimatedMoodBar(10, 2),
                                        _buildAnimatedMoodBar(15, 3),
                                        _buildAnimatedMoodBar(7, 4),
                                        _buildAnimatedMoodBar(11, 5),
                                        _buildAnimatedMoodBar(9, 6),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Mood Icons
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
                                        size: 20,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Sun',
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(153), // Using alpha (60% opacity)
                                          fontSize: 10,
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

  // Helper widget for animated mood bars
  Widget _buildAnimatedMoodBar(double height, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: height / 20),
      duration: Duration(milliseconds: 800 + (index * 100)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Container(
          height: 60 * value,
          width: 8,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
            borderRadius: BorderRadius.circular(4),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedMindfulTracker() {
    return FadeTransition(
      opacity: _trackerController,
      child: Column(
        children: [
          _buildAnimatedTrackerItem(
            index: 0,
            icon: FontAwesomeIcons.hourglassHalf,
            iconColor: primaryColor,
            backgroundColor: mindfulHourColor,
            title: 'Mindful Hours',
            value: '2.5h/8h Today',
            graphData: [
              FlSpot(0, 3),
              FlSpot(1, 4),
              FlSpot(2, 2.5),
              FlSpot(3, 5),
              FlSpot(4, 3.5),
              FlSpot(5, 4.5),
            ],
            graphColor: primaryColor,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MindfulHoursScreen()),
              );
            },
          ),

          _buildAnimatedTrackerItem(
            index: 2,
            icon: FontAwesomeIcons.bookOpen,
            iconColor: Colors.orange,
            backgroundColor: journalColor,
            title: 'Mindful Journal',
            value: '64 Day Streak',
            graphData: [
              FlSpot(0, 1),
              FlSpot(1, 2),
              FlSpot(2, 3),
              FlSpot(3, 2.5),
              FlSpot(4, 3.5),
              FlSpot(5, 4),
            ],
            graphColor: Colors.orange,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const JournalScreen()),
              );
            },
          ),
          _buildAnimatedTrackerItem(
            index: 3,
            icon: FontAwesomeIcons.fire,
            iconColor: Colors.redAccent,
            backgroundColor: stressLevelColor,
            title: 'Stress Level',
            value: 'Level 3 (Normal)',
            stressLevel: 0.6,
          ),
          _buildAnimatedTrackerItem(
            index: 4,
            icon: FontAwesomeIcons.faceSmile,
            iconColor: Colors.green,
            backgroundColor: moodTrackerColor,
            title: 'Mood Tracker',
            value: 'Sad → Happy → Neutral',
          ),

        ],
      ),
    );
  }


  Widget _buildAnimatedTrackerItem({
    required int index,
    required IconData icon,
    required Color iconColor,
    required Color backgroundColor,
    required String title,
    required String value,
    String? badgeText,
    List<FlSpot>? graphData,
    Color? graphColor,
    double? stressLevel,
    VoidCallback? onTap,
  }) {
    final AnimationController controller = _trackerItemControllers[index];

    return FadeTransition(
      opacity: controller,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        )),
        child: MindfulTrackerItem(
          icon: icon,
          iconColor: iconColor,
          backgroundColor: backgroundColor,
          title: title,
          value: value,
          badgeText: badgeText,
          graphData: graphData,
          graphColor: graphColor,
          stressLevel: stressLevel,
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _buildAnimatedChatbotCard() {
    return FadeTransition(
      opacity: _chatbotController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _chatbotController,
          curve: Curves.easeOutCubic,
        )),
        child: Card(
          elevation: 0,
          color: Colors.white.withAlpha(255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChatbotScreen()),
              );
            },
            borderRadius: BorderRadius.circular(16),
            splashColor: primaryColor.withAlpha(51), // Using alpha (20% opacity)
            highlightColor: primaryColor.withAlpha(26), // Using alpha (10% opacity)
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: 2541),
                          duration: const Duration(milliseconds: 1500),
                          builder: (context, value, child) {
                            return Text(
                              '$value',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withAlpha(255),
                              ),
                            );
                          },
                        ),
                        Text(
                          'Conversations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black.withAlpha(255),
                          ),
                        ),
                        Text(
                          '83 left this month',
                          style: TextStyle(
                            color: Colors.grey.withAlpha(153),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber.withAlpha(255)),
                            Text(
                              ' Go Pro. Now!',
                              style: TextStyle(
                                color: primaryColor.withAlpha(255),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Hero(
                        tag: 'chatbot_image',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            'https://img.freepik.com/free-vector/chatbot-messenger-concept-with-options-functions-symbols-isometric-illustration_1284-65144.jpg',
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ScaleTransition(
                          scale: CurvedAnimation(
                            parent: _chatbotController,
                            curve: Curves.elasticOut,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: primaryColor.withAlpha(255),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(77), // Using alpha (30% opacity)
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add, color: Colors.white.withAlpha(255)),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: ScaleTransition(
                          scale: CurvedAnimation(
                            parent: _chatbotController,
                            curve: Curves.elasticOut,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: accentColor.withAlpha(255),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(77), // Using alpha (30% opacity)
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.settings, color: primaryColor.withAlpha(255)),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedResourcesSection() {
    return FadeTransition(
      opacity: _resourcesController,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _resourcesController,
          curve: Curves.easeOutCubic,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mindful Resources',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withAlpha(255),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ResourcesScreen()),
                    );
                  },
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: primaryColor.withAlpha(255),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return _buildAnimatedResourceCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedResourceCard(int index) {
    final AnimationController controller = _resourceItemControllers[index];

    // Create unique resource with unique ID
    final resource = Resource(
      id: 'resource_$index',
      imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
      category: 'Mental Health',
      title: 'Will meditation help you get out from the rat race?',
      likes: '5,241',
      comments: '987',
    );

    return FadeTransition(
      opacity: controller,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutCubic,
        )),
        child: ResourceCard(
          resource: resource,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ResourceDetailScreen(resource: resource)),
            );
          },
        ),
      ),
    );
  }
}

// Helper widget for Mindful Tracker Items
class MindfulTrackerItem extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String value;
  final String? badgeText;
  final List<FlSpot>? graphData;
  final Color? graphColor;
  final double? stressLevel;
  final VoidCallback? onTap;

  const MindfulTrackerItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.value,
    this.badgeText,
    this.graphData,
    this.graphColor,
    this.stressLevel,
    this.onTap,
  });

  @override
  State<MindfulTrackerItem> createState() => _MindfulTrackerItemState();
}

class _MindfulTrackerItemState extends State<MindfulTrackerItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedCard(
        animation: _scaleAnimation,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(20),
          splashColor: widget.iconColor.withAlpha(51), // Using alpha (20% opacity)
          highlightColor: widget.iconColor.withAlpha(26), // Using alpha (10% opacity)
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withAlpha(255),
                  Colors.white.withAlpha(230),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: widget.iconColor.withAlpha(26), // Using alpha (10% opacity)
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Icon Container
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor.withAlpha(255),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: widget.iconColor.withAlpha(51), // Using alpha (20% opacity)
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: widget.iconColor.withAlpha(255),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withAlpha(255),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.value,
                          style: TextStyle(
                            color: Colors.grey.withAlpha(153),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Additional Info
                  if (widget.badgeText != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: widget.iconColor.withAlpha(26), // Using alpha (10% opacity)
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.badgeText!,
                        style: TextStyle(
                          color: widget.iconColor.withAlpha(255),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  if (widget.graphData != null && widget.graphColor != null)
                    SizedBox(
                      width: 80,
                      height: 40,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          minX: 0,
                          maxX: widget.graphData!.length.toDouble() - 1,
                          minY: 0,
                          maxY: 6,
                          lineBarsData: [
                            LineChartBarData(
                              spots: widget.graphData!,
                              isCurved: true,
                              color: widget.graphColor!.withAlpha(255),
                              barWidth: 3,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: widget.graphColor!.withAlpha(26), // Using alpha (10% opacity)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (widget.stressLevel != null)
                    SizedBox(
                      width: 100,
                      height: 12,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: widget.stressLevel!),
                        duration: const Duration(milliseconds: 1000),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.grey.withAlpha(77), // Using alpha (30% opacity)
                            ),
                            alignment: Alignment.centerLeft,
                            child: FractionallySizedBox(
                              widthFactor: value,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green.withAlpha(255),
                                      Colors.yellow.withAlpha(255),
                                      Colors.red.withAlpha(255),
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
            ),
          ),
        ),
      ),
    );
  }
}

// Helper widget for Resource Cards
class ResourceCard extends StatefulWidget {
  final Resource resource;
  final VoidCallback? onTap;

  const ResourceCard({
    super.key,
    required this.resource,
    this.onTap,
  });

  @override
  State<ResourceCard> createState() => _ResourceCardState();
}

class _ResourceCardState extends State<ResourceCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _controller.forward(),
      onExit: (_) => _controller.reverse(),
      child: AnimatedCard(
        animation: _scaleAnimation,
        child: Card(
          elevation: 0,
          margin: const EdgeInsets.only(right: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            splashColor: primaryColor.withAlpha(51), // Using alpha (20% opacity)
            highlightColor: primaryColor.withAlpha(26), // Using alpha (10% opacity)
            child: Container(
              width: 180,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: 'resource_image_${widget.resource.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.resource.imagePath,
                        height: 80,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.resource.category,
                    style: TextStyle(
                      color: primaryColor.withAlpha(255),
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    widget.resource.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black.withAlpha(255),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red.withAlpha(255),
                        size: 16,
                      ),
                      Text(' ${widget.resource.likes}'),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.comment,
                        color: Colors.blue.withAlpha(255),
                        size: 16,
                      ),
                      Text(' ${widget.resource.comments}'),
                    ],
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

// Helper widget for animated cards
class AnimatedCard extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const AnimatedCard({
    super.key,
    required this.child,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: child,
        );
      },
      child: child,
    );
  }
}

// Freud Score Details Screen
class FreudScoreDetailsScreen extends StatelessWidget {
  const FreudScoreDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Freud Score Details'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Score Overview Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    healthyGreen.withAlpha(230),
                    healthyGreen.withAlpha(180),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withAlpha(51), // Using alpha (20% opacity)
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Current Freud Score',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 150,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: Colors.white.withAlpha(51), // Using alpha (20% opacity)
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: CircularProgressIndicator(
                            value: 0.8,
                            strokeWidth: 10,
                            backgroundColor: Colors.white.withAlpha(77), // Using alpha (30% opacity)
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '80',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Healthy',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white, // Using alpha (80% opacity)
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
            const SizedBox(height: 24),

            // Score History
            const Text(
              'Score History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
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
                        color: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.grey,
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
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: text,
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
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.withAlpha(51)), // Using alpha (20% opacity)
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 100,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 75),
                        FlSpot(1, 78),
                        FlSpot(2, 80),
                        FlSpot(3, 76),
                        FlSpot(4, 79),
                        FlSpot(5, 82),
                        FlSpot(6, 80),
                      ],
                      isCurved: true,
                      color: healthyGreen,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: healthyGreen,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: healthyGreen.withAlpha(51), // Using alpha (20% opacity)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Score Factors
            const Text(
              'Score Factors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildScoreFactor('Sleep Quality', 85, healthyGreen),
            const SizedBox(height: 12),
            _buildScoreFactor('Stress Level', 70, Colors.yellow),
            const SizedBox(height: 12),
            _buildScoreFactor('Mood', 75, healthyGreen),
            const SizedBox(height: 12),
            _buildScoreFactor('Physical Activity', 90, healthyGreen),
            const SizedBox(height: 12),
            _buildScoreFactor('Social Connection', 65, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreFactor(String title, int score, Color color) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                '$score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 60,
                height: 8,
                child: LinearProgressIndicator(
                  value: score / 100,
                  backgroundColor: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Mindful Hours Screen
class MindfulHoursScreen extends StatelessWidget {
  const MindfulHoursScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Hours'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hours Overview Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    primaryColor.withAlpha(230),
                    primaryColor.withAlpha(180),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withAlpha(51), // Using alpha (20% opacity)
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Today\'s Mindful Hours',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '2.5',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'hours',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'of 8 hours',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 10,
                    child: LinearProgressIndicator(
                      value: 2.5 / 8,
                      backgroundColor: Colors.white.withAlpha(77), // Using alpha (30% opacity)
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Chart
            const Text(
              'Weekly Progress',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.grey,
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
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
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
                          return Text(
                            '${value.toInt()}h',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 2,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                        strokeWidth: 1,
                      );
                    },
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: 3,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: 4,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: 2.5,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: 5,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: 3.5,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 5,
                      barRods: [
                        BarChartRodData(
                          toY: 4.5,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 6,
                      barRods: [
                        BarChartRodData(
                          toY: 2.5,
                          color: primaryColor,
                          width: 16,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Mindful Activities
            const Text(
              'Mindful Activities',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildActivityCard(
              'Meditation',
              '1.5 hours',
              FontAwesomeIcons.personPraying,
              primaryColor,
            ),
            const SizedBox(height: 12),
            _buildActivityCard(
              'Deep Breathing',
              '0.5 hours',
              FontAwesomeIcons.wind,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildActivityCard(
              'Yoga',
              '0.5 hours',
              FontAwesomeIcons.personWalking,
              Colors.purple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(
      String title,
      String duration,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(26), // Using alpha (10% opacity)
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
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
                  duration,
                  style: TextStyle(
                    color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
          ),
        ],
      ),
    );
  }
}

// Sleep Quality Screen
class SleepQualityScreen extends StatelessWidget {
  const SleepQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep Quality'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sleep Overview Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepPurple.withAlpha(230),
                    Colors.deepPurple.withAlpha(180),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withAlpha(51), // Using alpha (20% opacity)
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Sleep Quality',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Insomniac',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '-2h Average',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSleepPhase('Deep', 1.5, Colors.deepPurple),
                      const SizedBox(width: 16),
                      _buildSleepPhase('Light', 3.5, Colors.purple),
                      const SizedBox(width: 16),
                      _buildSleepPhase('REM', 1, Colors.indigo),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Weekly Chart
            const Text(
              'Weekly Sleep Duration',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.grey,
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
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
                            child: text,
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}h',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.withAlpha(51)), // Using alpha (20% opacity)
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 0,
                  maxY: 8,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 5),
                        FlSpot(1, 4),
                        FlSpot(2, 6),
                        FlSpot(3, 4.5),
                        FlSpot(4, 5.5),
                        FlSpot(5, 4),
                        FlSpot(6, 5),
                      ],
                      isCurved: true,
                      color: Colors.deepPurple,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.deepPurple,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.deepPurple.withAlpha(51), // Using alpha (20% opacity)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Sleep Recommendations
            const Text(
              'Sleep Recommendations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildRecommendationCard(
              'Consistent Schedule',
              'Go to bed and wake up at the same time every day, even on weekends.',
              FontAwesomeIcons.clock,
              Colors.blue,
            ),
            const SizedBox(height: 12),
            _buildRecommendationCard(
              'Limit Screen Time',
              'Avoid screens for at least 1 hour before bedtime.',
              FontAwesomeIcons.mobileScreen,
              Colors.red,
            ),
            const SizedBox(height: 12),
            _buildRecommendationCard(
              'Create a Relaxing Routine',
              'Develop a pre-sleep ritual to signal your body it\'s time to wind down.',
              FontAwesomeIcons.moon,
              Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepPhase(String phase, double hours, Color color) {
    return Column(
      children: [
        Text(
          phase,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${hours}h',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendationCard(
      String title,
      String description,
      IconData icon,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withAlpha(26), // Using alpha (10% opacity)
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
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
                    color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
                    fontSize: 14,
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

// Journal Screen
class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Journal'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak Overview Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.withAlpha(230),
                    Colors.orange.withAlpha(180),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withAlpha(51), // Using alpha (20% opacity)
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Current Streak',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '64',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'days',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'in a row',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStreakMilestone('7 days', '1 week', Colors.white),
                      _buildStreakMilestone('30 days', '1 month', Colors.white),
                      _buildStreakMilestone('90 days', '3 months', Colors.white),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Recent Entries
            const Text(
              'Recent Entries',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildJournalEntry(
              'Today',
              'Had a great meditation session this morning. Feeling more centered and focused throughout the day.',
              4,
              Colors.green,
            ),
            const SizedBox(height: 12),
            _buildJournalEntry(
              'Yesterday',
              'Feeling a bit anxious about the upcoming presentation. Need to practice deep breathing exercises.',
              3,
              Colors.yellow,
            ),
            const SizedBox(height: 12),
            _buildJournalEntry(
              '2 days ago',
              'Went for a long walk in nature. It really helped clear my mind and reduce stress.',
              5,
              Colors.green,
            ),
            const SizedBox(height: 24),

            // Mood Trends
            const Text(
              'Mood Trends',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          const style = TextStyle(
                            color: Colors.grey,
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
                              break;
                          }
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 8.0,
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
                          String text;
                          switch (value.toInt()) {
                            case 1:
                              text = 'Sad';
                              break;
                            case 2:
                              text = 'Neutral';
                              break;
                            case 3:
                              text = 'Happy';
                              break;
                            case 4:
                              text = 'Very Happy';
                              break;
                            case 5:
                              text = 'Ecstatic';
                              break;
                            default:
                              text = '';
                              break;
                          }
                          return Text(
                            text,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.withAlpha(51)), // Using alpha (20% opacity)
                  ),
                  minX: 0,
                  maxX: 6,
                  minY: 1,
                  maxY: 5,
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 3),
                        FlSpot(1, 2),
                        FlSpot(2, 4),
                        FlSpot(3, 3),
                        FlSpot(4, 4),
                        FlSpot(5, 5),
                        FlSpot(6, 4),
                      ],
                      isCurved: true,
                      color: Colors.orange,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.orange,
                            strokeWidth: 2,
                            strokeColor: Colors.white,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.orange.withAlpha(51), // Using alpha (20% opacity)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new journal entry
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStreakMilestone(String days, String period, Color color) {
    return Column(
      children: [
        Text(
          days,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          period,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withAlpha(204), // Using alpha (80% opacity)
          ),
        ),
      ],
    );
  }

  Widget _buildJournalEntry(
      String date,
      String content,
      int mood,
      Color moodColor,
      ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
            blurRadius: 5,
            offset: const Offset(0, 2),
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
                date,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Mood: ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return Icon(
                        index < mood ? Icons.star : Icons.star_border,
                        color: moodColor,
                        size: 16,
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
            ),
          ),
        ],
      ),
    );
  }
}

// Chatbot Screen
class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Therapy Chatbot'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildChatMessage(
                  'Hello! I\'m your AI therapy assistant. How are you feeling today?',
                  false,
                ),
                _buildChatMessage(
                  'I\'ve been feeling a bit anxious lately with work deadlines approaching.',
                  true,
                ),
                _buildChatMessage(
                  'I understand that work pressure can be overwhelming. Have you tried any relaxation techniques?',
                  false,
                ),
                _buildChatMessage(
                  'I\'ve tried deep breathing a few times, but I struggle to make it a habit.',
                  true,
                ),
                _buildChatMessage(
                  'Building habits takes time and consistency. Let me suggest a simple 5-minute breathing exercise you can do daily.',
                  false,
                ),
              ],
            ),
          ),

          // Input Area
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(51), // Using alpha (20% opacity)
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      // Send message
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessage(String message, bool isUser) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUser)
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26), // Using alpha (10% opacity)
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.smart_toy,
                color: primaryColor,
              ),
            ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isUser
                    ? primaryColor
                    : Colors.grey.withAlpha(26), // Using alpha (10% opacity)
                borderRadius: BorderRadius.circular(16.0).copyWith(
                  bottomLeft: isUser ? const Radius.circular(16.0) : const Radius.circular(4.0),
                  bottomRight: isUser ? const Radius.circular(4.0) : const Radius.circular(16.0),
                ),
              ),
              child: Text(
                message,
                style: TextStyle(
                  color: isUser ? Colors.white : Colors.black.withAlpha(204), // Using alpha (80% opacity)
                ),
              ),
            ),
          ),
          if (isUser)
            Container(
              margin: const EdgeInsets.only(left: 8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26), // Using alpha (10% opacity)
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}

// Resources Screen
class ResourcesScreen extends StatelessWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mindful Resources'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search resources...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Categories
            const Text(
              'Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('All', primaryColor, true),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Meditation', Colors.green, false),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Sleep', Colors.deepPurple, false),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Anxiety', Colors.red, false),
                  const SizedBox(width: 8),
                  _buildCategoryChip('Mindfulness', Colors.orange, false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Resources List
            const Text(
              'Popular Resources',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              Resource(
                id: 'resource_1',
                imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                category: 'Mental Health',
                title: 'Will meditation help you get out from the rat race?',
                likes: '5,241',
                comments: '987',
              ),
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              Resource(
                id: 'resource_2',
                imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                category: 'Mental Health',
                title: 'Overcoming Anxiety',
                likes: '4,152',
                comments: '756',
              ),
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              Resource(
                id: 'resource_3',
                imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                category: 'Mental Health',
                title: 'The Science of Sleep',
                likes: '3,891',
                comments: '642',
              ),
            ),
            const SizedBox(height: 16),
            _buildResourceCard(
              context,
              Resource(
                id: 'resource_4',
                imagePath: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                category: 'Mental Health',
                title: 'Mindful Eating',
                likes: '2,756',
                comments: '421',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, Color color, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? color : Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildResourceCard(BuildContext context, Resource resource) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // Navigate to resource detail
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ResourceDetailScreen(resource: resource)),
          );
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: Image.network(
                resource.imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resource.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    resource.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red.withAlpha(255),
                        size: 16,
                      ),
                      Text(' ${resource.likes}'),
                      const SizedBox(width: 16.0),
                      Icon(
                        Icons.comment,
                        color: Colors.blue.withAlpha(255),
                        size: 16,
                      ),
                      Text(' ${resource.comments}'),
                      const Spacer(),
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
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
  }
}

// Resource Detail Screen
class ResourceDetailScreen extends StatelessWidget {
  final Resource resource;

  const ResourceDetailScreen({
    super.key,
    required this.resource,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resource Detail'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share resource
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // Bookmark resource
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Resource Image
            Hero(
              tag: 'resource_image_${resource.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  resource.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Resource Title and Meta
            Text(
              resource.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: primaryColor.withAlpha(26), // Using alpha (10% opacity)
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    resource.category,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '5 min read',
                  style: TextStyle(
                    color: Colors.grey.withAlpha(153), // Using alpha (60% opacity)
                    fontSize: 12,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red.withAlpha(255),
                      size: 16,
                    ),
                    const Text(' 5,241'),
                    const SizedBox(width: 8.0),
                    Icon(
                      Icons.comment,
                      color: Colors.blue.withAlpha(255),
                      size: 16,
                    ),
                    const Text(' 987'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24.0),

            // Resource Content
            const Text(
              'Introduction',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'In today\'s fast-paced world, many people find themselves caught in the "rat race" - a relentless pursuit of success, wealth, and productivity that often leaves little time for reflection, rest, and genuine connection. This constant striving can lead to stress, burnout, and a sense of disconnection from what truly matters in life.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withAlpha(204), // Using alpha (80% opacity)
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16.0),

            const Text(
              'What is Meditation?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Meditation is a practice that involves training the mind to focus and redirect thoughts. It can be used to increase awareness of yourself and your surroundings. Many people think of it as a way to reduce stress and develop concentration.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withAlpha(204), // Using alpha (80% opacity)
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16.0),

            const Text(
              'How Meditation Can Help',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Regular meditation practice can help you step off the hamster wheel of the rat race by:\n\n1. Reducing stress and anxiety\n2. Improving focus and concentration\n3. Enhancing self-awareness\n4. Promoting emotional health\n5. Lengthening attention span\n6. Improving sleep\n7. Helping control pain\n8. Decreasing blood pressure',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.withAlpha(204), // Using alpha (80% opacity)
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24.0),

            // Related Resources
            const Text(
              'Related Resources',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildRelatedResourceCard(
                    'Mindfulness for Beginners',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                  ),
                  const SizedBox(width: 12.0),
                  _buildRelatedResourceCard(
                    'The Power of Now',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                  ),
                  const SizedBox(width: 12.0),
                  _buildRelatedResourceCard(
                    'Finding Inner Peace',
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSq-09f01gVsF78v9Ai5dV03LdxTI6ML1mWVg&s',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRelatedResourceCard(String title, String imagePath) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26), // Using alpha (10% opacity)
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: Image.network(
              imagePath,
              height: 60,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}