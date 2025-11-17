import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

// Utility function to convert opacity to alpha for Color.withAlpha



class StepsTaken extends StatefulWidget {
  const StepsTaken({super.key});

  @override
  StepsTakenState createState() => StepsTakenState();
}

class StepsTakenState extends State<StepsTaken> with TickerProviderStateMixin {
  int currentSteps = 778;
  int targetSteps = 10000;
  String userMood = "mildly depressed";
  double socialWellbeing = 78.5;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<String> userImageUrls = [
    "https://randomuser.me/api/portraits/men/11.jpg",
    "https://randomuser.me/api/portraits/women/44.jpg",
    "https://randomuser.me/api/portraits/men/22.jpg",
    "https://randomuser.me/api/portraits/women/55.jpg",
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.grey[700]),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Steps Taken Card
              _buildAnimatedCard(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Steps Taken",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(FontAwesomeIcons.shoePrints, color: Colors.deepPurple, size: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "$currentSteps",
                                style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurple,
                                ),
                              ),
                              Text(
                                "steps",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        "You are $userMood!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.redAccent,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      SizedBox(height: 12),
                      Center(child: _buildStepsChart()),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MetricTile(
                            icon: FontAwesomeIcons.personWalking,
                            value: "${(currentSteps * 0.0008).toStringAsFixed(1)}km",
                            label: "distance",
                            color: Colors.green.shade400,
                          ),
                          MetricTile(
                            icon: FontAwesomeIcons.fire,
                            value: "${(currentSteps * 0.04).toStringAsFixed(0)} kcal",
                            label: "kcal",
                            color: Colors.red.shade400,
                          ),
                          MetricTile(
                            icon: FontAwesomeIcons.guaraniSign,
                            value: "${(currentSteps / 600).toStringAsFixed(1)}m/s",
                            label: "pacing",
                            color: Colors.orange.shade400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 6),
              // Social Wellbeing Card
              _buildAnimatedCard(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Social Wellbeing",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.users, color: Colors.blueAccent, size: 30),
                          SizedBox(width: 10),
                          Text(
                            "${socialWellbeing.toStringAsFixed(1)} pts",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        "You've been engaging with people more!",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 11),
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userImageUrls.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(userImageUrls[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MoodJournalScreen()),
                            );
                          },
                          icon: Icon(FontAwesomeIcons.book),
                          label: Text("Mood Journal"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Mood Tracker Card
              _buildAnimatedCard(
                child: Padding(
                  padding: const EdgeInsets.all(11.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mood Tracker",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MoodIcon(icon: FontAwesomeIcons.faceFrownOpen, label: "Awful", color: Colors.red.shade700),
                          MoodIcon(icon: FontAwesomeIcons.faceFrown, label: "Bad", color: Colors.orange.shade700),
                          MoodIcon(icon: FontAwesomeIcons.faceMeh, label: "Okay", color: Colors.yellow.shade700),
                          MoodIcon(icon: FontAwesomeIcons.faceSmile, label: "Good", color: Colors.lightGreen.shade700),
                          MoodIcon(icon: FontAwesomeIcons.faceGrinStars, label: "Great", color: Colors.green.shade700),
                        ],
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Daily mood analysis and suggestions:",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.lightbulb, color: Colors.deepPurple),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                "Consider a mindful walk to boost your spirits!",
                                style: TextStyle(color: Colors.deepPurple, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MindfulnessExercisesScreen()),
                            );
                          },
                          icon: Icon(FontAwesomeIcons.brain),
                          label: Text("Mindfulness Exercises"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Activity Chart Card
              _buildAnimatedCard(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Activity Progress",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildActivityChart(),
                      SizedBox(height: 15),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProgressOverviewScreen()),
                            );
                          },
                          icon: Icon(FontAwesomeIcons.chartLine),
                          label: Text("View Full Progress"),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.teal,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
    );
  }

  Widget _buildAnimatedCard({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      curve: Curves.elasticOut,
      builder: (context, double value, child) {
        // Clamp the value to ensure it's always between 0.0 and 1.0
        final clampedValue = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: clampedValue,
          child: Opacity(
            opacity: clampedValue,
            child: Card(
              color: Colors.white,
              elevation: 8,
              shadowColor: Colors.deepPurple.withValues(alpha: 0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildStepsChart() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 180,
          child: AspectRatio(
            aspectRatio: 1.0,
            child: TweenAnimationBuilder(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: Duration(seconds: 1),
              builder: (context, double value, child) {
                // Clamp the value to ensure it's always between 0.0 and 1.0
                final clampedValue = value.clamp(0.0, 1.0);
                return PieChart(
                  PieChartData(
                    startDegreeOffset: 270,
                    sectionsSpace: 0,
                    centerSpaceRadius: 70,
                    sections: [
                      PieChartSectionData(
                        color: Colors.deepPurple.shade300,
                        value: currentSteps.toDouble() * clampedValue,
                        radius: 20,
                        showTitle: false,
                      ),
                      PieChartSectionData(
                        color: Colors.deepPurple.shade100,
                        value: (targetSteps - currentSteps).toDouble(),
                        radius: 20,
                        showTitle: false,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${(currentSteps / targetSteps * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            Text(
              "${targetSteps - currentSteps} steps left",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActivityChart() {
    return SizedBox(
      height: 200,
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
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  String label = '';
                  switch (value.toInt()) {
                    case 0:
                      label = 'Mon';
                      break;
                    case 1:
                      label = 'Tue';
                      break;
                    case 2:
                      label = 'Wed';
                      break;
                    case 3:
                      label = 'Thu';
                      break;
                    case 4:
                      label = 'Fri';
                      break;
                    case 5:
                      label = 'Sat';
                      break;
                    case 6:
                      label = 'Sun';
                      break;
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 6,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3000),
                FlSpot(1, 4500),
                FlSpot(2, 6000),
                FlSpot(3, 5000),
                FlSpot(4, 7000),
                FlSpot(5, 8500),
                FlSpot(6, 7500),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple.withValues(alpha: 0.3),
                    Colors.purpleAccent.withValues(alpha: 0.1),
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

class MetricTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const MetricTile({super.key, required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: color.withValues(alpha: 0.1),
          child: Icon(icon, color: color, size: 18),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class MoodIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const MoodIcon({super.key, required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 35, color: color),
        SizedBox(height: 5),
        Text(label, style: TextStyle(color: Colors.grey[700])),
      ],
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Text("Settings Content Here!", style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

// Mood Journal Screen
class MoodJournalScreen extends StatefulWidget {
  const MoodJournalScreen({super.key});

  @override
  MoodJournalScreenState createState() => MoodJournalScreenState();
}

class MoodJournalScreenState extends State<MoodJournalScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final TextEditingController _journalController = TextEditingController();
  List<Map<String, dynamic>> journalEntries = [
    {
      "date": "Today",
      "mood": "Okay",
      "entry": "Feeling a bit anxious but managed to complete my work.",
      "tags": ["work", "anxiety"]
    },
    {
      "date": "Yesterday",
      "mood": "Good",
      "entry": "Had a great time with friends at the park.",
      "tags": ["friends", "outdoor"]
    },
    {
      "date": "May 12",
      "mood": "Bad",
      "entry": "Couldn't sleep well, feeling tired.",
      "tags": ["sleep", "fatigue"]
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mood Journal"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How are you feeling today?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              _buildMoodSelector(),
              SizedBox(height: 20),
              TextField(
                controller: _journalController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Write about your day...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 20),
              _buildTagSelector(),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Save journal entry
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Journal entry saved!"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("Save Entry", style: TextStyle(fontSize: 16)),
                ),
              ),
              SizedBox(height: 30),
              Text(
                "Previous Entries",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 10),
              // Fixed overflow issue by wrapping in a Container with fixed height
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: journalEntries.length,
                  itemBuilder: (context, index) {
                    return _buildJournalEntryCard(journalEntries[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildMoodOption(FontAwesomeIcons.faceFrownOpen, "Awful", Colors.red.shade700),
        _buildMoodOption(FontAwesomeIcons.faceFrown, "Bad", Colors.orange.shade700),
        _buildMoodOption(FontAwesomeIcons.faceMeh, "Okay", Colors.yellow.shade700),
        _buildMoodOption(FontAwesomeIcons.faceSmile, "Good", Colors.lightGreen.shade700),
        _buildMoodOption(FontAwesomeIcons.faceGrinStars, "Great", Colors.green.shade700),
      ],
    );
  }

  Widget _buildMoodOption(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        // Select mood
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(color: Colors.grey[700])),
        ],
      ),
    );
  }

  Widget _buildTagSelector() {
    List<String> tags = ["work", "family", "friends", "health", "sleep", "exercise", "anxiety", "happiness"];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: tags.map((tag) {
        return FilterChip(
          label: Text(tag),
          onSelected: (selected) {
            // Toggle tag selection
          },
          selectedColor: Colors.blueAccent.withValues(alpha: 0.2),
          checkmarkColor: Colors.blueAccent,
        );
      }).toList(),
    );
  }

  Widget _buildJournalEntryCard(Map<String, dynamic> entry) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  entry["date"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getMoodColor(entry["mood"]).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    entry["mood"],
                    style: TextStyle(
                      color: _getMoodColor(entry["mood"]),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              entry["entry"],
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 6,
              children: (entry["tags"] as List<String>).map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: Colors.grey[200],
                  labelStyle: TextStyle(fontSize: 12),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood) {
      case "Awful":
        return Colors.red.shade700;
      case "Bad":
        return Colors.orange.shade700;
      case "Okay":
        return Colors.yellow.shade700;
      case "Good":
        return Colors.lightGreen.shade700;
      case "Great":
        return Colors.green.shade700;
      default:
        return Colors.grey;
    }
  }
}

// Mindfulness Exercises Screen
class MindfulnessExercisesScreen extends StatefulWidget {
  const MindfulnessExercisesScreen({super.key});

  @override
  MindfulnessExercisesScreenState createState() => MindfulnessExercisesScreenState();
}

class MindfulnessExercisesScreenState extends State<MindfulnessExercisesScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int selectedExercise = 0;
  bool isPlaying = false;
  int secondsRemaining = 300; // 5 minutes
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;

  final List<Map<String, dynamic>> exercises = [
    {
      "title": "Breathing Exercise",
      "description": "Focus on your breath to reduce stress",
      "duration": "5 min",
      "icon": FontAwesomeIcons.wind,
      "color": Colors.teal,
    },
    {
      "title": "Body Scan",
      "description": "Relax your body from head to toe",
      "duration": "10 min",
      "icon": FontAwesomeIcons.person,
      "color": Colors.purple,
    },
    {
      "title": "Loving Kindness",
      "description": "Cultivate compassion for yourself and others",
      "duration": "8 min",
      "icon": FontAwesomeIcons.heart,
      "color": Colors.pink,
    },
    {
      "title": "Mindful Walking",
      "description": "Practice mindfulness while walking",
      "duration": "15 min",
      "icon": FontAwesomeIcons.personWalking,
      "color": Colors.green,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    _breathingController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _breathingAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
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
    _controller.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mindfulness Exercises"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose an Exercise",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              // Fixed overflow issue by wrapping in a Flexible widget
              Flexible(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return _buildExerciseCard(exercises[index], index);
                  },
                ),
              ),
              SizedBox(height: 20),
              if (selectedExercise >= 0) _buildExercisePlayer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(Map<String, dynamic> exercise, int index) {
    bool isSelected = selectedExercise == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedExercise = index;
          isPlaying = false;
          secondsRemaining = int.parse(exercise["duration"].split(" ")[0]) * 60;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isSelected ? exercise["color"].withValues(alpha: 0.1) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
          border: Border.all(
            color: isSelected ? exercise["color"] : Colors.transparent,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                exercise["icon"],
                size: 30,
                color: exercise["color"],
              ),
              SizedBox(height: 8),
              Text(
                exercise["title"],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Text(
                  exercise["description"],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.clock,
                    size: 14,
                    color: Colors.grey[500],
                  ),
                  SizedBox(width: 5),
                  Text(
                    exercise["duration"],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
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

  Widget _buildExercisePlayer() {
    if (selectedExercise < 0) return Container();

    final exercise = exercises[selectedExercise];

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            exercise["title"],
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 20),
          if (exercise["title"] == "Breathing Exercise")
            _buildBreathingAnimation(),
          if (exercise["title"] != "Breathing Exercise")
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: exercise["color"].withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Icon(
                  exercise["icon"],
                  size: 50,
                  color: exercise["color"],
                ),
              ),
            ),
          SizedBox(height: 20),
          Text(
            "${(secondsRemaining ~/ 60).toString().padLeft(2, '0')}:${(secondsRemaining % 60).toString().padLeft(2, '0')}",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: exercise["color"],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    if (isPlaying) {
                      _breathingController.forward();
                      _startTimer();
                    } else {
                      _breathingController.stop();
                    }
                  });
                },
                icon: Icon(
                  isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                  color: exercise["color"],
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isPlaying = false;
                    secondsRemaining = int.parse(exercise["duration"].split(" ")[0]) * 60;
                    _breathingController.reset();
                  });
                },
                icon: Icon(
                  FontAwesomeIcons.arrowRotateRight,
                  color: exercise["color"],
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBreathingAnimation() {
    return AnimatedBuilder(
      animation: _breathingAnimation,
      builder: (context, child) {
        return SizedBox(
          height: 120,
          child: Center(
            child: Transform.scale(
              scale: _breathingAnimation.value.clamp(0.5, 1.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _breathingAnimation.value > 0.75 ? "Breathe In" : "Breathe Out",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _startTimer() {
    if (!isPlaying) return;

    Future.delayed(Duration(seconds: 1), () {
      if (secondsRemaining > 0 && isPlaying) {
        setState(() {
          secondsRemaining--;
        });
        _startTimer();
      } else {
        setState(() {
          isPlaying = false;
          _breathingController.stop();
        });

      }
    });
  }
}

// Progress Overview Screen
class ProgressOverviewScreen extends StatefulWidget {
  const ProgressOverviewScreen({super.key});

  @override
  ProgressOverviewScreenState createState() => ProgressOverviewScreenState();
}

class ProgressOverviewScreenState extends State<ProgressOverviewScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late TabController _tabController;

  final List<String> tabs = ["Week", "Month", "Year"];
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Overview"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _animation,
        child: Column(
          children: [
            Container(
              color: Colors.teal,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
                tabs: tabs.map((tab) => Tab(text: tab)).toList(),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildProgressContent("Week"),
                  _buildProgressContent("Month"),
                  _buildProgressContent("Year"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressContent(String period) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProgressCard(
            title: "Mood Trends",
            content: _buildMoodChart(),
            color: Colors.blue,
          ),
          SizedBox(height: 20),
          _buildProgressCard(
            title: "Activity Levels",
            content: _buildActivityChart(),
            color: Colors.green,
          ),
          SizedBox(height: 20),
          _buildProgressCard(
            title: "Mindfulness Sessions",
            content: _buildMindfulnessChart(),
            color: Colors.purple,
          ),
          SizedBox(height: 20),
          _buildProgressCard(
            title: "Achievements",
            content: _buildAchievements(),
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard({required String title, required Widget content, required Color color}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 24,
                  color: color,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10), // Reduced from 15 to 10
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildMoodChart() {
    return SizedBox(
      height: 170, // Reduced from 200 to 170
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
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
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String label = '';
                  if (selectedTab == 0) {
                    switch (value.toInt()) {
                      case 0:
                        label = 'Mon';
                        break;
                      case 1:
                        label = 'Tue';
                        break;
                      case 2:
                        label = 'Wed';
                        break;
                      case 3:
                        label = 'Thu';
                        break;
                      case 4:
                        label = 'Fri';
                        break;
                      case 5:
                        label = 'Sat';
                        break;
                      case 6:
                        label = 'Sun';
                        break;
                    }
                  } else if (selectedTab == 1) {
                    label = 'Wk ${value.toInt() + 1}';
                  } else {
                    label = '${value.toInt() + 1}';
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 6,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(
                  toY: 3,
                  color: Colors.green,
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
                  color: Colors.lightGreen,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(
                  toY: 2,
                  color: Colors.yellow,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(
                  toY: 3,
                  color: Colors.lightGreen,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
            BarChartGroupData(
              x: 4,
              barRods: [
                BarChartRodData(
                  toY: 4,
                  color: Colors.green,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
            BarChartGroupData(
              x: 5,
              barRods: [
                BarChartRodData(
                  toY: 5,
                  color: Colors.green,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
            BarChartGroupData(
              x: 6,
              barRods: [
                BarChartRodData(
                  toY: 4,
                  color: Colors.lightGreen,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityChart() {
    return SizedBox(
      height: 170, // Reduced from 200 to 170
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
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String label = '';
                  if (selectedTab == 0) {
                    switch (value.toInt()) {
                      case 0:
                        label = 'Mon';
                        break;
                      case 1:
                        label = 'Tue';
                        break;
                      case 2:
                        label = 'Wed';
                        break;
                      case 3:
                        label = 'Thu';
                        break;
                      case 4:
                        label = 'Fri';
                        break;
                      case 5:
                        label = 'Sat';
                        break;
                      case 6:
                        label = 'Sun';
                        break;
                    }
                  } else if (selectedTab == 1) {
                    label = 'Wk ${value.toInt() + 1}';
                  } else {
                    label = '${value.toInt() + 1}';
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 6,
                    child: Text(
                      label,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 3000),
                FlSpot(1, 4500),
                FlSpot(2, 6000),
                FlSpot(3, 5000),
                FlSpot(4, 7000),
                FlSpot(5, 8500),
                FlSpot(6, 7500),
              ],
              isCurved: true,
              gradient: LinearGradient(
                colors: [Colors.green, Colors.teal],
              ),
              barWidth: 4,
              isStrokeCapRound: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.green.withValues(alpha: 0.3),
                    Colors.teal.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMindfulnessChart() {
    return SizedBox(
      height: 170, // Reduced from 200 to 170
      child: PieChart(
        PieChartData(
          sectionsSpace: 2,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              color: Colors.purple.shade300,
              value: 35,
              title: '35%',
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              radius: 60,
            ),
            PieChartSectionData(
              color: Colors.purple.shade200,
              value: 25,
              title: '25%',
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              radius: 60,
            ),
            PieChartSectionData(
              color: Colors.purple.shade100,
              value: 20,
              title: '20%',
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              radius: 60,
            ),
            PieChartSectionData(
              color: Colors.purple.shade50,
              value: 20,
              title: '20%',
              titleStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              radius: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievements() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAchievementItem(
              icon: FontAwesomeIcons.trophy,
              title: "7-Day Streak",
              color: Colors.amber,
            ),
            _buildAchievementItem(
              icon: FontAwesomeIcons.medal,
              title: "Mindful Master",
              color: Colors.blue,
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildAchievementItem(
              icon: FontAwesomeIcons.star,
              title: "Mood Tracker",
              color: Colors.purple,
            ),
            _buildAchievementItem(
              icon: FontAwesomeIcons.fire,
              title: "Active Week",
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAchievementItem({required IconData icon, required String title, required Color color}) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 30,
            color: color,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}