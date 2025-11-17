import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class StrategiesScreen extends StatefulWidget {
  const StrategiesScreen({super.key});

  @override
  State<StrategiesScreen> createState() => _StrategiesScreenState();
}

class _StrategiesScreenState extends State<StrategiesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Strategy> strategies = [
    Strategy(
      title: 'Mindfulness anchor',
      details: 'Focus on your breath to ground yourself.',
      imagePath: 'https://randomuser.me/api/portraits/women/1.jpg',
      color: Colors.lightBlue,
      description:
      'Mindfulness anchor involves paying attention to a specific sensation, like your breath, to stay present. It helps reduce stress and improve focus.',
      duration: '5-10 min',
      difficulty: 'Beginner',
    ),
    Strategy(
      title: 'Guided breathing relaxation',
      details: 'Follow audio cues for deep relaxation.',
      imagePath: 'https://randomuser.me/api/portraits/men/11.jpg',
      color: Colors.green,
      selected: true,
      description:
      'Guided breathing relaxation uses verbal instructions to lead you through various breathing exercises. It can significantly lower anxiety and promote calmness.',
      duration: '10-15 min',
      difficulty: 'Beginner',
    ),
    Strategy(
      title: 'Image and audio of safety',
      details: 'Visualize a safe place with calming sounds.',
      imagePath: 'https://randomuser.me/api/portraits/women/2.jpg',
      color: Colors.purple,
      description:
      'This strategy combines visual imagery of a peaceful environment with soothing audio to create a sense of safety and tranquility, helping to alleviate distress.',
      duration: '15-20 min',
      difficulty: 'Intermediate',
    ),
    Strategy(
      title: 'Cognitive restructuring',
      details: 'Challenge negative thought patterns.',
      imagePath: 'https://randomuser.me/api/portraits/men/12.jpg',
      color: Colors.orange,
      description:
      'Cognitive restructuring is a therapeutic technique that helps you identify and challenge irrational or negative thoughts, replacing them with more realistic and positive ones.',
      duration: '20-30 min',
      difficulty: 'Advanced',
    ),
    Strategy(
      title: 'Selection of music list',
      details: 'Listen to curated calming melodies.',
      imagePath: 'https://randomuser.me/api/portraits/women/3.jpg',
      color: Colors.pink,
      selected: true,
      description:
      'A curated music list provides a selection of calming and uplifting melodies designed to reduce stress, improve mood, and enhance relaxation.',
      duration: 'Varies',
      difficulty: 'Beginner',
    ),
    Strategy(
      title: 'Progressive muscle relaxation',
      details: 'Tense and relax different muscle groups.',
      imagePath: 'https://randomuser.me/api/portraits/men/13.jpg',
      color: Colors.teal,
      description:
      'Progressive muscle relaxation is a technique where you systematically tense and then relax different muscle groups in your body, promoting overall physical and mental relaxation.',
      duration: '15-25 min',
      difficulty: 'Intermediate',
    ),
    Strategy(
      title: 'Gratitude journaling',
      details: 'Write down things you are grateful for.',
      imagePath: 'https://randomuser.me/api/portraits/women/4.jpg',
      color: Colors.amber,
      description:
      'Gratitude journaling involves regularly writing down things you are thankful for. This practice can improve your mood, reduce stress, and foster a more positive outlook on life.',
      duration: '10-15 min',
      difficulty: 'Beginner',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
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
    timeDilation = 1.5; // Slow down animations for better visual effect
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            title:   FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Strategies',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.commentDots, color: Colors.black, size: 20),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CommunitySupportScreen()),
                      );
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            FadeTransition(
              opacity: _fadeAnimation,
              child: Text(
                'Choose a strategy to improve your mental wellbeing',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: strategies.length,
                itemBuilder: (context, index) {
                  return AnimatedStrategyCard(
                    strategy: strategies[index],
                    index: index,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StrategyDetailScreen(
                            strategy: strategies[index],
                          ),
                        ),
                      );
                    },
                    onSelect: () {
                      setState(() {
                        strategies[index].selected = !strategies[index].selected;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProgressTrackerScreen()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(FontAwesomeIcons.chartLine, color: Colors.white),
      ),
    );
  }
}

class AnimatedStrategyCard extends StatefulWidget {
  final Strategy strategy;
  final int index;
  final VoidCallback onTap;
  final VoidCallback onSelect;

  const AnimatedStrategyCard({super.key,
    required this.strategy,
    required this.index,
    required this.onTap,
    required this.onSelect,
  });

  @override
  AnimatedStrategyCardState createState() => AnimatedStrategyCardState();
}

class AnimatedStrategyCardState extends State<AnimatedStrategyCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: EdgeInsets.only(bottom: 7),
            padding: EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Hero(
                  tag: 'strategyImage${widget.index}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      widget.strategy.imagePath,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.strategy.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Text(
                              widget.strategy.duration,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(Icons.signal_cellular_alt, size: 14, color: Colors.grey[600]),
                            SizedBox(width: 4),
                            Text(
                              widget.strategy.difficulty,
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
                GestureDetector(
                  onTap: widget.onSelect,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: widget.strategy.selected ? null : Border.all(color: Colors.grey, width: 2),
                      color: widget.strategy.selected ? Colors.deepPurple : Colors.transparent,
                    ),
                    child: widget.strategy.selected
                        ? Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18,
                    )
                        : null,
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

class Strategy {
  final String title;
  final String details;
  final String imagePath;
  final Color color;
  final String description;
  final String duration;
  final String difficulty;
  bool selected;

  Strategy({
    required this.title,
    required this.details,
    required this.imagePath,
    required this.color,
    required this.description,
    required this.duration,
    required this.difficulty,
    this.selected = false,
  });
}

class StrategyDetailScreen extends StatefulWidget {
  final Strategy strategy;

  const StrategyDetailScreen({super.key, required this.strategy});

  @override
  StrategyDetailScreenState createState() => StrategyDetailScreenState();
}

class StrategyDetailScreenState extends State<StrategyDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
          widget.strategy.title,
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              child: IconButton(
                icon: Icon(
                  isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                  color: isFavorite ? Colors.redAccent : Colors.grey,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Hero(
                  tag: 'strategyImage${widget.strategy.title}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.strategy.imagePath,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                child: Text(
                  widget.strategy.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    widget.strategy.duration,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(width: 15),
                  Icon(Icons.signal_cellular_alt, size: 16, color: Colors.grey[600]),
                  SizedBox(width: 4),
                  Text(
                    widget.strategy.difficulty,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'A powerful strategy for mental well-being.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey[300], thickness: 1),
              SizedBox(height: 20),
              Text(
                'About this Strategy:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                widget.strategy.description,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Benefits:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              ..._buildBenefitsList(),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: widget.strategy.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.solidLightbulb, color: widget.strategy.color, size: 28),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        'Tip: Practice daily for best results!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: widget.strategy.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MoodJournalScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Start Strategy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBenefitsList() {
    List<String> benefits = [
      'Reduces stress and anxiety',
      'Improves focus and concentration',
      'Enhances emotional regulation',
      'Promotes better sleep',
      'Increases self-awareness'
    ];

    return benefits.map((benefit) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 20),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                benefit,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

class ProgressTrackerScreen extends StatefulWidget {
  const ProgressTrackerScreen({super.key});

  @override
  ProgressTrackerScreenState createState() => ProgressTrackerScreenState();
}

class ProgressTrackerScreenState extends State<ProgressTrackerScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  final List<ProgressData> progressData = [
    ProgressData(
      title: 'Mindfulness',
      progress: 0.75,
      color: Colors.lightBlue,
      sessions: 15,
      streak: 7,
    ),
    ProgressData(
      title: 'Breathing',
      progress: 0.5,
      color: Colors.green,
      sessions: 10,
      streak: 3,
    ),
    ProgressData(
      title: 'Cognitive Restructuring',
      progress: 0.3,
      color: Colors.orange,
      sessions: 6,
      streak: 2,
    ),
    ProgressData(
      title: 'Gratitude Journaling',
      progress: 0.9,
      color: Colors.amber,
      sessions: 18,
      streak: 14,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _progressController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
    _progressController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            title: Text(
              'Progress Tracker',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Track your mental wellness journey',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '28',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            'Total Sessions',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '7',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            'Day Streak',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '4',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            'Strategies',
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
              SizedBox(height: 30),
              Text(
                'Strategy Progress',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: progressData.length,
                  itemBuilder: (context, index) {
                    return AnimatedProgressCard(
                      progressData: progressData[index],
                      progressAnimation: _progressAnimation,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MoodJournalScreen()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(FontAwesomeIcons.book, color: Colors.white),
      ),
    );
  }
}

class AnimatedProgressCard extends StatelessWidget {
  final ProgressData progressData;
  final Animation<double> progressAnimation;

  const AnimatedProgressCard({super.key,
    required this.progressData,
    required this.progressAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
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
                progressData.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: progressData.color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '${progressData.streak} days',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: progressData.color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${progressData.sessions} sessions',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progressAnimation.value * progressData.progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: progressData.color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 15),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: progressData.color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${(progressData.progress * 100).toInt()}%',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: progressData.color,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProgressData {
  final String title;
  final double progress;
  final Color color;
  final int sessions;
  final int streak;

  ProgressData({
    required this.title,
    required this.progress,
    required this.color,
    required this.sessions,
    required this.streak,
  });
}

class MoodJournalScreen extends StatefulWidget {
  const MoodJournalScreen({super.key});

  @override
  MoodJournalScreenState createState() => MoodJournalScreenState();
}

class MoodJournalScreenState extends State<MoodJournalScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _fabController;
  late Animation<double> _fabAnimation;

  final List<MoodEntry> moodEntries = [
    MoodEntry(
      date: 'Today, 10:30 AM',
      mood: 'Happy',
      moodColor: Colors.yellow,
      note: 'Had a great morning meditation session. Feeling energized and positive for the day ahead.',
      activities: ['Meditation', 'Breathing Exercise'],
    ),
    MoodEntry(
      date: 'Yesterday, 8:45 PM',
      mood: 'Calm',
      moodColor: Colors.green,
      note: 'Finished the day with gratitude journaling. Helped me reflect on the positive aspects of my day.',
      activities: ['Gratitude Journaling'],
    ),
    MoodEntry(
      date: 'Yesterday, 2:15 PM',
      mood: 'Anxious',
      moodColor: Colors.orange,
      note: 'Felt overwhelmed with work tasks. Used the breathing technique to calm down.',
      activities: ['Breathing Exercise'],
    ),
    MoodEntry(
      date: '2 days ago, 9:20 PM',
      mood: 'Sad',
      moodColor: Colors.blue,
      note: 'Had a difficult conversation with a friend. Listening to calming music helped me process my emotions.',
      activities: ['Music Therapy'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _fabController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _fabAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _fabController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            title: Text(
              'Mood Journal',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Mood Journey',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Track your emotions and reflections',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 80,
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 8),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: _getMoodColor(index).withValues(alpha: 0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _getMoodIcon(index),
                              color: _getMoodColor(index),
                              size: 24,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Recent Entries',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                  itemCount: moodEntries.length,
                  itemBuilder: (context, index) {
                    return MoodEntryCard(
                      moodEntry: moodEntries[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: _fabAnimation,
        child: FloatingActionButton(
          onPressed: () {
            _fabController.reset();
            _fabController.forward();
            _showAddEntryDialog();
          },
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Color _getMoodColor(int index) {
    List<Color> colors = [
      Colors.yellow,
      Colors.green,
      Colors.orange,
      Colors.blue,
      Colors.purple,
      Colors.red,
      Colors.teal
    ];
    return colors[index % colors.length];
  }

  IconData _getMoodIcon(int index) {
    List<IconData> icons = [
      Icons.sentiment_very_satisfied,
      Icons.sentiment_satisfied,
      Icons.sentiment_neutral,
      Icons.sentiment_dissatisfied,
      Icons.sentiment_very_dissatisfied,
      Icons.mood_bad,
      Icons.emoji_emotions
    ];
    return icons[index % icons.length];
  }

  void _showAddEntryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Mood Entry'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'How are you feeling?',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a note...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  moodEntries.insert(
                    0,
                    MoodEntry(
                      date: 'Just now',
                      mood: 'Neutral',
                      moodColor: Colors.grey,
                      note: 'New entry added',
                      activities: [],
                    ),
                  );
                });
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class MoodEntryCard extends StatefulWidget {
  final MoodEntry moodEntry;
  final int index;

  const MoodEntryCard({super.key,
    required this.moodEntry,
    required this.index,
  });

  @override
  MoodEntryCardState createState() => MoodEntryCardState();
}

class MoodEntryCardState extends State<MoodEntryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: widget.moodEntry.moodColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getMoodIcon(widget.moodEntry.mood),
                          color: widget.moodEntry.moodColor,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        widget.moodEntry.mood,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.moodEntry.date,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                widget.moodEntry.note,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
              if (widget.moodEntry.activities.isNotEmpty) ...[
                SizedBox(height: 15),
                Wrap(
                  spacing: 8,
                  children: widget.moodEntry.activities.map((activity) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        activity,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconData _getMoodIcon(String mood) {
    switch (mood.toLowerCase()) {
      case 'happy':
        return Icons.sentiment_very_satisfied;
      case 'calm':
        return Icons.sentiment_satisfied;
      case 'anxious':
        return Icons.sentiment_dissatisfied;
      case 'sad':
        return Icons.sentiment_very_dissatisfied;
      default:
        return Icons.sentiment_neutral;
    }
  }
}

class MoodEntry {
  final String date;
  final String mood;
  final Color moodColor;
  final String note;
  final List<String> activities;

  MoodEntry({
    required this.date,
    required this.mood,
    required this.moodColor,
    required this.note,
    required this.activities,
  });
}

class CommunitySupportScreen extends StatefulWidget {
  const CommunitySupportScreen({super.key});

  @override
  CommunitySupportScreenState createState() => CommunitySupportScreenState();
}

class CommunitySupportScreenState extends State<CommunitySupportScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<CommunityPost> posts = [
    CommunityPost(
      userName: 'Alex Johnson',
      userImage: 'https://randomuser.me/api/portraits/men/11.jpg',
      time: '2 hours ago',
      content: 'Just completed my 30-day meditation challenge! The difference in my anxiety levels is incredible. Highly recommend to everyone!',
      likes: 24,
      comments: 8,
      isLiked: false,
    ),
    CommunityPost(
      userName: 'Sarah Williams',
      userImage: 'https://randomuser.me/api/portraits/women/2.jpg',
      time: '5 hours ago',
      content: 'Had a tough day today, but the breathing exercises really helped me stay grounded. Thank you to this community for all the support!',
      likes: 42,
      comments: 12,
      isLiked: true,
    ),
    CommunityPost(
      userName: 'Michael Chen',
      userImage: 'https://randomuser.me/api/portraits/men/12.jpg',
      time: '1 day ago',
      content: 'Does anyone have tips for maintaining consistency with gratitude journaling? I keep forgetting to do it daily.',
      likes: 15,
      comments: 21,
      isLiked: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            title: Text(
              'Community Support',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Supportive Community',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Connect with others on their mental wellness journey',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.users, color: Colors.deepPurple, size: 28),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Community Guidelines',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade900,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Be respectful, supportive, and kind to all members',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.deepPurple.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return CommunityPostCard(
                      post: posts[index],
                      index: index,
                      onLike: () {
                        setState(() {
                          posts[index].isLiked = !posts[index].isLiked;
                          if (posts[index].isLiked) {
                            posts[index].likes += 1;
                          } else {
                            posts[index].likes -= 1;
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog();
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create a Post'),
          content: SizedBox(
            height: 200,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Share your thoughts...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  posts.insert(
                    0,
                    CommunityPost(
                      userName: 'You',
                      userImage: 'https://randomuser.me/api/portraits/men/11.jpg',
                      time: 'Just now',
                      content: 'New post created',
                      likes: 0,
                      comments: 0,
                      isLiked: false,
                    ),
                  );
                });
              },
              child: Text('Post'),
            ),
          ],
        );
      },
    );
  }
}

class CommunityPostCard extends StatefulWidget {
  final CommunityPost post;
  final int index;
  final VoidCallback onLike;

  const CommunityPostCard({super.key,
    required this.post,
    required this.index,
    required this.onLike,
  });

  @override
  CommunityPostCardState createState() => CommunityPostCardState();
}

class CommunityPostCardState extends State<CommunityPostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 2,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.post.userImage,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.post.userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.post.time,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz, color: Colors.grey[600]),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                widget.post.content,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  GestureDetector(
                    onTap: widget.onLike,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: widget.post.isLiked
                            ? Colors.red.withValues(alpha: 0.1)
                            : Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            widget.post.isLiked
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: widget.post.isLiked ? Colors.red : Colors.grey[600],
                            size: 16,
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${widget.post.likes}',
                            style: TextStyle(
                              fontSize: 14,
                              color: widget.post.isLiked ? Colors.red : Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.comment,
                          color: Colors.grey[600],
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '${widget.post.comments}',
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
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityPost {
  final String userName;
  final String userImage;
  final String time;
  final String content;
  int likes;
  int comments;
  bool isLiked;

  CommunityPost({
    required this.userName,
    required this.userImage,
    required this.time,
    required this.content,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });
}