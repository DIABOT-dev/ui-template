import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';



class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  ActivityScreenState createState() => ActivityScreenState();
}

class ActivityScreenState extends State<ActivityScreen> {
  int _alphaFromOpacity(double opacity) {
    return (255 * opacity).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0, // Hide default AppBar
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Icon(Icons.notifications_none_outlined, size: 30),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Your Activities',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDateCard('Mon', '21', false),
                  _buildDateCard('Tu', '22', true),
                  _buildDateCard('Wed', '23', false),
                  _buildDateCard('Thu', '24', false),
                  _buildDateCard('Fri', '25', false),
                  _buildDateCard('Sat', '26', false),
                  _buildDateCard('Sun', '27', false),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: _buildActivityCard(
                      icon: FontAwesomeIcons.bed,
                      title: 'Sleeping Time',
                      value: '8h 34m',
                      color: Color(0xFFFC81E0),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildActivityCard(
                      icon: FontAwesomeIcons.faceSmileBeam,
                      title: 'Mood Level',
                      value: '8/10',
                      color: Color(0xFF81D4FA),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildActivityCard(
                      icon: FontAwesomeIcons.personRunning,
                      title: 'Activity',
                      value: '2h 15m',
                      color: Color(0xFFFFD54F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Physical state',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPhysicalStateItem(
                          color: Color(0xFFFC81E0),
                          label: 'Sleep Goal',
                          value: '8h Target',
                        ),
                        SizedBox(height: 15),
                        _buildPhysicalStateItem(
                          color: Color(0xFF81D4FA),
                          label: 'Last night',
                          value: '7.5h Achieved',
                        ),
                        SizedBox(height: 15),
                        _buildPhysicalStateItem(
                          color: Color(0xFFFFD54F),
                          label: 'Deficit',
                          value: '1.5 Missing',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: PieChart(
                      PieChartData(
                        sections: [
                          PieChartSectionData(
                            color: Color(0xFFFC81E0),
                            value: 7.5,
                            title: '',
                            radius: 25,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: Color(0xFFFFD54F),
                            value: 1.5,
                            title: '',
                            radius: 25,
                            showTitle: false,
                          ),
                          PieChartSectionData(
                            color: Colors.grey.withAlpha(_alphaFromOpacity(0.2)),
                            value: 0.5,
                            title: '',
                            radius: 25,
                            showTitle: false,
                          ),
                        ],
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        borderData: FlBorderData(show: false),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '78%',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Health Trends',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.transparent,
                          strokeWidth: 0,
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: Colors.transparent,
                          strokeWidth: 0,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text('Mon', style: TextStyle(color: Colors.grey));
                              case 1:
                                return Text('Tue', style: TextStyle(color: Colors.grey));
                              case 2:
                                return Text('Wed', style: TextStyle(color: Colors.grey));
                              case 3:
                                return Text('Thu', style: TextStyle(color: Colors.grey));
                              case 4:
                                return Text('Fri', style: TextStyle(color: Colors.grey));
                              case 5:
                                return Text('Sat', style: TextStyle(color: Colors.grey));
                              case 6:
                                return Text('Sun', style: TextStyle(color: Colors.grey));
                            }
                            return Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString(), style: TextStyle(color: Colors.grey));
                          },
                          reservedSize: 28,
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 5),
                          FlSpot(1, 6),
                          FlSpot(2, 7.5),
                          FlSpot(3, 7),
                          FlSpot(4, 6.5),
                          FlSpot(5, 8),
                          FlSpot(6, 7.2),
                        ],
                        isCurved: true,
                        color: Color(0xFFFC81E0),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Color(0xFFFC81E0).withAlpha(_alphaFromOpacity(0.3)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Today\'s Focus',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildFocusItem(
                      icon: FontAwesomeIcons.personRunning,
                      title: 'Morning Jog',
                      time: '6:00 AM - 6:45 AM',
                      color: Color(0xFF81D4FA),
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildFocusItem(
                      icon: FontAwesomeIcons.utensils,
                      title: 'Healthy Breakfast',
                      time: '7:00 AM - 7:30 AM',
                      color: Color(0xFFFFD54F),
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildFocusItem(
                      icon: FontAwesomeIcons.bookOpen,
                      title: 'Read for 30 mins',
                      time: '9:00 PM - 9:30 PM',
                      color: Color(0xFFFC81E0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Weekly Goals',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildGoalItem('Complete 3 workouts', 0.8),
                    SizedBox(height: 15),
                    _buildGoalItem('Drink 2L water daily', 0.6),
                    SizedBox(height: 15),
                    _buildGoalItem('Meditate 5 times', 0.9),
                  ],
                ),
              ),
              SizedBox(height: 30),

              // Navigation buttons to other screens
              Row(
                children: [
                  Expanded(
                    child: _buildNavigationCard(
                      title: 'View Profile',
                      icon: FontAwesomeIcons.user,
                      color: Color(0xFF81D4FA),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfileScreen()),
                        );
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildNavigationCard(
                      title: 'Statistics',
                      icon: FontAwesomeIcons.chartLine,
                      color: Color(0xFFFFD54F),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StatisticsScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateCard(String day, String date, bool isSelected) {
    return Container(
      width: 45,
      height: 70,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFFC81E0).withValues(alpha: 0.15) : Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: isSelected ? Border.all(color: Color(0xFFFC81E0), width: 2) : null,
        boxShadow: isSelected
            ? [
          BoxShadow(
            color: Color(0xFFFC81E0).withAlpha(_alphaFromOpacity(0.2)),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isSelected ? Color(0xFFFC81E0) : Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          Text(
            date,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Color(0xFFFC81E0) : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(_alphaFromOpacity(0.1)),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 15),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhysicalStateItem({
    required Color color,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 25,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFocusItem({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 25),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Icon(FontAwesomeIcons.chevronRight, size: 20, color: Colors.grey),
      ],
    );
  }

  Widget _buildGoalItem(String text, double progress) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.withAlpha(_alphaFromOpacity(0.2)),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF81D4FA)),
                minHeight: 8,
                borderRadius: BorderRadius.circular(5),
              ),
            ],
          ),
        ),
        SizedBox(width: 15),
        Text(
          '${(progress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF81D4FA),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationCard({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(_alphaFromOpacity(0.1)),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  int _alphaFromOpacity(double opacity) {
    return (255 * opacity).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0, // Hide default AppBar
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.arrowLeft, size: 24),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'My Profile',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.gear, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Health Enthusiast',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildStatCard('125', 'Activities'),
                        SizedBox(width: 20),
                        _buildStatCard('42', 'Achievements'),
                        SizedBox(width: 20),
                        _buildStatCard('28', 'Streak'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildProfileItem(
                      icon: FontAwesomeIcons.user,
                      title: 'Full Name',
                      value: 'John Doe',
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildProfileItem(
                      icon: FontAwesomeIcons.envelope,
                      title: 'Email',
                      value: 'john.doe@example.com',
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildProfileItem(
                      icon: FontAwesomeIcons.phone,
                      title: 'Phone',
                      value: '+1 (555) 123-4567',
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildProfileItem(
                      icon: FontAwesomeIcons.cakeCandles,
                      title: 'Birthday',
                      value: 'Jan 15, 1990',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Achievements',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildAchievementCard(
                      icon: FontAwesomeIcons.trophy,
                      title: '7-Day Streak',
                      color: Color(0xFFFFD54F),
                    ),
                    SizedBox(width: 15),
                    _buildAchievementCard(
                      icon: FontAwesomeIcons.medal,
                      title: 'Early Bird',
                      color: Color(0xFF81D4FA),
                    ),
                    SizedBox(width: 15),
                    _buildAchievementCard(
                      icon: FontAwesomeIcons.star,
                      title: 'Top Performer',
                      color: Color(0xFFFC81E0),
                    ),
                    SizedBox(width: 15),
                    _buildAchievementCard(
                      icon: FontAwesomeIcons.fire,
                      title: 'Calorie Burner',
                      color: Color(0xFFA5D6A7),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFC81E0),
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFC81E0).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: Color(0xFFFC81E0), size: 20),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Container(
      width: 120,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(_alphaFromOpacity(0.1)),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  StatisticsScreenState createState() => StatisticsScreenState();
}

class StatisticsScreenState extends State<StatisticsScreen> {
  int _alphaFromOpacity(double opacity) {
    return (255 * opacity).round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0, // Hide default AppBar
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.arrowLeft, size: 24),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.download, size: 24),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Weekly Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text('Mon', style: TextStyle(color: Colors.grey));
                              case 1:
                                return Text('Tue', style: TextStyle(color: Colors.grey));
                              case 2:
                                return Text('Wed', style: TextStyle(color: Colors.grey));
                              case 3:
                                return Text('Thu', style: TextStyle(color: Colors.grey));
                              case 4:
                                return Text('Fri', style: TextStyle(color: Colors.grey));
                              case 5:
                                return Text('Sat', style: TextStyle(color: Colors.grey));
                              case 6:
                                return Text('Sun', style: TextStyle(color: Colors.grey));
                            }
                            return Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 2,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString(), style: TextStyle(color: Colors.grey));
                          },
                          reservedSize: 28,
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: 5,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: 7,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: 4,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 3,
                        barRods: [
                          BarChartRodData(
                            toY: 8,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 4,
                        barRods: [
                          BarChartRodData(
                            toY: 6,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 5,
                        barRods: [
                          BarChartRodData(
                            toY: 9,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 6,
                        barRods: [
                          BarChartRodData(
                            toY: 7,
                            color: Color(0xFFFC81E0),
                            width: 16,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Activity Breakdown',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildActivityBreakdownCard(
                      title: 'Sleep',
                      value: '56h',
                      percentage: 80,
                      color: Color(0xFFFC81E0),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildActivityBreakdownCard(
                      title: 'Exercise',
                      value: '12h',
                      percentage: 65,
                      color: Color(0xFF81D4FA),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: _buildActivityBreakdownCard(
                      title: 'Meditation',
                      value: '5h',
                      percentage: 45,
                      color: Color(0xFFFFD54F),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Monthly Progress',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.transparent,
                          strokeWidth: 0,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 22,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text('W1', style: TextStyle(color: Colors.grey));
                              case 1:
                                return Text('W2', style: TextStyle(color: Colors.grey));
                              case 2:
                                return Text('W3', style: TextStyle(color: Colors.grey));
                              case 3:
                                return Text('W4', style: TextStyle(color: Colors.grey));
                            }
                            return Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          getTitlesWidget: (value, meta) {
                            return Text(value.toInt().toString(), style: TextStyle(color: Colors.grey));
                          },
                          reservedSize: 28,
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    minX: 0,
                    maxX: 3,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 30),
                          FlSpot(1, 50),
                          FlSpot(2, 75),
                          FlSpot(3, 85),
                        ],
                        isCurved: true,
                        color: Color(0xFF81D4FA),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Color(0xFF81D4FA).withAlpha(_alphaFromOpacity(0.3)),
                        ),
                      ),
                      LineChartBarData(
                        spots: [
                          FlSpot(0, 20),
                          FlSpot(1, 35),
                          FlSpot(2, 60),
                          FlSpot(3, 70),
                        ],
                        isCurved: true,
                        color: Color(0xFFFFD54F),
                        barWidth: 4,
                        isStrokeCapRound: true,
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Color(0xFFFFD54F).withAlpha(_alphaFromOpacity(0.3)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Health Metrics',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withAlpha(_alphaFromOpacity(0.1)),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMetricItem(
                      title: 'Heart Rate',
                      value: '72 bpm',
                      status: 'Normal',
                      color: Color(0xFF81D4FA),
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildMetricItem(
                      title: 'Blood Pressure',
                      value: '120/80',
                      status: 'Optimal',
                      color: Color(0xFFA5D6A7),
                    ),
                    Divider(height: 30, color: Colors.grey.withAlpha(_alphaFromOpacity(0.2))),
                    _buildMetricItem(
                      title: 'Calories Burned',
                      value: '2,450',
                      status: 'Good',
                      color: Color(0xFFFFD54F),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityBreakdownCard({
    required String title,
    required String value,
    required int percentage,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(_alphaFromOpacity(0.1)),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.withAlpha(_alphaFromOpacity(0.2)),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
            borderRadius: BorderRadius.circular(5),
          ),
          SizedBox(height: 5),
          Text(
            '$percentage%',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required String title,
    required String value,
    required String status,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            FontAwesomeIcons.heartPulse,
            color: color,
            size: 20,
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}