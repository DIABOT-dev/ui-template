import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> with TickerProviderStateMixin {
  late AnimationController _feelingController;
  late AnimationController _moodController;
  late AnimationController _sleepController;
  late AnimationController _connectionsController;

  @override
  void initState() {
    super.initState();
    _feelingController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _moodController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _sleepController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _connectionsController = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    );

    // Start animations with staggered delays
    Future.delayed(const Duration(milliseconds: 200), () {
      _feelingController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _moodController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _sleepController.forward();
    });
    Future.delayed(const Duration(milliseconds: 800), () {
      _connectionsController.forward();
    });
  }

  @override
  void dispose() {
    _feelingController.dispose();
    _moodController.dispose();
    _sleepController.dispose();
    _connectionsController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> weeklyMoodData = [
    {'day': 'Mon', 'mood': 'sad', 'value': 2},
    {'day': 'Tue', 'mood': 'neutral', 'value': 3},
    {'day': 'Wed', 'mood': 'happy', 'value': 5},
    {'day': 'Thu', 'mood': 'happy', 'value': 5},
    {'day': 'Fri', 'mood': 'happy', 'value': 5},
    {'day': 'Sat', 'mood': 'very_happy', 'value': 6},
    {'day': 'Sun', 'mood': 'happy', 'value': 5},
  ];

  final List<Map<String, dynamic>> sleepQualityData = [
    {'day': 'Mon', 'hours': 7},
    {'day': 'Tue', 'hours': 8},
    {'day': 'Wed', 'hours': 6},
    {'day': 'Thu', 'hours': 9},
    {'day': 'Fri', 'hours': 7},
    {'day': 'Sat', 'hours': 8},
    {'day': 'Sun', 'hours': 7},
  ];

  final List<String> personAvatars = [
    'https://randomuser.me/api/portraits/men/11.jpg',
    'https://randomuser.me/api/portraits/women/12.jpg',
    'https://randomuser.me/api/portraits/men/13.jpg',
    'https://randomuser.me/api/portraits/women/14.jpg',
  ];

  Color getRandomColor() {
    Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }

  IconData getMoodIcon(String mood) {
    switch (mood) {
      case 'sad':
        return FontAwesomeIcons.faceSadTear;
      case 'neutral':
        return FontAwesomeIcons.faceMeh;
      case 'happy':
        return FontAwesomeIcons.faceSmile;
      case 'very_happy':
        return FontAwesomeIcons.faceGrinBeam;
      default:
        return FontAwesomeIcons.faceMeh;
    }
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'sad':
        return Colors.red.shade300;
      case 'neutral':
        return Colors.orange.shade300;
      case 'happy':
        return Colors.green.shade300;
      case 'very_happy':
        return Colors.blue.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Monitoring',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidHeart, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // You're feeling section with animation
            FadeTransition(
              opacity: _feelingController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _feelingController,
                  curve: Curves.easeOut,
                )),
                child: Card(
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.blue.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(bottom: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.elasticOut,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.withValues(alpha: 0.2),
                                Colors.blue.withValues(alpha: 0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.transparent,
                            child: Icon(FontAwesomeIcons.faceMeh, color: Colors.blue, size: 28),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You're feeling",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                "Normal",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to mood detail screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MoodDetailScreen()),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.grey.withValues(alpha: 0.2),
                                  Colors.grey.withValues(alpha: 0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.edit, color: Colors.grey, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Weekly Mood Tracker with animation
            FadeTransition(
              opacity: _moodController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _moodController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Weekly Mood Tracker',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MoodDetailScreen()),
                              );
                            },
                            child: const Text(
                              'see more →',
                              style: TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 2),
                    Card(
                      color: Colors.white,
                      shadowColor: Colors.purple.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(bottom: 4),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: weeklyMoodData.map((data) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.elasticOut,
                                child: Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: const Duration(milliseconds: 500),
                                      curve: Curves.elasticOut,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            getMoodColor(data['mood']).withValues(alpha: 0.3),
                                            getMoodColor(data['mood']).withValues(alpha: 0.1),
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 24,
                                        backgroundColor: Colors.transparent,
                                        child: Icon(
                                          getMoodIcon(data['mood']),
                                          color: getMoodColor(data['mood']),
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      data['day'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Sleep Quality Section with animation
            FadeTransition(
              opacity: _sleepController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _sleepController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sleep Quality',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const SleepDetailScreen()),
                            );
                          },
                          child: const Text(
                            'see more →',
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Card(
                      color: Colors.white,
                      shadowColor: Colors.indigo.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(bottom: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'March 24-30',
                              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('9 hrs.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    const Text('6 hrs.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    const Text('3 hrs.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    const Text('0 hrs.', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 40,
                                        child: Container(
                                          height: 2,
                                          color: Colors.green.withValues(alpha: 0.5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                'goal',
                                                style: TextStyle(
                                                    color: Colors.green.shade700,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: sleepQualityData.map((data) {
                                          double barHeight = (data['hours'] / 9) * 120;
                                          Color barColor = data['hours'] >= 9 ? Colors.purple : Colors.purple.shade200;

                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 800),
                                            curve: Curves.elasticOut,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                AnimatedContainer(
                                                  duration: const Duration(milliseconds: 800),
                                                  curve: Curves.elasticOut,
                                                  width: 30,
                                                  height: barHeight,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        barColor,
                                                        barColor.withValues(alpha: 0.7),
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  data['day'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
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

            // Additional Section for Connections with animation
            FadeTransition(
              opacity: _connectionsController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _connectionsController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Connections',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: personAvatars.length * 2,
                        itemBuilder: (context, index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.elasticOut,
                            margin: const EdgeInsets.only(right: 15),
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.elasticOut,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.teal.withValues(alpha: 0.3),
                                        Colors.teal.withValues(alpha: 0.1),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: NetworkImage(personAvatars[index % personAvatars.length]),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Person ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
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
}

class MoodDetailScreen extends StatefulWidget {
  const MoodDetailScreen({super.key});

  @override
  State<MoodDetailScreen> createState() => _MoodDetailScreenState();
}

class _MoodDetailScreenState extends State<MoodDetailScreen> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _chartController;
  late AnimationController _tipsController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _tipsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Start animations with staggered delays
    Future.delayed(const Duration(milliseconds: 200), () {
      _headerController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _chartController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _tipsController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _chartController.dispose();
    _tipsController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> monthlyMoodData = [
    {'day': '1', 'mood': 'neutral', 'value': 3},
    {'day': '2', 'mood': 'happy', 'value': 5},
    {'day': '3', 'mood': 'happy', 'value': 5},
    {'day': '4', 'mood': 'sad', 'value': 2},
    {'day': '5', 'mood': 'neutral', 'value': 3},
    {'day': '6', 'mood': 'happy', 'value': 5},
    {'day': '7', 'mood': 'very_happy', 'value': 6},
    {'day': '8', 'mood': 'happy', 'value': 5},
    {'day': '9', 'mood': 'neutral', 'value': 3},
    {'day': '10', 'mood': 'happy', 'value': 5},
    {'day': '11', 'mood': 'happy', 'value': 5},
    {'day': '12', 'mood': 'sad', 'value': 2},
    {'day': '13', 'mood': 'neutral', 'value': 3},
    {'day': '14', 'mood': 'very_happy', 'value': 6},
  ];

  final List<Map<String, dynamic>> moodTips = [
    {
      'title': 'Practice Mindfulness',
      'description': 'Take 10 minutes each day to focus on your breathing and be present in the moment.',
      'icon': FontAwesomeIcons.brain,
      'color': Colors.blue,
    },
    {
      'title': 'Physical Activity',
      'description': 'Even a short walk can boost your mood and energy levels.',
      'icon': FontAwesomeIcons.personWalking,
      'color': Colors.green,
    },
    {
      'title': 'Connect with Others',
      'description': 'Reach out to friends or family members for social support.',
      'icon': FontAwesomeIcons.userGroup,
      'color': Colors.purple,
    },
  ];

  IconData getMoodIcon(String mood) {
    switch (mood) {
      case 'sad':
        return FontAwesomeIcons.faceSadTear;
      case 'neutral':
        return FontAwesomeIcons.faceMeh;
      case 'happy':
        return FontAwesomeIcons.faceSmile;
      case 'very_happy':
        return FontAwesomeIcons.faceGrinBeam;
      default:
        return FontAwesomeIcons.faceMeh;
    }
  }

  Color getMoodColor(String mood) {
    switch (mood) {
      case 'sad':
        return Colors.red.shade300;
      case 'neutral':
        return Colors.orange.shade300;
      case 'happy':
        return Colors.green.shade300;
      case 'very_happy':
        return Colors.blue.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mood Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidHeart, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood summary with animation
            FadeTransition(
              opacity: _headerController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _headerController,
                  curve: Curves.easeOut,
                )),
                child: Card(
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.blue.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Mood Summary',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Average Mood',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.green.shade300,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '4.2/6',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 1,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Best Day',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Saturday',
                                    style: TextStyle(
                                      fontSize: 20,
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
                ),
              ),
            ),

            // Monthly Mood Tracker with animation
            FadeTransition(
              opacity: _chartController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _chartController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Monthly Mood Tracker',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Card(
                      color: Colors.white,
                      shadowColor: Colors.purple.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(bottom: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'March 2024',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.faceSadTear,
                                      color: Colors.red.shade300,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                    const SizedBox(width: 15),
                                    Icon(
                                      FontAwesomeIcons.faceMeh,
                                      color: Colors.orange.shade300,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '4',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                    const SizedBox(width: 15),
                                    Icon(
                                      FontAwesomeIcons.faceSmile,
                                      color: Colors.green.shade300,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '6',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                    const SizedBox(width: 15),
                                    Icon(
                                      FontAwesomeIcons.faceGrinBeam,
                                      color: Colors.blue.shade300,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '2',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: monthlyMoodData.length,
                                itemBuilder: (context, index) {
                                  final data = monthlyMoodData[index];
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.elasticOut,
                                    margin: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      children: [
                                        Text(
                                          data['day'],
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        AnimatedContainer(
                                          duration: const Duration(milliseconds: 500),
                                          curve: Curves.elasticOut,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                getMoodColor(data['mood']).withValues(alpha: 0.3),
                                                getMoodColor(data['mood']).withValues(alpha: 0.1),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.transparent,
                                            child: Icon(
                                              getMoodIcon(data['mood']),
                                              color: getMoodColor(data['mood']),
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          width: 30,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color: getMoodColor(data['mood']),
                                            borderRadius: BorderRadius.circular(2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
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

            // Mood improvement tips with animation
            FadeTransition(
              opacity: _tipsController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _tipsController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mood Improvement Tips',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    ...moodTips.map((tip) => AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                      margin: const EdgeInsets.only(bottom: 2),
                      child: Card(
                        color: Colors.white,
                        shadowColor: tip['color'].withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.elasticOut,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      tip['color'].withValues(alpha: 0.3),
                                      tip['color'].withValues(alpha: 0.1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    tip['icon'],
                                    color: tip['color'],
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tip['title'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      tip['description'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
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

class SleepDetailScreen extends StatefulWidget {
  const SleepDetailScreen({super.key});

  @override
  State<SleepDetailScreen> createState() => _SleepDetailScreenState();
}

class _SleepDetailScreenState extends State<SleepDetailScreen> with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _chartController;
  late AnimationController _tipsController;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _chartController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _tipsController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Start animations with staggered delays
    Future.delayed(const Duration(milliseconds: 200), () {
      _headerController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      _chartController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _tipsController.forward();
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _chartController.dispose();
    _tipsController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> sleepData = [
    {'day': 'Mon', 'hours': 7, 'quality': 'Good'},
    {'day': 'Tue', 'hours': 8, 'quality': 'Excellent'},
    {'day': 'Wed', 'hours': 6, 'quality': 'Fair'},
    {'day': 'Thu', 'hours': 9, 'quality': 'Excellent'},
    {'day': 'Fri', 'hours': 7, 'quality': 'Good'},
    {'day': 'Sat', 'hours': 8, 'quality': 'Excellent'},
    {'day': 'Sun', 'hours': 7, 'quality': 'Good'},
  ];

  final List<Map<String, dynamic>> sleepTips = [
    {
      'title': 'Consistent Schedule',
      'description': 'Go to bed and wake up at the same time every day, even on weekends.',
      'icon': FontAwesomeIcons.clock,
      'color': Colors.indigo,
    },
    {
      'title': 'Create a Relaxing Routine',
      'description': 'Develop a pre-sleep ritual like reading or taking a warm bath.',
      'icon': FontAwesomeIcons.moon,
      'color': Colors.blue,
    },
    {
      'title': 'Optimize Your Environment',
      'description': 'Keep your bedroom dark, quiet, and at a comfortable temperature.',
      'icon': FontAwesomeIcons.house,
      'color': Colors.teal,
    },
  ];

  Color getSleepQualityColor(String quality) {
    switch (quality) {
      case 'Poor':
        return Colors.red.shade300;
      case 'Fair':
        return Colors.orange.shade300;
      case 'Good':
        return Colors.green.shade300;
      case 'Excellent':
        return Colors.blue.shade300;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Sleep Details',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidHeart, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sleep summary with animation
            FadeTransition(
              opacity: _headerController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _headerController,
                  curve: Curves.easeOut,
                )),
                child: Card(
                  color: Colors.white,
                  shadowColor: Colors.indigo.withValues(alpha: 0.2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(bottom: 7),
                  child: Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Sleep Summary',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Average Sleep',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.moon,
                                        color: Colors.indigo.shade300,
                                        size: 24,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        '7.4 hrs',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 60,
                              width: 1,
                              color: Colors.grey.withValues(alpha: 0.3),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Sleep Quality',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Good',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
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
                ),
              ),
            ),

            // Weekly Sleep Tracker with animation
            FadeTransition(
              opacity: _chartController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _chartController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Weekly Sleep Tracker',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Card(
                      color: Colors.white,
                      shadowColor: Colors.indigo.withValues(alpha: 0.2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'March 24-30',
                                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.moon,
                                      color: Colors.indigo.shade300,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Goal: 8 hrs',
                                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text('9 hrs', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    const Text('6 hrs', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    const Text('3 hrs', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                    const SizedBox(height: 25),
                                    const Text('0 hrs', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                  ],
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        right: 0,
                                        top: 40,
                                        child: Container(
                                          height: 2,
                                          color: Colors.green.withValues(alpha: 0.5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 4.0),
                                              child: Text(
                                                'goal',
                                                style: TextStyle(
                                                    color: Colors.green.shade700,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: sleepData.map((data) {
                                          double barHeight = (data['hours'] / 9) * 120;
                                          Color barColor = getSleepQualityColor(data['quality']);

                                          return AnimatedContainer(
                                            duration: const Duration(milliseconds: 800),
                                            curve: Curves.elasticOut,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                AnimatedContainer(
                                                  duration: const Duration(milliseconds: 800),
                                                  curve: Curves.elasticOut,
                                                  width: 30,
                                                  height: barHeight,
                                                  decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        barColor,
                                                        barColor.withValues(alpha: 0.7),
                                                      ],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter,
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  data['day'],
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${data['hours']}h',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSleepQualityIndicator('Poor', Colors.red.shade300),
                                _buildSleepQualityIndicator('Fair', Colors.orange.shade300),
                                _buildSleepQualityIndicator('Good', Colors.green.shade300),
                                _buildSleepQualityIndicator('Excellent', Colors.blue.shade300),
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

            // Sleep improvement tips with animation
            FadeTransition(
              opacity: _tipsController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.3),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _tipsController,
                  curve: Curves.easeOut,
                )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sleep Improvement Tips',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    ...sleepTips.map((tip) => AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut,
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Card(
                        color: Colors.white,
                        shadowColor: tip['color'].withValues(alpha: 0.2),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.elasticOut,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      tip['color'].withValues(alpha: 0.3),
                                      tip['color'].withValues(alpha: 0.1),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(
                                    tip['icon'],
                                    color: tip['color'],
                                    size: 24,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tip['title'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      tip['description'],
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSleepQualityIndicator(String quality, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          quality,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}