import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

// Helper function to convert opacity to alpha for Color.withAlpha
int alphaFromOpacity(double opacity) {
  return (opacity * 255).round();
}

class DailyReflectionScreen extends StatelessWidget {
  const DailyReflectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'Daily Reflection',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),

      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar


              // Title Section

              const SizedBox(height: 8),
              Text(
                'What is your mood today?',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 12),

              // Mood Selector Section
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer Mood Ring
                      CustomPaint(
                        painter: MoodRingPainter(
                          goodColor: Color(0xFFC7EF8A),
                          shiedColor: Color(0xFFB1D5F4),
                          stressedColor: Color(0xFFFDDEDD),
                          angryColor: Color(0xFFFBCFBE),
                          strokeWidth: 40.0,
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.75,
                          height: MediaQuery.of(context).size.width * 0.75,
                        ),
                      ),
                      // Inner Mood Text
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Mood',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            'GOOD',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7CAF20),
                            ),
                          ),
                        ],
                      ),
                      // Mood Avatars around the ring
                      ..._buildMoodAvatars(),
                      // Chat button on the right
                      Positioned(
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 500),
                                pageBuilder: (_, __, ___) =>
                                    MoodDetailsScreen(),
                                transitionsBuilder: (_, animation, __, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFC0F3),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              FontAwesomeIcons.solidCommentDots,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Intake & Mental Effect Cards
              Row(
                children: [
                  Expanded(
                    child: WhiteCard(
                      title: 'Intake',
                      subtitle: 'Deep Talk',
                      child: SizedBox(
                        height: 70,
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                childAspectRatio: 0.5,
                              ),
                          itemCount: 18,
                          itemBuilder: (context, index) {
                            List<Color> barColors = [
                              Colors.pink[200]!,
                              Colors.blue[200]!,
                              Colors.green[200]!,
                            ];
                            return Container(
                              decoration: BoxDecoration(
                                color: barColors[index % barColors.length],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: WhiteCard(
                      title: 'Mental Effect',
                      subtitle: 'Very High',
                      icon: FontAwesomeIcons.brain,
                      iconColor: Color(0xFFFB9AD1),
                      child: SizedBox(
                        height: 70,
                        child: CustomPaint(
                          painter: WavePainter(waveColor: Color(0xFFC7EF8A)),
                          child: Container(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (_, __, ___) => ProgressTrackingScreen(),
                          transitionsBuilder: (_, animation, __, child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.insert_chart, color: Colors.white),
                    label: Text(
                      'Progress',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF6A9BD1),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action for saving mood
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mood saved successfully!'),
                          backgroundColor: Color(0xFF90D348),
                        ),
                      );
                    },
                    icon: Icon(Icons.download_rounded, color: Colors.white),
                    label: Text(
                      'Save Mood',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF90D348),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMoodAvatars() {
    double size = 60.0;
    double ringRadius = 130.0;
    List<Map<String, dynamic>> moods = [
      {
        'mood': 'good',
        'asset': 'https://randomuser.me/api/portraits/men/11.jpg',
        'angle': -math.pi / 2,
        'color': Color(0xFFC7EF8A),
      },
      {
        'mood': 'shied',
        'asset': 'https://randomuser.me/api/portraits/men/12.jpg',
        'angle': -math.pi / 2 - math.pi / 3,
        'color': Color(0xFFB1D5F4),
      },
      {
        'mood': 'stressed',
        'asset': 'https://randomuser.me/api/portraits/men/13.jpg',
        'angle': -math.pi / 2 + math.pi / 3,
        'color': Color(0xFFFDDEDD),
      },
      {
        'mood': 'angry',
        'asset': 'https://randomuser.me/api/portraits/men/14.jpg',
        'angle': math.pi / 2,
        'color': Color(0xFFFBCFBE),
      },
      {
        'mood': 'neutral',
        'asset': 'https://randomuser.me/api/portraits/men/15.jpg',
        'angle': math.pi / 6,
        'color': Color(0xFFD3D3D3),
      },
      {
        'mood': 'happy',
        'asset': 'https://randomuser.me/api/portraits/men/16.jpg',
        'angle': -math.pi / 6,
        'color': Color(0xFFFFD700),
      },
    ];

    return moods.map((moodData) {
      double angle = moodData['angle'];
      Color bgColor = moodData['color'];

      return Positioned(
        top: ringRadius * (1 - math.sin(angle)) - size / 2,
        left: ringRadius * (1 + math.cos(angle)) - size / 2,
        child: GestureDetector(
          onTap: () {
            // Handle mood selection
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.network(
                moodData['asset'],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.person,
                  size: size * 0.7,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Mood Details Screen
class MoodDetailsScreen extends StatefulWidget {
  const MoodDetailsScreen({super.key});

  @override
  MoodDetailsScreenState createState() => MoodDetailsScreenState();
}

class MoodDetailsScreenState extends State<MoodDetailsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Mood Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.share, color: Colors.grey[800]),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Mood Summary Card
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFFC7EF8A).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Color(0xFFC7EF8A),
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  'https://randomuser.me/api/portraits/men/11.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Good Mood',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  Text(
                                    'Today, 10:30 AM',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.sentiment_very_satisfied,
                                        color: Color(0xFF7CAF20),
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Feeling positive and energetic',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
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
                const SizedBox(height: 30),

                // Mood Factors
                Text(
                  'Mood Factors',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(height: 15),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.2,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      List<Map<String, dynamic>> factors = [
                        {
                          'title': 'Sleep',
                          'value': '8h 20m',
                          'icon': Icons.bedtime,
                          'color': Color(0xFF6A9BD1),
                          'progress': 0.8,
                        },
                        {
                          'title': 'Exercise',
                          'value': '45 min',
                          'icon': Icons.fitness_center,
                          'color': Color(0xFFFB9AD1),
                          'progress': 0.6,
                        },
                        {
                          'title': 'Nutrition',
                          'value': 'Good',
                          'icon': Icons.restaurant,
                          'color': Color(0xFF90D348),
                          'progress': 0.9,
                        },
                        {
                          'title': 'Social',
                          'value': 'Active',
                          'icon': Icons.people,
                          'color': Color(0xFFFFC0F3),
                          'progress': 0.7,
                        },
                      ];

                      return Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: factors[index]['color'].withValues(
                                      alpha: 0.2,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    factors[index]['icon'],
                                    color: factors[index]['color'],
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    factors[index]['title'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              factors[index]['value'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: factors[index]['progress'],
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: factors[index]['color'],
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 30),

                // Mood Notes
                Text(
                  'Mood Notes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[900],
                  ),
                ),
                const SizedBox(height: 15),
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today was a productive day. I completed all my tasks and had time for a relaxing walk in the park. The weather was perfect and I felt really good.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(Icons.tag, color: Colors.grey[500], size: 18),
                            SizedBox(width: 5),
                            Text(
                              '#productive #relaxing #walk',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6A9BD1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Action Button
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (_, __, ___) =>
                                ProgressTrackingScreen(),
                            transitionsBuilder: (_, animation, __, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6A9BD1),
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        'View Progress',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
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
}

// Progress Tracking Screen
class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({super.key});

  @override
  ProgressTrackingScreenState createState() => ProgressTrackingScreenState();
}

class ProgressTrackingScreenState extends State<ProgressTrackingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0.0, 0.3), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(0.2, 0.8, curve: Curves.easeOut),
          ),
        );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Progress Tracking',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.grey[800]),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
              
                  // Time Period Selector
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                'Week',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[900],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Month',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Year',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
              
                  // Mood Overview Card
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A9BD1), Color(0xFF90D348)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
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
                                'Mood Overview',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(Icons.insights, color: Colors.white),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '72%',
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      'Positive',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white.withValues(
                                          alpha: 0.8,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: CustomPaint(painter: MoodChartPainter()),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
              
                  // Mood Trends
                  Text(
                    'Mood Trends',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      height: 180,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomPaint(painter: LineChartPainter()),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mon',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(
                                'Tue',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(
                                'Wed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(
                                'Thu',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(
                                'Fri',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(
                                'Sat',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              Text(
                                'Sun',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
              
                  // Insights
                  Text(
                    'Insights',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      children: [
                        InsightCard(
                          title: 'Best Day',
                          value: 'Wednesday',
                          icon: Icons.emoji_emotions,
                          color: Color(0xFF90D348),
                          description: 'Your mood was highest on Wednesday',
                        ),
                        SizedBox(height: 15),
                        InsightCard(
                          title: 'Improvement',
                          value: '+15%',
                          icon: Icons.trending_up,
                          color: Color(0xFF6A9BD1),
                          description: 'Your mood improved compared to last week',
                        ),
                        SizedBox(height: 15),
                        InsightCard(
                          title: 'Pattern',
                          value: 'Morning',
                          icon: Icons.wb_sunny,
                          color: Color(0xFFFFC0F3),
                          description: 'You feel best in the morning hours',
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
    );
  }
}

// Insight Card Widget
class InsightCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String description;

  const InsightCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
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
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for the Mood Chart
class MoodChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    // Background circle
    final bgPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, bgPaint);

    // Mood segments
    final goodPaint = Paint()
      ..color = Color(0xFFC7EF8A)
      ..style = PaintingStyle.fill;

    final neutralPaint = Paint()
      ..color = Color(0xFFD3D3D3)
      ..style = PaintingStyle.fill;

    final stressedPaint = Paint()
      ..color = Color(0xFFFDDEDD)
      ..style = PaintingStyle.fill;

    // Draw segments
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 0.72,
      true,
      goodPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.22,
      math.pi * 0.18,
      true,
      neutralPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi * 0.4,
      math.pi * 0.1,
      true,
      stressedPaint,
    );

    // Center circle
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius * 0.6, centerPaint);

    // Center text
    final textPainter = TextPainter(
      text: TextSpan(
        text: '72%',
        style: TextStyle(
          color: Color(0xFF7CAF20),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        center.dx - textPainter.width / 2,
        center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for the Line Chart
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF6A9BD1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final pointPaint = Paint()
      ..color = Color(0xFF6A9BD1)
      ..style = PaintingStyle.fill;

    final shadowPaint = Paint()
      ..color = Color(0xFF6A9BD1).withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;

    // Data points
    final List<Offset> points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.16, size.height * 0.5),
      Offset(size.width * 0.33, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.4),
      Offset(size.width * 0.66, size.height * 0.2),
      Offset(size.width * 0.83, size.height * 0.3),
      Offset(size.width, size.height * 0.4),
    ];

    // Draw shadow
    final shadowPath = Path();
    shadowPath.moveTo(points[0].dx, size.height);
    shadowPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      shadowPath.lineTo(points[i].dx, points[i].dy);
    }

    shadowPath.lineTo(points.last.dx, size.height);
    shadowPath.close();

    canvas.drawPath(shadowPath, shadowPaint);

    // Draw line
    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, paint);

    // Draw points
    for (final point in points) {
      canvas.drawCircle(point, 5, pointPaint);
      canvas.drawCircle(point, 3, Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for the Mood Ring
class MoodRingPainter extends CustomPainter {
  final Color goodColor;
  final Color shiedColor;
  final Color stressedColor;
  final Color angryColor;
  final double strokeWidth;

  MoodRingPainter({
    required this.goodColor,
    required this.shiedColor,
    required this.stressedColor,
    required this.angryColor,
    this.strokeWidth = 30.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (strokeWidth / 2);

    final goodPaint = Paint()
      ..color = goodColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final shiedPaint = Paint()
      ..color = shiedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final stressedPaint = Paint()
      ..color = stressedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    final angryPaint = Paint()
      ..color = angryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    // Angles in radians for each segment (total 2*pi for full circle)
    // Starting from top (-math.pi / 2)
    final startAngleGood = -math.pi / 2 - math.pi / 6;
    final sweepAngleGood = math.pi / 3 + math.pi / 6;

    final startAngleStressed = startAngleGood + sweepAngleGood;
    final sweepAngleStressed = math.pi / 3;

    final startAngleAngry = startAngleStressed + sweepAngleStressed;
    final sweepAngleAngry = math.pi / 3 + math.pi / 6;

    final startAngleShied = startAngleAngry + sweepAngleAngry;
    final sweepAngleShied = math.pi / 3;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleGood,
      sweepAngleGood,
      false,
      goodPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleStressed,
      sweepAngleStressed,
      false,
      stressedPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleAngry,
      sweepAngleAngry,
      false,
      angryPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngleShied,
      sweepAngleShied,
      false,
      shiedPaint,
    );

    // Labels around the circle
    TextPainter goodText = TextPainter(
      text: TextSpan(
        text: 'GOOD',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    goodText.layout();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(startAngleGood + sweepAngleGood / 2 + math.pi / 2);
    canvas.translate(0, -radius - strokeWidth / 2 - 10);
    goodText.paint(canvas, Offset(-goodText.width / 2, -goodText.height / 2));
    canvas.restore();

    TextPainter stressedText = TextPainter(
      text: TextSpan(
        text: 'STRESSED',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    stressedText.layout();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(startAngleStressed + sweepAngleStressed / 2 + math.pi / 2);
    canvas.translate(0, -radius - strokeWidth / 2 - 10);
    stressedText.paint(
      canvas,
      Offset(-stressedText.width / 2, -stressedText.height / 2),
    );
    canvas.restore();

    TextPainter angryText = TextPainter(
      text: TextSpan(
        text: 'ANGRY',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    angryText.layout();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(startAngleAngry + sweepAngleAngry / 2 + math.pi / 2);
    canvas.translate(0, -radius - strokeWidth / 2 - 10);
    angryText.paint(
      canvas,
      Offset(-angryText.width / 2, -angryText.height / 2),
    );
    canvas.restore();

    TextPainter shiedText = TextPainter(
      text: TextSpan(
        text: 'SHIED',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    shiedText.layout();
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(startAngleShied + sweepAngleShied / 2 + math.pi / 2);
    canvas.translate(0, -radius - strokeWidth / 2 - 10);
    shiedText.paint(
      canvas,
      Offset(-shiedText.width / 2, -shiedText.height / 2),
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for the Wave Chart
class WavePainter extends CustomPainter {
  final Color waveColor;

  WavePainter({required this.waveColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = waveColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final path = Path();
    path.moveTo(0, size.height * 0.7);

    // Create a series of quadratic bezier curves to simulate a wave
    for (int i = 0; i < 6; i++) {
      double startX = i * (size.width / 5);
      double endX = (i + 0.5) * (size.width / 5);
      double controlX = startX + (endX - startX) / 2;
      double controlY = i.isEven ? size.height * 0.3 : size.height * 0.9;
      path.quadraticBezierTo(controlX, controlY, endX, size.height * 0.7);
    }
    path.lineTo(size.width, size.height * 0.7);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Reusable White Card Widget
class WhiteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;
  final IconData? icon;
  final Color? iconColor;

  const WhiteCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900],
                      ),
                    ),
                  ],
                ),
                if (icon != null)
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: (iconColor ?? Colors.blue).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: iconColor ?? Colors.blue, size: 20),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}
