import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

// --- Colors and Constants ---

const Color kPrimaryOrange = Color(0xFFFF8C4D); // Elevated/Action Color
const Color kDarkBrown = Color(
  0xFF5D4037,
); // Primary Text/Dark Background Color
const Color kModerateGreen = Color(0xFF8BC34A); // Moderate/Success Color
const Color kLightBeige = Color(0xFFFBFBF5); // Main Background Color
const Color kCardWhite = Colors.white; // Card Background Color

final List<String> kStressors = [
  'Work',
  'Home',
  'Relationship',
  'Kids',
  'Money',
  'Loneliness',
  'Others',
];

// Helper to convert opacity (0.0 to 1.0) to alpha (0 to 255)
int _alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}

// Helper for navigation
void pushScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}

// Global button widget for re-use (Continue/Next)
Widget _buildContinueButton(
  BuildContext context,
  Color bgColor,
  Color textColor,
  VoidCallback onPressed,
) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      padding: const EdgeInsets.symmetric(vertical: 18),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Continue',
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 10),
        Icon(Icons.arrow_right_alt, color: textColor, size: 24),
      ],
    ),
  );
}

// --- Enums ---

enum StressLevel { calm, normal, moderate, elevated, severe, extreme }

enum ImpactLevel { verylow, low, medium, high, veryhigh }






class StressLevelScreen extends StatelessWidget {
  const StressLevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBeige,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildTopOrangeSection(context),
            _buildStatsSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopOrangeSection(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.45,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            kPrimaryOrange,
            const Color(0xFFFF7043),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative pattern
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          // App bar
          Positioned(
            top: 50,
            left: 10,
            right: 10,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: kCardWhite),
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const Expanded(
                  child: Text('Stress Level',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kCardWhite,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5)),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: kCardWhite),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stress level display
          Positioned(
            top: screenHeight * 0.15,
            left: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '3',
                      style: TextStyle(
                        color: kCardWhite,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        height: 1,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        '/10',
                        style: TextStyle(
                          color: kCardWhite.withValues(alpha: 0.8),
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Elevated Stress',
                    style: TextStyle(
                        color: kCardWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5),
                  ),
                ),
              ],
            ),
          ),

          // Stats card
          Positioned(
            bottom: 0,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                color: kCardWhite,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Stress Stats',
                        style: TextStyle(
                            color: kDarkBrown,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => pushScreen(
                          context, const StressLevelStatsScreen()),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: kPrimaryOrange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text('See All',
                            style: TextStyle(
                              color: kPrimaryOrange,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Your Stress Analysis'),
          const SizedBox(height: 7),
          _buildChartCard(
            title: 'Stressor',
            data: {
              'Loneliness': kPrimaryOrange,
              'Work': kModerateGreen,
              'Finances': const Color(0xFF9C27B0),
              'Health': const Color(0xFF2196F3),
            },
            gradientColors: [
              kPrimaryOrange.withAlpha(_alphaFromOpacity(0.1)),
              kModerateGreen.withAlpha(_alphaFromOpacity(0.1)),
              const Color(0xFF9C27B0).withAlpha(_alphaFromOpacity(0.1)),
              const Color(0xFF2196F3).withAlpha(_alphaFromOpacity(0.1)),
            ],
            icon: FontAwesomeIcons.heart,
            chartType: 'pie',
          ),
          const SizedBox(height: 25),
          _buildChartCard(
            title: 'Impact',
            data: {
              'Very High': kPrimaryOrange,
              'High': kModerateGreen,
              'Medium': const Color(0xFF9C27B0),
              'Low': const Color(0xFF2196F3),
            },
            gradientColors: [
              kPrimaryOrange.withAlpha(_alphaFromOpacity(0.1)),
              kModerateGreen.withAlpha(_alphaFromOpacity(0.1)),
              const Color(0xFF9C27B0).withAlpha(_alphaFromOpacity(0.1)),
              const Color(0xFF2196F3).withAlpha(_alphaFromOpacity(0.1)),
            ],
            icon: FontAwesomeIcons.fire,
            chartType: 'bar',
          ),
          const SizedBox(height: 40),
          Center(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    kPrimaryOrange,
                    const Color(0xFFFF7043),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: kPrimaryOrange.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => pushScreen(
                      context, const StressLevelSelectorScreen()),
                  borderRadius: BorderRadius.circular(30),
                  splashColor: Colors.white.withValues(alpha: 0.3),
                  highlightColor: Colors.white.withValues(alpha: 0.2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(FontAwesomeIcons.solidHeart,
                            color: kCardWhite, size: 20),
                        const SizedBox(width: 12),
                        const Text('Assess Stress',
                            style: TextStyle(
                                color: kCardWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: kDarkBrown.withValues(alpha: 0.8),
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildChartCard({
    required String title,
    required Map<String, Color> data,
    required List<Color> gradientColors,
    required IconData icon,
    required String chartType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: kCardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: kPrimaryOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: kPrimaryOrange,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: kDarkBrown,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Chart visualization
            SizedBox(
              height: 180,
              child: chartType == 'pie'
                  ? _buildPieChart(data)
                  : _buildBarChart(data),
            ),
            const SizedBox(height: 15),
            // Legend items
            Wrap(
              spacing: 15,
              runSpacing: 8,
              children: data.entries.map((entry) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: entry.value,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      entry.key,
                      style: TextStyle(
                        color: kDarkBrown.withValues(alpha: 0.7),
                        fontSize: 14,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(Map<String, Color> data) {
    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: data.entries.map((entry) {
          final _ = data.keys.toList().indexOf(entry.key);
          return PieChartSectionData(
            color: entry.value,
            value: 25, // Equal distribution for demo
            title: '',
            radius: 60,
            titleStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kCardWhite,
            ),
            badgeWidget: Badge(
              entry.key,
              entry.value,
              size: 40,
            ),
            badgePositionPercentageOffset: .98,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBarChart(Map<String, Color> data) {
    return BarChart(
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
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < data.keys.length) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 8,
                    child: Text(
                      data.keys.elementAt(index),
                      style: TextStyle(
                        color: kDarkBrown.withValues(alpha: 0.7),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return const Text('');
              },
              reservedSize: 38,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: kDarkBrown.withValues(alpha: 0.7),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: kLightBeige.withValues(alpha: 0.5),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        barGroups: data.entries.map((entry) {
          final index = data.keys.toList().indexOf(entry.key);
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: 3 + index * 1.5, // Sample values
                color: entry.value,
                width: 22,
                borderRadius: BorderRadius.circular(4),
                backDrawRodData: BackgroundBarChartRodData(
                  show: true,
                  toY: 8,
                  color: entry.value.withValues(alpha: 0.1),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  int _alphaFromOpacity(double opacity) {
    return (255 * opacity).round();
  }
}

class Badge extends StatelessWidget {
  final String text;
  final Color color;
  final double size;

  const Badge(
      this.text,
      this.color, {super.key,
        required this.size,
      });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .1),
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: size * .3,
          ),
        ),
      ),
    );
  }
}

// --- Screen 2: Stress Level Selector Screen ---


class StressLevelSelectorScreen extends StatefulWidget {
  const StressLevelSelectorScreen({super.key});

  @override
  State<StressLevelSelectorScreen> createState() =>
      _StressLevelSelectorScreenState();
}

class _StressLevelSelectorScreenState extends State<StressLevelSelectorScreen>
    with TickerProviderStateMixin {
  double _currentLevel = 3.0;
  late AnimationController _animationController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
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

  String _getLevelText(double level) {
    if (level <= 1) return 'Calm';
    if (level <= 2) return 'Normal';
    if (level <= 3) return 'Moderate';
    if (level <= 4) return 'Elevated';
    if (level <= 5) return 'Severe';
    return 'Extreme';
  }

  Color _getLevelColor(double level) {
    if (level <= 1) return Colors.blue.shade300;
    if (level <= 2) return Colors.lightGreen.shade400;
    if (level <= 3) return Colors.green.shade500;
    if (level <= 4) return Colors.orange.shade400;
    if (level <= 5) return Colors.red.shade400;
    return Colors.red.shade700;
  }

  Widget _buildStressIndicator(double level) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Transform.scale(
          scale: 1.0 + (_pulseController.value * 0.05),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getLevelColor(level).withValues(alpha: 0.2),
              border: Border.all(
                color: _getLevelColor(level),
                width: 3,
              ),
              boxShadow: [
                BoxShadow(
                  color: _getLevelColor(level).withValues(alpha: 0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Text(
                level.round().toString(),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: _getLevelColor(level),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade400,
            Colors.deepPurple.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SelectStressorsScreen(),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo.shade50,
              Colors.purple.shade50,
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.grey.shade700),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "What's your stress level today?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Slide to indicate how you're feeling",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Expanded(
                      child: Column(
                        children: [
                          _buildStressIndicator(_currentLevel),
                          const SizedBox(height: 30),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: Text(
                              _getLevelText(_currentLevel),
                              key: ValueKey(_currentLevel),
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: _getLevelColor(_currentLevel),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Calm', style: TextStyle(color: Colors.blue.shade300)),
                                      Text('Normal', style: TextStyle(color: Colors.lightGreen.shade400)),
                                      Text('Moderate', style: TextStyle(color: Colors.green.shade500)),
                                      Text('Elevated', style: TextStyle(color: Colors.orange.shade400)),
                                      Text('Severe', style: TextStyle(color: Colors.red.shade400)),
                                      Text('Extreme', style: TextStyle(color: Colors.red.shade700)),
                                    ],
                                  ),
                                ),
                                SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                    trackHeight: 8,
                                    thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 14,
                                    ),
                                    overlayShape: const RoundSliderOverlayShape(
                                      overlayRadius: 24,
                                    ),
                                    activeTrackColor: _getLevelColor(_currentLevel),
                                    inactiveTrackColor: Colors.grey.shade200,
                                    thumbColor: _getLevelColor(_currentLevel),
                                    overlayColor: _getLevelColor(_currentLevel).withValues(alpha: 0.2),
                                  ),
                                  child: Slider(
                                    value: _currentLevel,
                                    min: 1,
                                    max: 6,
                                    divisions: 5,
                                    onChanged: (double value) {
                                      setState(() {
                                        _currentLevel = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildContinueButton(),
                    const SizedBox(height: 40),
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

// Placeholder for the next screen

// --- Screen 3: Select Stressors Screen ---

class SelectStressorsScreen extends StatefulWidget {
  const SelectStressorsScreen({super.key});

  @override
  State<SelectStressorsScreen> createState() => SelectStressorsScreenState();
}

class SelectStressorsScreenState extends State<SelectStressorsScreen> {
  String _selectedStressor = 'Loneliness';
  ImpactLevel _selectedImpact = ImpactLevel.veryhigh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBeige,
      appBar: AppBar(
        backgroundColor: kLightBeige,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDarkBrown),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select Stressors",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kDarkBrown,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Our AI will decide how your stressor will impact your life in general.",
              style: TextStyle(
                fontSize: 16,
                color: kDarkBrown.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(child: _buildStressorGrid()),
            _buildImpactSelector(),
            _buildContinueButton(context, kDarkBrown, kCardWhite, () {
              pushScreen(context, const RecordExpressionInstructionScreen());
            }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStressorGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: kStressors.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.0,
      ),
      itemBuilder: (context, index) {
        final stressor = kStressors[index];
        final isSelected = stressor == _selectedStressor;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedStressor = stressor;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? kModerateGreen : kCardWhite,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? kModerateGreen
                    : Colors.grey.withAlpha(_alphaFromOpacity(0.5)),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? kModerateGreen.withAlpha(_alphaFromOpacity(0.3))
                      : Colors.black.withAlpha(_alphaFromOpacity(0.05)),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                stressor,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? kCardWhite : kDarkBrown,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImpactSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                FontAwesomeIcons.solidHeart,
                color: kPrimaryOrange,
                size: 16,
              ),
              const SizedBox(width: 8),
              const Text(
                'Life impact',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kDarkBrown,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: ImpactLevel.values.map((level) {
              final String levelName = level.name
                  .replaceAll('very', 'Very ')
                  .replaceAll('low', 'Low')
                  .replaceAll('medium', 'Medium')
                  .replaceAll('high', 'High');
              final isSelected = level == _selectedImpact;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedImpact = level;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? kPrimaryOrange : kCardWhite,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? kPrimaryOrange
                          : Colors.grey.withAlpha(_alphaFromOpacity(0.5)),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? kPrimaryOrange.withAlpha(_alphaFromOpacity(0.3))
                            : Colors.black.withAlpha(_alphaFromOpacity(0.05)),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    levelName,
                    style: TextStyle(
                      color: isSelected ? kCardWhite : kDarkBrown,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// --- Screen 4: Record Expression Screen (Instructions) ---



class RecordExpressionInstructionScreen extends StatefulWidget {
  const RecordExpressionInstructionScreen({super.key});

  @override
  State<RecordExpressionInstructionScreen> createState() =>
      _RecordExpressionInstructionScreenState();
}

class _RecordExpressionInstructionScreenState
    extends State<RecordExpressionInstructionScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late List<AnimationController> _itemControllers;
  late List<Animation<double>> _itemAnimations;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.elasticOut),
    );

    // Initialize animations for instruction items
    _itemControllers = List.generate(
      4,
          (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    _itemAnimations = _itemControllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    ))
        .toList();

    // Start animations
    _fadeController.forward();
    _slideController.forward();

    // Stagger item animations
    for (int i = 0; i < _itemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: 300 + (i * 150)), () {
        if (mounted) _itemControllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBrown.withAlpha(_alphaFromOpacity(0.95)),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kCardWhite),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Record Expression",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: kCardWhite,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Let's train face expression to better stress AI analysis. Ensure the following:",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: kCardWhite.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionCard(
                      "Brightly Lit Room",
                      FontAwesomeIcons.lightbulb,
                      0,
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionCard(
                      "Clear Face Expression",
                      FontAwesomeIcons.faceGrinBeam,
                      1,
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionCard(
                      "Stay Still",
                      FontAwesomeIcons.circlePause,
                      2,
                    ),
                    const SizedBox(height: 8),
                    _buildInstructionCard(
                      "720p Camera",
                      FontAwesomeIcons.camera,
                      3,
                    ),
                    const SizedBox(height: 45),
                    _buildContinueButton(),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Skip This Step',
                        style: TextStyle(
                          color: kCardWhite,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
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

  Widget _buildInstructionCard(String text, IconData icon, int index) {
    return FadeTransition(
      opacity: _itemAnimations[index],
      child: Transform.translate(
        offset: Offset(0, 30 * (1 - _itemAnimations[index].value)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: kCardWhite.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: kCardWhite.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: kPrimaryOrange.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: kPrimaryOrange, size: 24),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    color: kCardWhite,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            kPrimaryOrange,
            Colors.orange.shade700,
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: kPrimaryOrange.withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecordExpressionCameraScreen(),
            ),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: const Text(
          'Continue',
          style: TextStyle(
            color: kCardWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// Placeholder for the next screen


// Helper function (assuming it exists elsewhere)



class RecordExpressionCameraScreen extends StatefulWidget {
  const RecordExpressionCameraScreen({super.key});

  @override
  State<RecordExpressionCameraScreen> createState() =>
      _RecordExpressionCameraScreenState();
}

class _RecordExpressionCameraScreenState
    extends State<RecordExpressionCameraScreen>
    with TickerProviderStateMixin {
  bool _isRecording = false;
  bool _flashOn = false;
  int _countdown = 3;
  bool _showCountdown = false;
  late AnimationController _pulseController;
  late AnimationController _countdownController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _countdownAnimation;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _countdownController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _countdownAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _countdownController,
        curve: Curves.elasticOut,
      ),
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _countdownController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    setState(() {
      _showCountdown = true;
      _countdown = 3;
    });

    _countdownController.forward().then((_) {
      _countdownController.reset();
    });

    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
        _countdownController.forward().then((_) {
          _countdownController.reset();
        });
      } else {
        timer.cancel();
        setState(() {
          _showCountdown = false;
          _isRecording = true;
        });

        // Simulate recording for 3 seconds
        Timer(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _isRecording = false;
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StressLevelSetScreen(),
              ),
            );
          }
        });
      }
    });
  }

  Color _getPlaceholderColor(int seed) {
    final random = Random(seed);
    return Color.fromRGBO(
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview with image from network
          SizedBox(
            width: size.width,
            height: size.height,
            child: Image.network(
              'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                // Fallback to placeholder if image fails to load
                return Container(
                  width: size.width,
                  height: size.height,
                  color: _getPlaceholderColor(42),
                  child: const Center(
                    child: Icon(Icons.person, size: 200, color: Colors.white70),
                  ),
                );
              },
            ),
          ),
          // Dark overlay for better contrast
          Container(color: Colors.black.withAlpha(_alphaFromOpacity(0.3))),

          // Top indicators
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIndicatorChip(
                  '68 bpm',
                  kModerateGreen,
                  FontAwesomeIcons.heartPulse,
                ),
                _buildIndicatorChip(
                  '134 cal',
                  Colors.purple.shade400,
                  FontAwesomeIcons.fire,
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: kCardWhite, size: 30),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Face guide circle
          Center(
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: size.width * 0.7,
                    height: size.width * 0.7,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white.withAlpha(_alphaFromOpacity(0.7)),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white.withAlpha(_alphaFromOpacity(0.4)),
                          width: 1,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Countdown overlay
          if (_showCountdown)
            Center(
              child: AnimatedBuilder(
                animation: _countdownAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _countdownAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: kPrimaryOrange.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '$_countdown',
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: kCardWhite,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

          // Recording indicator
          if (_isRecording)
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: kCardWhite,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'RECORDING',
                        style: TextStyle(
                          color: kCardWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Bottom controls
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade800,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Stay still for better AI analysis',
                    style: TextStyle(color: kCardWhite),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Flash toggle button
                    IconButton(
                      icon: Icon(
                        _flashOn
                            ? FontAwesomeIcons.solidLightbulb
                            : FontAwesomeIcons.lightbulb,
                        color: _flashOn ? kCardWhite : kCardWhite.withAlpha(_alphaFromOpacity(0.5)),
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _flashOn = !_flashOn;
                        });
                      },
                    ),

                    // Capture button
                    GestureDetector(
                      onTap: _startCountdown,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: kCardWhite,
                          shape: BoxShape.circle,
                          border: Border.all(color: kPrimaryOrange, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryOrange.withValues(alpha: 0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Container(
                            width: 65,
                            height: 65,
                            decoration: const BoxDecoration(
                              color: kPrimaryOrange,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Camera flip button
                    IconButton(
                      icon: Icon(
                        FontAwesomeIcons.rotate,
                        color: kCardWhite.withAlpha(_alphaFromOpacity(0.5)),
                        size: 30,
                      ),
                      onPressed: () {},
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

  Widget _buildIndicatorChip(String text, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kCardWhite.withAlpha(_alphaFromOpacity(0.2)),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 2),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 14),
          const SizedBox(width: 5),
          Text(text, style: const TextStyle(color: kCardWhite, fontSize: 14)),
        ],
      ),
    );
  }
}

// Placeholder for the next screen

// --- Screen 6: Stress Level Set Screen (Result) ---

class StressLevelSetScreen extends StatelessWidget {
  const StressLevelSetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBrown.withAlpha(_alphaFromOpacity(0.95)),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kCardWhite),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: kCardWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 150,
                        child: Icon(
                          FontAwesomeIcons.brain,
                          size: 150,
                          color: kPrimaryOrange,
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Stress Level Set to 3',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: kDarkBrown,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'Stress condition updated to your mental health journal. Data sent to Doctor Freud AI.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: kDarkBrown.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () => Navigator.popUntil(
                          context,
                          (route) => route.isFirst,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kModerateGreen,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 8,
                        ),
                        child: const Text(
                          'Got It, Thanks! ✓',
                          style: TextStyle(
                            color: kCardWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
}

// --- Screen 7: Stress Level Stats Screen ---

class StressLevelStatsScreen extends StatelessWidget {
  const StressLevelStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightBeige,
      appBar: AppBar(
        backgroundColor: kLightBeige,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kDarkBrown),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Stress Level Stats',
          style: TextStyle(color: kDarkBrown, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLegend(),
            const SizedBox(height: 20),
            _buildCircularStats(),
            const SizedBox(height: 30),
            _buildChartLegend(),
            _buildStatsChart(),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 15,
      children: [
        _buildLegendItem('Calm', Colors.blue.shade300),
        _buildLegendItem('Normal', kModerateGreen),
        _buildLegendItem('Elevated', kPrimaryOrange),
        _buildLegendItem('Severe', Colors.red.shade400),
        _buildLegendItem('Extreme', kDarkBrown),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(FontAwesomeIcons.solidCircle, color: color, size: 10),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: kDarkBrown.withValues(alpha: 0.7)),
        ),
      ],
    );
  }

  Widget _buildCircularStats() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCircle(
                '58',
                kPrimaryOrange,
                Colors.white.withValues(alpha: 0.3),
              ),
              _buildStatCircle(
                '97',
                kModerateGreen,
                Colors.white.withValues(alpha: 0.3),
              ),
              _buildStatCircle(
                '33',
                kDarkBrown.withValues(alpha: 0.5),
                Colors.white.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCircle(String value, Color color, Color bgColor) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withAlpha(_alphaFromOpacity(0.9)),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(_alphaFromOpacity(0.4)),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: kCardWhite,
          ),
        ),
      ),
    );
  }

  Widget _buildChartLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: kPrimaryOrange,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Monthly',
            style: TextStyle(color: kCardWhite, fontWeight: FontWeight.bold),
          ),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.arrow_drop_down, color: kDarkBrown),
          label: Text('Modify', style: TextStyle(color: kDarkBrown)),
        ),
      ],
    );
  }

  List<FlSpot> get _stressData => const [
    FlSpot(0, 50),
    FlSpot(1, 65),
    FlSpot(2, 45),
    FlSpot(3, 80),
    FlSpot(4, 55),
    FlSpot(5, 70),
    FlSpot(6, 60),
  ];

  List<FlSpot> get _bpmData => const [
    FlSpot(0, 60),
    FlSpot(1, 75),
    FlSpot(2, 68),
    FlSpot(3, 85),
    FlSpot(4, 70),
    FlSpot(5, 80),
    FlSpot(6, 72),
  ];

  List<FlSpot> get _caloriesData => const [
    FlSpot(0, 40),
    FlSpot(1, 55),
    FlSpot(2, 35),
    FlSpot(3, 70),
    FlSpot(4, 50),
    FlSpot(5, 65),
    FlSpot(6, 45),
  ];

  Widget _buildStatsChart() {
    return Card(
      margin: const EdgeInsets.only(top: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
        child: SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withAlpha(_alphaFromOpacity(0.15)),
                  strokeWidth: 1,
                ),
                drawVerticalLine: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: kDarkBrown,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      );
                      String text;
                      switch (value.toInt()) {
                        case 0:
                          text = 'Mon';
                          break;
                        case 1:
                          text = 'Tue';
                          break;
                        case 2:
                          text = 'Wed';
                          break;
                        case 3:
                          text = 'Thu';
                          break;
                        case 4:
                          text = 'Fri';
                          break;
                        case 5:
                          text = 'Sat';
                          break;
                        case 6:
                          text = 'Sun';
                          break;
                        default:
                          return Container();
                      }
                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 8.0,
                        child: Text(text, style: style),
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 25,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      const style = TextStyle(
                        color: kDarkBrown,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      );
                      return Text(
                        value.toInt().toString(),
                        style: style,
                        textAlign: TextAlign.left,
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey.withAlpha(_alphaFromOpacity(0.3)),
                    width: 1,
                  ),
                  left: const BorderSide(color: Colors.transparent),
                  right: const BorderSide(color: Colors.transparent),
                  top: const BorderSide(color: Colors.transparent),
                ),
              ),
              minX: 0,
              maxX: 6,
              minY: 0,
              maxY: 100,
              lineBarsData: [
                _buildLineBarData(_stressData, kPrimaryOrange),
                _buildLineBarData(_bpmData, kModerateGreen),
                _buildLineBarData(_caloriesData, kDarkBrown.withValues(alpha: 0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartBarData _buildLineBarData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
          radius: 4,
          color: color,
          strokeWidth: 2,
          strokeColor: kCardWhite,
        ),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            color.withAlpha(_alphaFromOpacity(0.3)),
            color.withAlpha(_alphaFromOpacity(0.0)),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
