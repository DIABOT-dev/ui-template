import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppColors {
  static const Color primaryGreen = Color(0xFF7CAF70);
  static const Color darkGreen = Color(0xFF4C8D46);
  static const Color lightGreen = Color(0xFFE8F2E7);
  static const Color scoreBackground = Color(0xFFE8F2E7);
  static const Color cardBackground = Colors.white;
  static const Color textColor = Color(0xFF333333);
  static const Color lightTextColor = Color(0xFF6B6B6B);
  static const Color neutralColor = Color(0xFF9E9E9E);
  static const Color positiveBar = Color(0xFF7CAF70);
  static const Color negativeBar = Color(0xFFEB7F70);
  static const Color orangeMood = Color(0xFFFFA726);
  static const Color blueMood = Color(0xFF2196F3);
  static const Color redMood = Color(0xFFEF5350);
  static const Color yellowMood = Color(0xFFFFD54F);
  static const Color purpleMood = Color(0xFFAB47BC);
  static const Color backgroundColor = Color(0xFFF9FAFB);
  static const Color accentColor = Color(0xFF4F46E5);
  static const Color lightAccentColor = Color(0xFFEEF2FF);
}

class FreudScoresss extends StatelessWidget {
  const FreudScoresss({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:BackButton(),
        title: const Text('Freud Score', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Normal',
              style: TextStyle(color: AppColors.darkGreen, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Freud Score Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: AppColors.scoreBackground,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  const Text(
                    '80',
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryGreen,
                    ),
                  ),
                  const Text(
                    'Mentally Stable',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 80,
                    child: BarChart(
                      BarChartData(
                        barGroups: [
                          BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(
                                toY: 6,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 1,
                            barRods: [
                              BarChartRodData(
                                toY: 8,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 2,
                            barRods: [
                              BarChartRodData(
                                toY: 10,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 3,
                            barRods: [
                              BarChartRodData(
                                toY: 12,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 4,
                            barRods: [
                              BarChartRodData(
                                toY: 11,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 5,
                            barRods: [
                              BarChartRodData(
                                toY: 9,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                          BarChartGroupData(
                            x: 6,
                            barRods: [
                              BarChartRodData(
                                toY: 7,
                                color: AppColors.primaryGreen,
                                width: 8,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ],
                          ),
                        ],
                        titlesData: const FlTitlesData(show: false),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Score History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder:(_) => const InsightsScreen()));
                  },
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: AppColors.darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            // History Cards
            ScoreHistoryCard(
              date: 'SEP 12',
              status: 'Anxious, Depressed',
              suggestion: 'Do 25m Breathing',
              score: 68,
              scoreColor: AppColors.negativeBar,
            ),
            const SizedBox(height: 4),
            ScoreHistoryCard(
              date: 'SEP 11',
              status: 'Very Happy',
              suggestion: 'No Recommendation.',
              score: 95,
              scoreColor: AppColors.primaryGreen,
            ),
            const SizedBox(height: 4),
            ScoreHistoryCard(
              date: 'SEP 10',
              status: 'Neutral',
              suggestion: 'Keep it up',
              score: 85,
              scoreColor: AppColors.neutralColor,
            ),
            const SizedBox(height: 12),
            // Navigation to Filter Screen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(_) => const FilterScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Go to Filter Screen',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Navigation to Suggestions Screen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(_) => const SuggestionsScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Go to Suggestions Screen',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Navigation to Profile Screen
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(_) => const ProfileScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  'Go to Profile Screen',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreHistoryCard extends StatelessWidget {
  final String date;
  final String status;
  final String suggestion;
  final int score;
  final Color scoreColor;

  const ScoreHistoryCard({
    super.key,
    required this.date,
    required this.status,
    required this.suggestion,
    required this.score,
    required this.scoreColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: AppColors.lightTextColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    suggestion,
                    style: const TextStyle(
                      color: AppColors.lightTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: scoreColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '$score',
                style: TextStyle(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
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

class _FilterScreenState extends State<FilterScreen> {
  DateTime? startDate;
  DateTime? endDate;
  RangeValues _scoreRange = const RangeValues(0, 100);
  bool _includeAISuggestions = true;

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'YYYY/MM/DD';
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Filter Freud Score', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circleQuestion, size: 20, color: AppColors.neutralColor),
            onPressed: () {
              // Show help/info
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'From',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.lightGreen, width: 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.calendarDay, size: 20, color: AppColors.primaryGreen),
                          const SizedBox(width: 12),
                          Text(
                            _formatDate(startDate),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'To',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => _selectDate(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: AppColors.lightGreen, width: 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(FontAwesomeIcons.calendarDay, size: 20, color: AppColors.primaryGreen),
                          const SizedBox(width: 12),
                          Text(
                            _formatDate(endDate),
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Score Range',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RangeSlider(
                            values: _scoreRange,
                            min: 0,
                            max: 100,
                            divisions: 100,
                            activeColor: AppColors.primaryGreen,
                            inactiveColor: AppColors.lightGreen,
                            labels: RangeLabels(
                              _scoreRange.start.round().toString(),
                              _scoreRange.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _scoreRange = values;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${_scoreRange.start.round()}', style: const TextStyle(color: AppColors.lightTextColor)),
                                Text('${_scoreRange.end.round()}', style: const TextStyle(color: AppColors.lightTextColor)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Include AI Suggestions',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textColor,
                        ),
                      ),
                      Switch(
                        value: _includeAISuggestions,
                        onChanged: (bool value) {
                          setState(() {
                            _includeAISuggestions = value;
                          });
                        },
                        activeColor: AppColors.primaryGreen,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Apply filter logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Filter Applied!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.darkGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(FontAwesomeIcons.magnifyingGlass, color: Colors.white, size: 20),
                label: const Text(
                  'Filter Freud Score (15)', // Placeholder count
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InsightsScreen extends StatefulWidget {
  const InsightsScreen({super.key});

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int _selectedTabIndex = 0; // 0 for Positive, 1 for Negative

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Freud Score', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circleQuestion, size: 20, color: AppColors.neutralColor),
            onPressed: () {
              // Show help/info
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'See your mental score insights',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.lightTextColor,
              ),
            ),
            const SizedBox(height: 2),
            // Tab and Dropdown
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildTabButton(0, 'Positive'),
                      const SizedBox(width: 8),
                      _buildTabButton(1, 'Negative'),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.lightGreen),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: 'Monthly', // Default value
                      icon: const Icon(FontAwesomeIcons.chevronDown, size: 14, color: AppColors.neutralColor),
                      style: const TextStyle(color: AppColors.textColor, fontSize: 14),
                      items: <String>['Daily', 'Weekly', 'Monthly', 'Yearly'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        // Handle dropdown change
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            // Bar Chart
            AspectRatio(
              aspectRatio: 1.7,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 12,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const style = TextStyle(
                                color: AppColors.lightTextColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              );
                              Widget text;
                              switch (value.toInt()) {
                                case 0:
                                  text = const Text('09 Jan', style: style);
                                  break;
                                case 1:
                                  text = const Text('16 Jan', style: style);
                                  break;
                                case 2:
                                  text = const Text('23 Jan', style: style);
                                  break;
                                case 3:
                                  text = const Text('30 Jan', style: style);
                                  break;
                                case 4:
                                  text = const Text('06 Feb', style: style);
                                  break;
                                case 5:
                                  text = const Text('13 Feb', style: style);
                                  break;
                                case 6:
                                  text = const Text('20 Feb', style: style);
                                  break;
                                default:
                                  text = const Text('');
                                  break;
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 4,
                                child: text,
                              );
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      ),
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: _chartBarGroups(),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Mood History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
              ),
            ),
            const SizedBox(height: 5),
            // Mood History Grid
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text('Mon', style: TextStyle(color: AppColors.lightTextColor)),
                        Text('Tue', style: TextStyle(color: AppColors.lightTextColor)),
                        Text('Wed', style: TextStyle(color: AppColors.lightTextColor)),
                        Text('Thu', style: TextStyle(color: AppColors.lightTextColor)),
                        Text('Fri', style: TextStyle(color: AppColors.lightTextColor)),
                        Text('Sat', style: TextStyle(color: AppColors.lightTextColor)),
                        Text('Sun', style: TextStyle(color: AppColors.lightTextColor)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemCount: 28, // Example: 4 weeks of data
                      itemBuilder: (context, index) {
                        return MoodIcon(
                          day: index + 1,
                          mood: _getMoodForDay(index), // Simulate different moods
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            // AI Suggestions button
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(_) => const SuggestionsScreen()));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.solidLightbulb, color: AppColors.primaryGreen, size: 24),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Swipe for AI suggestions',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textColor,
                            ),
                          ),
                          Text(
                            'Get personalized recommendations.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.lightTextColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(FontAwesomeIcons.chevronRight, color: AppColors.neutralColor, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String text) {
    bool isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.darkGreen : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.lightGreen),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartBarGroups() {
    return List.generate(7, (i) {
      double positiveValue = 0;
      double negativeValue = 0;

      // Simulate data based on the design image
      switch (i) {
        case 0:
          positiveValue = 8;
          negativeValue = 0;
          break;
        case 1:
          positiveValue = 9;
          negativeValue = 0;
          break;
        case 2:
          positiveValue = 7;
          negativeValue = 2; // Example negative
          break;
        case 3:
          positiveValue = 10;
          negativeValue = 0;
          break;
        case 4:
          positiveValue = 6;
          negativeValue = 3;
          break;
        case 5:
          positiveValue = 8;
          negativeValue = 1;
          break;
        case 6:
          positiveValue = 9;
          negativeValue = 0;
          break;
      }

      return BarChartGroupData(
        x: i,
        barsSpace: 4,
        barRods: [
          BarChartRodData(
            toY: positiveValue,
            color: AppColors.positiveBar,
            width: 12,
            borderRadius: BorderRadius.circular(2),
          ),
          BarChartRodData(
            toY: negativeValue,
            color: AppColors.negativeBar,
            width: 12,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      );
    });
  }

  // Get mood color for a specific day
  Color _getMoodForDay(int index) {
    // Simulate different moods for different days
    final List<Color> moods = [
      AppColors.yellowMood,  // Happy
      AppColors.primaryGreen, // Good
      AppColors.blueMood,    // Calm
      AppColors.orangeMood,  // Neutral
      AppColors.purpleMood,  // Sad
      AppColors.redMood,     // Angry
      AppColors.yellowMood,  // Happy
    ];

    // Cycle through moods based on index
    return moods[index % moods.length];
  }
}

class MoodIcon extends StatelessWidget {
  final int day;
  final Color mood;

  const MoodIcon({
    super.key,
    required this.day,
    required this.mood,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mood.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$day',
          style: TextStyle(
            color: mood,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class SuggestionsScreen extends StatefulWidget {
  const SuggestionsScreen({super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> with SingleTickerProviderStateMixin {
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
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('AI Suggestions', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidBookmark, size: 20, color: AppColors.neutralColor),
            onPressed: () {
              // Navigate to saved suggestions
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AI Header Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryGreen, AppColors.darkGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withValues(alpha: 0.2),
                        blurRadius: 10,
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              FontAwesomeIcons.solidLightbulb,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AI-Powered Recommendations',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Personalized for your mental wellbeing',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Updated Today',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Daily Suggestions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                // Suggestion Cards
                _buildSuggestionCard(
                  title: 'Breathing Exercise',
                  description: 'Try this 5-minute breathing exercise to reduce anxiety and improve focus.',
                  icon: FontAwesomeIcons.wind,
                  color: AppColors.blueMood,
                  duration: '5 min',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const MeditationScreen()));
                  },
                ),
                const SizedBox(height: 12),
                _buildSuggestionCard(
                  title: 'Gratitude Journal',
                  description: 'Write down three things you\'re grateful for today to boost positive emotions.',
                  icon: FontAwesomeIcons.book,
                  color: AppColors.yellowMood,
                  duration: '10 min',
                  onTap: () {
                    // Navigate to journal screen
                  },
                ),
                const SizedBox(height: 12),
                _buildSuggestionCard(
                  title: 'Mindful Walk',
                  description: 'Take a 15-minute walk in nature while focusing on your senses.',
                  icon: FontAwesomeIcons.personWalking,
                  color: AppColors.primaryGreen,
                  duration: '15 min',
                  onTap: () {
                    // Navigate to activity details
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Weekly Challenges',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildChallengeCard(
                  title: 'Digital Detox',
                  description: 'Reduce screen time by 1 hour each day this week',
                  progress: 0.4,
                  color: AppColors.purpleMood,
                ),
                const SizedBox(height: 12),
                _buildChallengeCard(
                  title: 'Sleep Hygiene',
                  description: 'Maintain consistent sleep schedule for 7 days',
                  progress: 0.7,
                  color: AppColors.blueMood,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Educational Content',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildArticleCard(
                  title: 'Understanding Anxiety',
                  description: 'Learn about the causes and symptoms of anxiety disorders',
                  readTime: '8 min read',
                  imageUrl: 'https://plus.unsplash.com/premium_photo-1664809961845-95c9a6619518?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                ),
                const SizedBox(height: 12),
                _buildArticleCard(
                  title: 'Mindfulness Techniques',
                  description: 'Discover practical mindfulness exercises for daily life',
                  readTime: '12 min read',
                    imageUrl: 'https://plus.unsplash.com/premium_photo-1664809961845-95c9a6619518?q=80&w=1740&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required String duration,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
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
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.lightTextColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Text(
                  duration,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.lightTextColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Icon(
                  FontAwesomeIcons.chevronRight,
                  size: 14,
                  color: AppColors.neutralColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String description,
    required double progress,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
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
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  FontAwesomeIcons.trophy,
                  color: color,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.lightTextColor,
            ),
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.lightGreen,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required String description,
    required String readTime,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: AppColors.lightGreen,
                  child: const Icon(
                    FontAwesomeIcons.image,
                    color: AppColors.primaryGreen,
                  ),
                );
              },
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
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.clock,
                      size: 12,
                      color: AppColors.neutralColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      readTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.lightTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
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
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.gear, size: 20, color: AppColors.neutralColor),
            onPressed: () {
              // Navigate to settings
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryGreen, AppColors.darkGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                'https://randomuser.me/api/portraits/men/11.jpg',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    color: AppColors.lightGreen,
                                    child: const Icon(
                                      FontAwesomeIcons.user,
                                      color: AppColors.primaryGreen,
                                      size: 40,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Alex Johnson',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Member since Jan 2023',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.solidStar,
                                      color: Colors.yellow,
                                      size: 14,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Premium Member',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
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
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatColumn('78', 'Avg. Score'),
                          _buildStatColumn('42', 'Day Streak'),
                          _buildStatColumn('16', 'Activities'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Account Settings',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  title: 'Personal Information',
                  icon: FontAwesomeIcons.user,
                  color: AppColors.primaryGreen,
                  onTap: () {
                    // Navigate to personal info
                  },
                ),
                const SizedBox(height: 12),
                _buildSettingsItem(
                  title: 'Notification Preferences',
                  icon: FontAwesomeIcons.bell,
                  color: AppColors.orangeMood,
                  onTap: () {
                    // Navigate to notification settings
                  },
                ),
                const SizedBox(height: 12),
                _buildSettingsItem(
                  title: 'Privacy & Security',
                  icon: FontAwesomeIcons.lock,
                  color: AppColors.blueMood,
                  onTap: () {
                    // Navigate to privacy settings
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'App Preferences',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  title: 'Appearance',
                  icon: FontAwesomeIcons.palette,
                  color: AppColors.purpleMood,
                  onTap: () {
                    // Navigate to appearance settings
                  },
                ),
                const SizedBox(height: 12),
                _buildSettingsItem(
                  title: 'Reminders',
                  icon: FontAwesomeIcons.clock,
                  color: AppColors.yellowMood,
                  onTap: () {
                    // Navigate to reminder settings
                  },
                ),
                const SizedBox(height: 12),
                _buildSettingsItem(
                  title: 'Data & Storage',
                  icon: FontAwesomeIcons.database,
                  color: AppColors.redMood,
                  onTap: () {
                    // Navigate to data settings
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSettingsItem(
                  title: 'Help Center',
                  icon: FontAwesomeIcons.circleQuestion,
                  color: AppColors.primaryGreen,
                  onTap: () {
                    // Navigate to help center
                  },
                ),
                const SizedBox(height: 12),
                _buildSettingsItem(
                  title: 'Send Feedback',
                  icon: FontAwesomeIcons.comment,
                  color: AppColors.blueMood,
                  onTap: () {
                    // Navigate to feedback form
                  },
                ),
                const SizedBox(height: 12),
                _buildSettingsItem(
                  title: 'About Freud',
                  icon: FontAwesomeIcons.info,
                  color: AppColors.neutralColor,
                  onTap: () {
                    // Navigate to about screen
                  },
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'App Version',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.lightTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '2.4.1',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Sign out logic
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.cardBackground,
                            foregroundColor: AppColors.redMood,
                            side: BorderSide(color: AppColors.redMood),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsItem({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
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
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textColor,
                ),
              ),
            ),
            const Icon(
              FontAwesomeIcons.chevronRight,
              size: 16,
              color: AppColors.neutralColor,
            ),
          ],
        ),
      ),
    );
  }
}

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _breathingController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _breathingAnimation;
  bool _isPlaying = false;
  int _selectedDuration = 5; // in minutes
  int _selectedType = 0; // 0: Calm, 1: Focus, 2: Sleep

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  void _toggleBreathing() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      _breathingController.repeat(reverse: true);
    } else {
      _breathingController.stop();
      _breathingController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Breathing Exercise', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.solidBookmark, size: 20, color: AppColors.neutralColor),
            onPressed: () {
              // Save meditation
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breathing Animation
                Container(
                  width: double.infinity,
                  height: 300,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryGreen, AppColors.darkGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withValues(alpha: 0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _breathingAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _breathingAnimation.value,
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  _isPlaying ? (_breathingController.status == AnimationStatus.forward ? 'Breathe In' : 'Breathe Out') : 'Ready',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '$_selectedDuration min • ${_getTypeName()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Play/Pause Button
                Center(
                  child: GestureDetector(
                    onTap: _toggleBreathing,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: _isPlaying ? AppColors.redMood : AppColors.primaryGreen,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (_isPlaying ? AppColors.redMood : AppColors.primaryGreen).withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Duration',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildDurationButton(1),
                    _buildDurationButton(3),
                    _buildDurationButton(5),
                    _buildDurationButton(10),
                    _buildDurationButton(15),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Type',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTypeButton(0, 'Calm', AppColors.blueMood),
                    _buildTypeButton(1, 'Focus', AppColors.yellowMood),
                    _buildTypeButton(2, 'Sleep', AppColors.purpleMood),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Benefits',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 16),
                _buildBenefitCard(
                  title: 'Reduces Stress',
                  description: 'Deep breathing activates the parasympathetic nervous system, which helps reduce stress hormones.',
                  icon: FontAwesomeIcons.brain,
                  color: AppColors.primaryGreen,
                ),
                const SizedBox(height: 12),
                _buildBenefitCard(
                  title: 'Improves Focus',
                  description: 'Regular breathing exercises can improve concentration and cognitive function.',
                  icon: FontAwesomeIcons.eye,
                  color: AppColors.blueMood,
                ),
                const SizedBox(height: 12),
                _buildBenefitCard(
                  title: 'Better Sleep',
                  description: 'Breathing techniques help relax the mind and body, promoting better sleep quality.',
                  icon: FontAwesomeIcons.moon,
                  color: AppColors.purpleMood,
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pro Tip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Try to practice breathing exercises at the same time each day to build a consistent habit.',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGreen,
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
    );
  }

  String _getTypeName() {
    switch (_selectedType) {
      case 0:
        return 'Calm';
      case 1:
        return 'Focus';
      case 2:
        return 'Sleep';
      default:
        return 'Calm';
    }
  }

  Widget _buildDurationButton(int minutes) {
    bool isSelected = _selectedDuration == minutes;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDuration = minutes;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryGreen : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryGreen.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Center(
          child: Text(
            '$minutes min',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeButton(int type, String label, Color color) {
    bool isSelected = _selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenefitCard({
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
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
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightTextColor,
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