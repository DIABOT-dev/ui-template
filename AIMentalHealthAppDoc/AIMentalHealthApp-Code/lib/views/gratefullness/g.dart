import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class GratefulnessScreen extends StatelessWidget {
  const GratefulnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Row(
          children: [
            BackButton(),

          ],
        ),
        title: Text(
          'Gratefulness',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _DateCircle(day: 'M', date: '20', isSelected: false),
                  _DateCircle(day: 'T', date: '21', isSelected: true),
                  _DateCircle(day: 'W', date: '22', isSelected: false),
                  _DateCircle(day: 'T', date: '23', isSelected: false),
                  _DateCircle(day: 'F', date: '24', isSelected: false),
                  _DateCircle(day: 'S', date: '25', isSelected: false),
                  _DateCircle(day: 'S', date: '26', isSelected: false),
                  _DateCircle(day: 'M', date: '27', isSelected: false),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Tuesday, Jun 21, 2026',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Text(
                'Today, I\'m grateful for\nthe sunshine.',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 500),
                      pageBuilder: (_, __, ___) => MoodTrackerScreen(),
                      transitionsBuilder: (_, animation, __, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Color(0xFF8D6E63),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF8D6E63).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 35,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gratitude History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          pageBuilder: (_, __, ___) => MeditationScreen(),
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
                    child: Text(
                      'Meditation',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8D6E63),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            _GratitudeHistoryCard(
              gratitudeText: 'I\'m grateful for the sunset',
              date: 'Jan 22',
            ),
            _GratitudeHistoryCard(
              gratitudeText: 'I\'m grateful for my family',
              date: 'Jan 21',
            ),
            _GratitudeHistoryCard(
              gratitudeText: 'I\'m grateful for the wind',
              date: 'Jan 25',
            ),
            _GratitudeHistoryCard(
              gratitudeText: 'I\'m grateful for the rain',
              date: 'Jan 24',
            ),
            _GratitudeHistoryCard(
              gratitudeText: 'I\'m grateful for my pet',
              date: 'Jan 23',
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _DateCircle extends StatelessWidget {
  final String day;
  final String date;
  final bool isSelected;

  const _DateCircle({
    required this.day,
    required this.date,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFFECE0D1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: isSelected ? Border.all(color: Color(0xFFC7B198), width: 1) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              color: isSelected ? Color(0xFF8D6E63) : Colors.grey[600],
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              color: isSelected ? Color(0xFF8D6E63) : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _GratitudeHistoryCard extends StatelessWidget {
  final String gratitudeText;
  final String date;

  const _GratitudeHistoryCard({
    required this.gratitudeText,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(
              FontAwesomeIcons.solidHandshake,
              color: Color(0xFF8D6E63),
              size: 20,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Text(
                gratitudeText,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              date,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  MoodTrackerScreenState createState() => MoodTrackerScreenState();
}

class MoodTrackerScreenState extends State<MoodTrackerScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _selectedMood = 2;
  final List<String> _moodTypes = ['Very Sad', 'Sad', 'Neutral', 'Happy', 'Very Happy'];
  final List<Color> _moodColors = [
    Color(0xFF3F51B5),
    Color(0xFF2196F3),
    Color(0xFF8BC34A),
    Color(0xFFCDDC39),
    Color(0xFFFFEB3B),
  ];
  final List<IconData> _moodIcons = [
    FontAwesomeIcons.faceSadTear,
    FontAwesomeIcons.faceFrown,
    FontAwesomeIcons.faceMeh,
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceGrinStars,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
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
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Mood Tracker',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'How are you feeling today?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMood = index;
                        _animationController.reset();
                        _animationController.forward();
                      });
                    },
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 300),
                      scale: _selectedMood == index ? 1.2 : 1.0,
                      child: Column(
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _selectedMood == index
                                  ? _moodColors[index].withValues(alpha: 0.2)
                                  : Colors.grey.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: _selectedMood == index
                                    ? _moodColors[index]
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              _moodIcons[index],
                              color: _moodColors[index],
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _moodTypes[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedMood == index
                                  ? _moodColors[index]
                                  : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'What\'s affecting your mood?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  moodfactorchip('Work', FontAwesomeIcons.briefcase),
                  moodfactorchip('Family', FontAwesomeIcons.house),
                  moodfactorchip('Health', FontAwesomeIcons.heartPulse),
                  moodfactorchip('Relationships', FontAwesomeIcons.heart),
                  moodfactorchip('Finance', FontAwesomeIcons.moneyBillWave),
                  moodfactorchip('Sleep', FontAwesomeIcons.bed),
                  moodfactorchip('Exercise', FontAwesomeIcons.dumbbell),
                  moodfactorchip('Social', FontAwesomeIcons.users),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Add a note (optional)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'What\'s on your mind?',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.grey.withValues(alpha: 0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xFF8D6E63),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF8D6E63).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(15),
                    onTap: () {
                      // Save mood data
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Mood saved successfully!'),
                          backgroundColor: Color(0xFF8D6E63),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'Save Mood',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Your Mood History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15),
            _MoodHistoryCard(
              mood: 'Happy',
              date: 'Today',
              note: 'Had a great day with family',
              color: Color(0xFFCDDC39),
            ),
            _MoodHistoryCard(
              mood: 'Neutral',
              date: 'Yesterday',
              note: 'Just a regular day',
              color: Color(0xFF8BC34A),
            ),
            _MoodHistoryCard(
              mood: 'Sad',
              date: 'Jun 19',
              note: 'Feeling under the weather',
              color: Color(0xFF2196F3),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget moodfactorchip(String label, IconData icon) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Color(0xFF8D6E63),
          ),
          SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodHistoryCard extends StatelessWidget {
  final String mood;
  final String date;
  final String note;
  final Color color;

  const _MoodHistoryCard({
    required this.mood,
    required this.date,
    required this.note,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              mood == 'Happy'
                  ? FontAwesomeIcons.faceSmile
                  : mood == 'Sad'
                  ? FontAwesomeIcons.faceFrown
                  : FontAwesomeIcons.faceMeh,
              color: color,
              size: 25,
            ),
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
                      mood,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  note,
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
    );
  }
}

class MeditationScreen extends StatefulWidget {
  const MeditationScreen({super.key});

  @override
  MeditationScreenState createState() => MeditationScreenState();
}

class MeditationScreenState extends State<MeditationScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _playController;
  late Animation<double> _animation;
  bool _isPlaying = false;
  int _selectedMeditation = 0;

  final List<Map<String, dynamic>> _meditations = [
    {
      'title': 'Morning Calm',
      'duration': '10 min',
      'level': 'Beginner',
      'color': Color(0xFF8BC34A),
      'icon': FontAwesomeIcons.sun,
    },
    {
      'title': 'Deep Relaxation',
      'duration': '20 min',
      'level': 'Intermediate',
      'color': Color(0xFF2196F3),
      'icon': FontAwesomeIcons.water,
    },
    {
      'title': 'Sleep Journey',
      'duration': '30 min',
      'level': 'Advanced',
      'color': Color(0xFF3F51B5),
      'icon': FontAwesomeIcons.moon,
    },
    {
      'title': 'Anxiety Relief',
      'duration': '15 min',
      'level': 'Beginner',
      'color': Color(0xFF9C27B0),
      'icon': FontAwesomeIcons.leaf,
    },
    {
      'title': 'Focus Boost',
      'duration': '12 min',
      'level': 'Intermediate',
      'color': Color(0xFFFF9800),
      'icon': FontAwesomeIcons.brain,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    _playController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _playController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Meditation',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/11.jpg'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Find your inner peace',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: _meditations[_selectedMeditation]['color'].withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage('https://picsum.photos/seed/meditation/400/200.jpg'),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withValues(alpha: 0.3),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 20,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                _meditations[_selectedMeditation]['level'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _meditations[_selectedMeditation]['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.clock,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      _meditations[_selectedMeditation]['duration'],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isPlaying = !_isPlaying;
                                  if (_isPlaying) {
                                    _playController.forward();
                                  } else {
                                    _playController.reverse();
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.2),
                                      blurRadius: 10,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                                  color: _meditations[_selectedMeditation]['color'],
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Recommended for you',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _meditations.length,
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedMeditation = index;
                        _animationController.reset();
                        _animationController.forward();
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 140,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: _selectedMeditation == index
                            ? _meditations[index]['color'].withValues(alpha: 0.2)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: _selectedMeditation == index
                              ? _meditations[index]['color']
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13),
                                ),
                                color: _meditations[index]['color'].withValues(alpha: 0.3),
                              ),
                              child: Icon(
                                _meditations[index]['icon'],
                                color: _meditations[index]['color'],
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _meditations[index]['title'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.clock,
                                        size: 12,
                                        color: Colors.grey[600],
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        _meditations[index]['duration'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    _meditations[index]['level'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _meditations[index]['color'],
                                      fontWeight: FontWeight.bold,
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
                },
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
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
                          'Weekly Goal',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          '4/7 days',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8D6E63),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    LinearProgressIndicator(
                      value: 4 / 7,
                      backgroundColor: Colors.grey.withValues(alpha: 0.2),
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8D6E63)),
                      minHeight: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        progressitem(
                          title: 'Streak',
                          value: '5 days',
                          icon: FontAwesomeIcons.fire,
                        ),
                        progressitem(
                          title: 'Total Time',
                          value: '2h 15m',
                          icon: FontAwesomeIcons.hourglassHalf,
                        ),
                        progressitem(
                          title: 'Sessions',
                          value: '18',
                          icon: FontAwesomeIcons.circleCheck,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget progressitem({required String title, required String value, required IconData icon}) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(0xFF8D6E63),
          size: 24,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}