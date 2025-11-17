import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class EmotionalIntelligenceScreen extends StatelessWidget {
  const EmotionalIntelligenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Emotional Intelligence',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 12),
            _buildScoreChart(),
            SizedBox(height: 23),
            _buildInsights(),
            SizedBox(height: 12),
            _buildBreakdown(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Emotional',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        Text(
          'Intelligence Score',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildScoreChart() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: CustomPaint(
              painter: HexagonChartPainter(score: 110, maxScore: 160),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '110',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                Text(
                  'out of 160',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 40,
            bottom: 70,
            child: Icon(
              FontAwesomeIcons.handPointRight,
              size: 40,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You have a strong understanding of emotion showing excellent empathy and self-awareness.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
            height: 1.5,
          ),
        ),

      ],
    );
  }

  Widget _buildBreakdown(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'General breakdown',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 9),
        _buildSkillItem('Self-Awareness', 0.85, Colors.purple),
        SizedBox(height: 10),
        _buildSkillItem('Empathy', 0.75, Colors.blue),
        SizedBox(height: 10),
        _buildSkillItem('Social Skills', 0.65, Colors.green),
        SizedBox(height: 10),
        _buildSkillItem('Stress Management', 0.55, Colors.orange),
        SizedBox(height: 21),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MoodTrackerScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Track Your Mood',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkillItem(String title, double progress, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HexagonChartPainter extends CustomPainter {
  final double score;
  final double maxScore;

  HexagonChartPainter({required this.score, required this.maxScore});

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    final Paint borderPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final Paint fillPaint = Paint()
      ..color = Colors.purple.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    // Outer polygon points
    final List<Offset> outerPoints = [];
    for (int i = 0; i < 6; i++) {
      final double angle = math.pi / 3 * i - math.pi / 2;
      outerPoints.add(Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      ));
    }

    final Path outerPath = Path()..addPolygon(outerPoints, true);
    canvas.drawPath(outerPath, borderPaint);
    canvas.drawPath(outerPath, fillPaint);

    // Inner polygon points based on score
    final double scoreRatio = score / maxScore;
    final double innerRadius = radius * scoreRatio * 0.7;
    final List<Offset> innerPoints = [];
    for (int i = 0; i < 6; i++) {
      final double angle = math.pi / 3 * i - math.pi / 2;
      innerPoints.add(Offset(
        center.dx + innerRadius * math.cos(angle),
        center.dy + innerRadius * math.sin(angle),
      ));
    }

    final Paint scorePathPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.pink.withValues(alpha: 0.8), Colors.purple.withValues(alpha: 0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final Path scorePath = Path()..addPolygon(innerPoints, true);
    canvas.drawPath(scorePath, scorePathPaint);

    // Draw the circles at each vertex
    final List<Color> colors = [
      Colors.brown,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.red,
    ];

    for (int i = 0; i < outerPoints.length; i++) {
      canvas.drawCircle(outerPoints[i], 10, Paint()..color = colors[i]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  MoodTrackerScreenState createState() => MoodTrackerScreenState();
}

class MoodTrackerScreenState extends State<MoodTrackerScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int selectedMood = 3;
  final List<String> moodLabels = ['Very Sad', 'Sad', 'Neutral', 'Happy', 'Very Happy'];
  final List<Color> moodColors = [
    Colors.blue.shade300,
    Colors.blue.shade100,
    Colors.yellow.shade100,
    Colors.orange.shade100,
    Colors.orange.shade300
  ];
  final List<IconData> moodIcons = [
    FontAwesomeIcons.faceSadTear,
    FontAwesomeIcons.faceFrown,
    FontAwesomeIcons.faceMeh,
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceLaughBeam
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
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
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mood Tracker',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            _buildMoodSelector(),
            SizedBox(height: 21),
            _buildMoodHistory(),
            SizedBox(height: 22),
            _buildMoodInsights(),
            SizedBox(height: 21),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MeditationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Try Meditation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedMood = index;
                  _animationController.reset();
                  _animationController.forward();
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(selectedMood == index ? 12 : 8),
                decoration: BoxDecoration(
                  color: selectedMood == index
                      ? moodColors[index].withValues(alpha: 0.3)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selectedMood == index ? moodColors[index] : Colors.grey.withValues(alpha: 0.3),
                    width: selectedMood == index ? 3 : 1,
                  ),
                ),
                child: Icon(
                  moodIcons[index],
                  color: moodColors[index],
                  size: selectedMood == index ? 32 : 24,
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 20),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.scale(
              scale: 1.0 + (_animationController.value * 0.1),
              child: Text(
                moodLabels[selectedMood],
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: moodColors[selectedMood],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMoodHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Mood This Week',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 170,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              final height = 50.0 + (math.Random().nextDouble() * 80);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 800),
                    curve: Curves.elasticOut,
                    height: height,
                    width: 30,
                    decoration: BoxDecoration(
                      color: moodColors[math.min(4, (height / 26).round())],
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildMoodInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mood Insights',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.lightbulb,
                color: Colors.blue.shade400,
                size: 24,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  'Your mood has been improving over the past week. Keep up the positive activities!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  MeditationScreenState createState() => MeditationScreenState();
}

class MeditationScreenState extends State<MeditationScreen> with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late AnimationController _progressController;
  bool isPlaying = false;
  int selectedSession = 0;
  double progress = 0.0;

  final List<Map<String, dynamic>> meditationSessions = [
    {
      'title': 'Calm Mind',
      'duration': '10 min',
      'icon': FontAwesomeIcons.brain,
      'color': Colors.blue,
    },
    {
      'title': 'Stress Relief',
      'duration': '15 min',
      'icon': FontAwesomeIcons.spa,
      'color': Colors.green,
    },
    {
      'title': 'Deep Sleep',
      'duration': '20 min',
      'icon': FontAwesomeIcons.moon,
      'color': Colors.indigo,
    },
    {
      'title': 'Anxiety Relief',
      'duration': '12 min',
      'icon': FontAwesomeIcons.heart,
      'color': Colors.pink,
    },
  ];

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 4000),
    );
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 600), // 10 minutes
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  void togglePlay() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _breathingController.repeat(reverse: true);
        _progressController.forward();
      } else {
        _breathingController.stop();
        _progressController.stop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Meditation',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Find Your Inner Peace',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 30),
            _buildBreathingCircle(),
            SizedBox(height: 40),
            _buildSessionSelector(),
            SizedBox(height: 30),
            _buildProgressIndicator(),
            SizedBox(height: 30),
            _buildMeditationInsights(),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProgressReportScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'View Progress Report',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreathingCircle() {
    return Center(
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _breathingController,
            builder: (context, child) {
              return Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      meditationSessions[selectedSession]['color'].withValues(alpha: 0.2),
                      meditationSessions[selectedSession]['color'].withValues(alpha: 0.05),
                    ],
                  ),
                ),
                child: Transform.scale(
                  scale: 1.0 + (_breathingController.value * 0.3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: meditationSessions[selectedSession]['color'].withValues(alpha: 0.1),
                      border: Border.all(
                        color: meditationSessions[selectedSession]['color'],
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        meditationSessions[selectedSession]['icon'],
                        color: meditationSessions[selectedSession]['color'],
                        size: 60,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20),
          Text(
            isPlaying ? 'Breathe in... Breathe out...' : 'Press play to begin',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 20),
          IconButton(
            onPressed: togglePlay,
            icon: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
              color: meditationSessions[selectedSession]['color'],
              size: 70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSessionSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meditation Sessions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemCount: meditationSessions.length,
          itemBuilder: (context, index) {
            final session = meditationSessions[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSession = index;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: selectedSession == index
                      ? session['color'].withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: selectedSession == index
                        ? session['color']
                        : Colors.grey.withValues(alpha: 0.2),
                    width: selectedSession == index ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      session['icon'],
                      color: session['color'],
                      size: 30,
                    ),
                    SizedBox(height: 10),
                    Text(
                      session['title'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      session['duration'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Session Progress',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: meditationSessions[selectedSession]['color'],
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        AnimatedBuilder(
          animation: _progressController,
          builder: (context, child) {
            progress = _progressController.value;
            return Container(
              height: 10,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: progress,
                child: Container(
                  decoration: BoxDecoration(
                    color: meditationSessions[selectedSession]['color'],
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMeditationInsights() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meditation Benefits',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildBenefitCard(
                'Reduced Stress',
                FontAwesomeIcons.brain,
                Colors.blue,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: _buildBenefitCard(
                'Better Sleep',
                FontAwesomeIcons.moon,
                Colors.indigo,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _buildBenefitCard(
                'Improved Focus',
                FontAwesomeIcons.eye,
                Colors.green,
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: _buildBenefitCard(
                'Emotional Balance',
                FontAwesomeIcons.scaleBalanced,
                Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBenefitCard(String title, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProgressReportScreen extends StatelessWidget {
  const ProgressReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.grey[800]),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Progress Report',
          style: TextStyle(
            color: Colors.grey[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Mental Health Journey',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 30),
            _buildUserSummary(),
            SizedBox(height: 30),
            _buildProgressCharts(),
            SizedBox(height: 30),
            _buildAchievements(),
            SizedBox(height: 30),
            _buildRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepPurple.shade400, Colors.purple.shade300],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.2),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
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
                  'Alex Johnson',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Member since Jan 2023',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildSummaryStat('28', 'Day Streak', FontAwesomeIcons.fire),
                      SizedBox(width: 20),
                      _buildSummaryStat('86%', 'Goal Progress', FontAwesomeIcons.chartLine),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStat(String value, String label, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProgressCharts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Progress',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 200,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: CustomPaint(
            painter: ProgressChartPainter(),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievements() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Achievements',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            _buildAchievementCard(
              'Mindful Master',
              'Completed 30 meditation sessions',
              FontAwesomeIcons.medal,
              Colors.amber,
            ),
            SizedBox(width: 15),
            _buildAchievementCard(
              'Mood Tracker',
              'Logged mood for 30 days straight',
              FontAwesomeIcons.calendarCheck,
              Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementCard(String title, String subtitle, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 30,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendations() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personalized Recommendations',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.lightbulb,
                color: Colors.blue.shade400,
                size: 24,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Try Breathing Exercises',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Based on your stress levels, we recommend 5 minutes of deep breathing exercises daily.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Icon(
                FontAwesomeIcons.book,
                color: Colors.green.shade400,
                size: 24,
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Journaling Challenge',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Try our 7-day journaling challenge to improve self-awareness and emotional processing.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgressChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double padding = 20;
    final double chartWidth = size.width - padding * 2;
    final double chartHeight = size.height - padding * 2;

    // Draw grid lines
    final Paint gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Horizontal grid lines
    for (int i = 0; i <= 4; i++) {
      final double y = padding + (i * chartHeight / 4);
      canvas.drawLine(Offset(padding, y), Offset(size.width - padding, y), gridPaint);
    }

    // Vertical grid lines
    for (int i = 0; i <= 6; i++) {
      final double x = padding + (i * chartWidth / 6);
      canvas.drawLine(Offset(x, padding), Offset(x, size.height - padding), gridPaint);
    }

    // Mood data (simulated)
    final List<double> moodData = [3.2, 3.5, 2.8, 3.8, 4.0, 3.7, 4.2];
    final List<double> meditationData = [0.5, 0.7, 0.3, 0.8, 1.0, 0.9, 1.2];

    // Draw mood line
    final Paint moodPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final Path moodPath = Path();
    for (int i = 0; i < moodData.length; i++) {
      final double x = padding + (i * chartWidth / (moodData.length - 1));
      final double y = padding + chartHeight - (moodData[i] / 5 * chartHeight);

      if (i == 0) {
        moodPath.moveTo(x, y);
      } else {
        moodPath.lineTo(x, y);
      }

      // Draw point
      canvas.drawCircle(Offset(x, y), 5, moodPaint);
    }
    canvas.drawPath(moodPath, moodPaint);

    // Draw meditation line
    final Paint meditationPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final Path meditationPath = Path();
    for (int i = 0; i < meditationData.length; i++) {
      final double x = padding + (i * chartWidth / (meditationData.length - 1));
      final double y = padding + chartHeight - (meditationData[i] / 1.5 * chartHeight);

      if (i == 0) {
        meditationPath.moveTo(x, y);
      } else {
        meditationPath.lineTo(x, y);
      }

      // Draw point
      canvas.drawCircle(Offset(x, y), 5, meditationPaint);
    }
    canvas.drawPath(meditationPath, meditationPaint);

    // Draw labels
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    // X-axis labels
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < days.length; i++) {
      final double x = padding + (i * chartWidth / (days.length - 1));
      textPainter.text = TextSpan(
        text: days[i],
        style: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - textPainter.width / 2, size.height - padding + 5));
    }

    // Legend
    textPainter.text = TextSpan(
      text: 'Mood',
      style: TextStyle(
        fontSize: 12,
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(padding, 5));

    canvas.drawCircle(Offset(padding + textPainter.width + 10, 10), 5, moodPaint);

    textPainter.text = TextSpan(
      text: 'Meditation',
      style: TextStyle(
        fontSize: 12,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(padding + 50, 5));

    canvas.drawCircle(Offset(padding + textPainter.width + 60, 10), 5, meditationPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}