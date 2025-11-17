import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

// Helper to convert opacity to an alpha value
int alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}

// Placeholder for your asset images
class AppAssets {
  static const String personAvatar = 'assets/images/avatar.png';
  static const String notificationIcon = 'assets/images/notification.png';
}

// Main Sleep Module Screen
class SleepModuleScreen extends StatelessWidget {
  const SleepModuleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleep Tracker'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Sleep Tracking',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Monitor your sleep patterns and get insights to improve your sleep quality.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 40),
            _buildNavigationCard(
              context,
              title: 'Sleep Level',
              subtitle: 'View your daily sleep score and metrics',
              icon: FontAwesomeIcons.moon,
              color: Colors.indigo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepLevelScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            _buildNavigationCard(
              context,
              title: 'Sleep Insights',
              subtitle: 'Analyze your sleep patterns and stages',
              icon: FontAwesomeIcons.chartLine,
              color: Colors.teal,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepInsightsScreen()),
                );
              },
            ),
            SizedBox(height: 10),
            _buildNavigationCard(
              context,
              title: 'Sleep Summary',
              subtitle: 'View your sleep history and trends',
              icon: FontAwesomeIcons.clockRotateLeft,
              color: Colors.purple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SleepSummaryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
      BuildContext context, {
        required String title,
        required String subtitle,
        required IconData icon,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 28,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sleep Level Screen
class SleepLevelScreen extends StatefulWidget {
  const SleepLevelScreen({super.key});

  @override
  SleepLevelScreenState createState() => SleepLevelScreenState();
}

class SleepLevelScreenState extends State<SleepLevelScreen> {
  final List<Map<String, dynamic>> dailySleepStatus = [
    {'day': 'M', 'status': 'good', 'score': 85},
    {'day': 'T', 'status': 'good', 'score': 78},
    {'day': 'W', 'status': 'good', 'score': 92},
    {'day': 'T', 'status': 'bad', 'score': 60},
    {'day': 'F', 'status': 'good', 'score': 88},
    {'day': 'S', 'status': 'bad', 'score': 55},
    {'day': 'S', 'status': 'good', 'score': 70},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sleep Level',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: Colors.grey[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Thursday',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'October 24, 2026',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24),

              // Daily Status Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: dailySleepStatus.map((dayData) {
                  return _buildDayStatus(dayData['day'], dayData['status'] == 'good');
                }).toList(),
              ),
              SizedBox(height: 32),

              // Sleep Score Indicator
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator(
                        value: 75 / 100,
                        strokeWidth: 25,
                        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.orange.shade700),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '75',
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0, bottom: 20.0),
                                  child: Icon(
                                    FontAwesomeIcons.handPointer,
                                    size: 30,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Out of 100',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),

              // Sleep Metrics
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetricCard(FontAwesomeIcons.solidMoon, 'Time Asleep', '8h 30m'),
                  _buildMetricCard(FontAwesomeIcons.cloudMoon, 'Sleep Quality', 'Good'),
                  _buildMetricCard(FontAwesomeIcons.heartPulse, 'Heart Rate', '60 bpm'),
                ],
              ),
              SizedBox(height: 24),

              // Sleep Stages
              Text(
                'Sleep Stages',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'FLChart Integration for Sleep Stages Goes Here',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDayStatus(String day, bool isGood) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: isGood ? Colors.orange.shade700 : Colors.red,
          width: 2,
        ),
      ),
      child: Center(
        child: isGood
            ? Text(
          day,
          style: TextStyle(
            color: Colors.orange.shade700,
            fontWeight: FontWeight.bold,
          ),
        )
            : Icon(
          Icons.close,
          color: Colors.red,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildMetricCard(IconData icon, String title, String value) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Column(
            children: [
              Icon(icon, color: Colors.indigo.shade400, size: 28),
              SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Sleep Insights Screen
class SleepInsightsScreen extends StatefulWidget {
  const SleepInsightsScreen({super.key});

  @override
  SleepInsightsScreenState createState() => SleepInsightsScreenState();
}

class SleepInsightsScreenState extends State<SleepInsightsScreen> {
  final List<Map<String, dynamic>> sleepStagesData = [
    {'start': 11.0, 'end': 12.3, 'type': 'Core', 'color': Color(0xFF8BC34A)},
    {'start': 12.3, 'end': 13.0, 'type': 'REM', 'color': Color(0xFF795548)},
    {'start': 13.0, 'end': 13.4, 'type': 'Post-REM', 'color': Color(0xFFFFC107)},
    {'start': 13.4, 'end': 14.1, 'type': 'Core', 'color': Color(0xFF8BC34A)},
    {'start': 14.1, 'end': 14.5, 'type': 'REM', 'color': Color(0xFF795548)},
    {'start': 14.5, 'end': 15.0, 'type': 'Post-REM', 'color': Color(0xFF9C27B0)},
  ];

  String selectedPeriod = 'Today';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sleep Insights',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Segmented Control
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(alphaFromOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['Today', '1 Week', '1 Month', '1 Year', 'All']
                      .map((period) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeriod = period;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: selectedPeriod == period
                              ? Color(0xFF8BC34A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(
                            color: selectedPeriod == period ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
              SizedBox(height: 24),

              // Sleep Irregularity Chart
              Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 5.0,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            interval: 1.0,
                            getTitlesWidget: (value, meta) {
                              String time = '';
                              switch (value.toInt()) {
                                case 0:
                                  time = '11:00';
                                  break;
                                case 1:
                                  time = '12:00';
                                  break;
                                case 2:
                                  time = '13:00';
                                  break;
                                case 3:
                                  time = '14:00';
                                  break;
                                case 4:
                                  time = '15:00';
                                  break;
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 4,
                                child: Text(
                                  time,
                                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: _getBarGroups(),
                    )

                ),
              ),
              SizedBox(height: 16),
              // Chart Legends
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLegendItem(Color(0xFF8BC34A), 'Core'),
                    _buildLegendItem(Color(0xFF795548), 'REM'),
                    _buildLegendItem(Color(0xFFFFC107), 'Post-REM'),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Text(
                'AI Suggestions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),

              // AI Suggestion Cards
              _buildSuggestionCard(
                icon: FontAwesomeIcons.volumeHigh,
                iconColor: Colors.brown.shade400,
                title: 'Loud Snoring',
                subtitle: 'Loud snoring at 03:00 AM',
                cardColor: Colors.brown.shade50,
              ),
              SizedBox(height: 16),
              _buildSuggestionCard(
                icon: FontAwesomeIcons.bed,
                iconColor: Colors.deepOrange.shade400,
                title: 'Pillow Improvement',
                subtitle: 'Change your pillows',
                cardColor: Colors.deepOrange.shade50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    barGroups.add(
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(toY: 3.5, color: Color(0xFF8BC34A), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: 2.5, color: Color(0xFF8BC34A), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(toY: 3.0, color: Color(0xFFFFC107), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(toY: 2.8, color: Color(0xFF795548), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(toY: 1.5, color: Color(0xFF9C27B0), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    return barGroups;
  }

  Widget _buildLegendItem(Color color, String label) {
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
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color cardColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(alphaFromOpacity(0.2)),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}

// Sleep Summary Screen
class SleepSummaryScreen extends StatefulWidget {
  const SleepSummaryScreen({super.key});

  @override
  SleepSummaryScreenState createState() => SleepSummaryScreenState();
}

class SleepSummaryScreenState extends State<SleepSummaryScreen> {
  String selectedPeriod = '1 Week';

  final List<Map<String, dynamic>> sleepStagesData = [
    {'start': 11.0, 'end': 12.3, 'type': 'Core', 'color': Color(0xFF8BC34A)},
    {'start': 12.3, 'end': 13.0, 'type': 'REM', 'color': Color(0xFF795548)},
    {'start': 13.0, 'end': 13.4, 'type': 'Post-REM', 'color': Color(0xFFFFC107)},
    {'start': 13.4, 'end': 14.1, 'type': 'Core', 'color': Color(0xFF8BC34A)},
    {'start': 14.1, 'end': 14.5, 'type': 'REM', 'color': Color(0xFF795548)},
    {'start': 14.5, 'end': 15.0, 'type': 'Post-REM', 'color': Color(0xFF9C27B0)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Sleep Summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Segmented Control
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(alphaFromOpacity(0.1)),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: ['1 Day', '1 Week', '1 Month', '1 Year', 'All Time']
                      .map((period) => Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeriod = period;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                          color: selectedPeriod == period
                              ? Color(0xFF8BC34A)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          period,
                          style: TextStyle(
                            color: selectedPeriod == period ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ))
                      .toList(),
                ),
              ),
              SizedBox(height: 24),

              // Sleep Irregularity Chart
              Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      maxY: 5.0,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 22,
                            interval: 1.0,
                            getTitlesWidget: (value, meta) {
                              String time = '';
                              if (value == 0) {
                                time = '11:00';
                              } else if (value == 1) {
                                time = '12:00';
                              } else if (value == 2) {
                                time = '13:00';
                              } else if (value == 3) {
                                time = '14:00';
                              } else if (value == 4) {
                                time = '15:00';
                              }


                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 4,
                                child: Text(
                                  time,
                                  style: TextStyle(color: Colors.grey[600], fontSize: 10),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      gridData: FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      barGroups: _getBarGroups(),
                    )

                ),
              ),
              SizedBox(height: 16),
              // Chart Legends
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLegendItem(Color(0xFF8BC34A), 'Core'),
                    _buildLegendItem(Color(0xFF795548), 'REM'),
                    _buildLegendItem(Color(0xFFFFC107), 'Post-REM'),
                  ],
                ),
              ),
              SizedBox(height: 24),

              Text(
                'AI Suggestions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),

              // AI Suggestion Cards
              _buildSuggestionCard(
                icon: FontAwesomeIcons.mobileScreenButton,
                iconColor: Colors.purple.shade400,
                title: 'Limit Exposure to Screens',
                subtitle: 'Control your snoring!',
                cardColor: Colors.purple.shade50,
              ),
              SizedBox(height: 16),
              _buildSuggestionCard(
                icon: FontAwesomeIcons.bed,
                iconColor: Colors.deepOrange.shade400,
                title: 'Pillow Improvement',
                subtitle: 'Change your pillows',
                cardColor: Colors.deepOrange.shade50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups() {
    List<BarChartGroupData> barGroups = [];
    barGroups.add(
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(toY: 3.5, color: Color(0xFF8BC34A), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(toY: 2.5, color: Color(0xFF8BC34A), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(toY: 3.0, color: Color(0xFFFFC107), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(toY: 2.8, color: Color(0xFF795548), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    barGroups.add(
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(toY: 1.5, color: Color(0xFF9C27B0), width: 20, borderRadius: BorderRadius.circular(5)),
        ],
      ),
    );
    return barGroups;
  }

  Widget _buildLegendItem(Color color, String label) {
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
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color cardColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0,
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withAlpha(alphaFromOpacity(0.2)),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}