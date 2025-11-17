import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
import 'dart:async';

// Helper to generate a random number within a range
int generateRandomNumber(int min, int max) {
  final random = Random();
  return min + random.nextInt(max - min + 1);
}

// Helper to get a random user image URL
String getRandomUserImageUrl() {
  final gender = Random().nextBool() ? 'men' : 'women';
  final number = generateRandomNumber(1, 99); // Assuming 1-99 for simplicity
  return 'https://randomuser.me/api/portraits/$gender/$number.jpg';
}

// Helper for opacity replacement
int alphaFromOpacity(double opacity) {
  return (255 * opacity).round();
}

class MindfullHoursSatesScreen extends StatelessWidget {
  const MindfullHoursSatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () {
            Navigator.pop(context);
          }, // No back action on home
        ),
        title: const Text('Mindful Hours Stats'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.arrowUpFromBracket),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Main Stats Card with animation
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      color: Colors.white,
                      shadowColor: Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 180,
                                  height: 180,
                                  child: TweenAnimationBuilder<double>(
                                    tween: Tween<double>(begin: 0, end: 0.7),
                                    duration: const Duration(seconds: 1),
                                    builder: (context, value, child) {
                                      return CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 15,
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).colorScheme.primary),
                                      );
                                    },
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TweenAnimationBuilder<double>(
                                      tween: Tween<double>(begin: 0, end: 8.21),
                                      duration: const Duration(seconds: 1),
                                      builder: (context, value, child) {
                                        return Text(
                                          '${value.toStringAsFixed(2)}h',
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32),
                                        );
                                      },
                                    ),
                                    Text(
                                      'Total',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildActivityIcon(FontAwesomeIcons.solidMoon, 'Sleep', Colors.blueGrey.shade400),
                                _buildActivityIcon(FontAwesomeIcons.seedling, 'Mindful', Colors.green.shade400),
                                _buildActivityIcon(FontAwesomeIcons.heartPulse, 'Relax', Colors.red.shade400),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Daily Progress Card with more data
                  Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Today\'s Progress', style: Theme.of(context).textTheme.titleLarge),
                          const SizedBox(height: 15),
                          ProgressRow(
                            icon: FontAwesomeIcons.leaf,
                            label: 'Breathing',
                            progress: 0.65,
                            time: '2.5h',
                            color: Colors.green.shade400,
                          ),
                          ProgressRow(
                            icon: FontAwesomeIcons.brain,
                            label: 'Mindfulness',
                            progress: 0.40,
                            time: '1.7h',
                            color: Colors.blue.shade400,
                          ),
                          ProgressRow(
                            icon: FontAwesomeIcons.spa,
                            label: 'Relax',
                            progress: 0.80,
                            time: '8h',
                            color: Colors.purple.shade400,
                          ),
                          ProgressRow(
                            icon: FontAwesomeIcons.solidMoon,
                            label: 'Sleep',
                            progress: 0.90,
                            time: '8h',
                            color: Colors.indigo.shade400,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weekly Average: 7.2h',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '↑ 12%',
                                style: TextStyle(
                                  color: Colors.green.shade600,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Friends activity (more data)
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Friends Activity', style: Theme.of(context).textTheme.titleLarge),
                              TextButton(
                                onPressed: () {},
                                child: Text('View All', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          FriendActivityRow(
                            name: 'Alice',
                            activity: 'Mindfulness',
                            time: '15 min ago',
                            imageUrl: getRandomUserImageUrl(),
                          ),
                          FriendActivityRow(
                            name: 'Bob',
                            activity: 'Breathing',
                            time: '1 hour ago',
                            imageUrl: getRandomUserImageUrl(),
                          ),
                          FriendActivityRow(
                            name: 'Charlie',
                            activity: 'Relaxation',
                            time: '3 hours ago',
                            imageUrl: getRandomUserImageUrl(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Achievement card
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              FontAwesomeIcons.trophy,
                              color: Colors.amber.shade700,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'New Achievement!',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '7-day meditation streak',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Floating Action Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MeditationSessionScreen()),
                    );
                  },
                  label: const Text('Start New Session'),
                  icon: const Icon(FontAwesomeIcons.plus),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withAlpha(alphaFromOpacity(0.1)),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class ProgressRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final double progress;
  final String time;
  final Color color;

  const ProgressRow({
    super.key,
    required this.icon,
    required this.label,
    required this.progress,
    required this.time,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOut,
                    builder: (context, value, child) {
                      return LinearProgressIndicator(
                        value: value,
                        minHeight: 8,
                        backgroundColor: color.withAlpha(alphaFromOpacity(0.1)),
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Text(time, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class FriendActivityRow extends StatelessWidget {
  final String name;
  final String activity;
  final String time;
  final String imageUrl;

  const FriendActivityRow({
    super.key,
    required this.name,
    required this.activity,
    required this.time,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 20,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        'Just finished $activity',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '• $time',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(FontAwesomeIcons.solidHeart, color: Colors.red.shade300, size: 20),
        ],
      ),
    );
  }
}

class MeditationSessionScreen extends StatefulWidget {
  const MeditationSessionScreen({super.key});

  @override
  SessionScreenState createState() => SessionScreenState();
}

class SessionScreenState extends State<MeditationSessionScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool isPlaying = false;
  int secondsElapsed = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10));
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );
    _pulseController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _pulseController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _pulseController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _controller.forward(from: _controller.value);
        _pulseController.forward();
        timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            secondsElapsed++;
          });
        });
      } else {
        _controller.stop();
        _pulseController.stop();
        timer?.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Meditation Session'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.ellipsisVertical),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 50),
                elevation: 8,
                shadowColor: Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.headphones, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 10),
                          Text('SOUND: CHIRPING BIRDS', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      const SizedBox(height: 50),
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              width: 180,
                              height: 180,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.3 + (_controller.value * 0.4))),
                                    Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.1)),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.2)),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      isPlaying ? 'Breathe In...' : 'Tap to Start',
                                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Colors.white,
                                        fontSize: 24,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      formatTime(secondsElapsed),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      LinearProgressIndicator(
                        value: _controller.value,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(formatTime(secondsElapsed), style: Theme.of(context).textTheme.bodyMedium),
                          Text('25:00', style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    iconSize: 40,
                    icon: Icon(FontAwesomeIcons.rotateLeft, color: Theme.of(context).colorScheme.primary),
                    onPressed: () {
                      _controller.reset();
                      setState(() {
                        secondsElapsed = 0;
                      });
                    },
                  ),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: IconButton(
                      iconSize: 40,
                      color: Colors.white,
                      icon: Icon(isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play),
                      onPressed: togglePlayPause,
                    ),
                  ),
                  IconButton(
                    iconSize: 40,
                    icon: Icon(FontAwesomeIcons.rotateRight, color: Theme.of(context).colorScheme.primary),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MoodTrackerScreen()),
                      );
                    },
                    icon: const Icon(FontAwesomeIcons.faceSmile),
                    label: const Text('Log Mood'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SoundscapeSelectionScreen()),
                      );
                    },
                    child: Text('Change Soundscape', style: TextStyle(color: Theme.of(context).colorScheme.primary)),
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

class SoundscapeSelectionScreen extends StatefulWidget {
  const SoundscapeSelectionScreen({super.key});

  @override
  SoundscapeSelectionScreenState createState() => SoundscapeSelectionScreenState();
}

class SoundscapeSelectionScreenState extends State<SoundscapeSelectionScreen> with TickerProviderStateMixin {
  String selectedSoundscape = 'Zen Garden'; // Default selection
  final List<String> soundscapes = ['Birds', 'Zen Garden', 'Mountain Stream', 'Ocean Waves', 'Rainforest'];
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
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
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('New Exercise'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(child: Text('1 of 6')), // Dummy step indicator
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Soundscapes', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      // Visualizer Placeholder with animation
                      Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: AnimatedIcon(
                            icon: AnimatedIcons.play_pause,
                            progress: _animationController,
                            size: 50,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50, // Height for the horizontal list
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: soundscapes.length,
                          itemBuilder: (context, index) {
                            final sound = soundscapes[index];
                            final isSelected = sound == selectedSoundscape;
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ChoiceChip(
                                label: Text(sound),
                                selected: isSelected,
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() {
                                      selectedSoundscape = sound;
                                    });
                                  }
                                },
                                selectedColor: Theme.of(context).colorScheme.primary,
                                labelStyle: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black87,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                ),
                                backgroundColor: Colors.grey.shade200,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                    color: isSelected ? Theme.of(context).colorScheme.primary : Colors.transparent,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search soundscapes',
                          prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Recommended soundscapes
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recommended for you',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                final recommended = ['Rainforest', 'Ocean Waves', 'Mountain Stream'][index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage('https://picsum.photos/seed/$recommended/150/120.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withAlpha(alphaFromOpacity(0.7)),
                                          ],
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        recommended,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Implement action to continue with selected soundscape
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Selected: $selectedSoundscape. Continuing...')),
                    );
                    // Navigator.push for the next screen if needed
                  },
                  icon: const Icon(FontAwesomeIcons.arrowRight, color: Colors.white),
                  label: Text('Continue', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
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

// New Screen 1: Mood Tracker
class MoodTrackerScreen extends StatefulWidget {
  const MoodTrackerScreen({super.key});

  @override
  MoodTrackerScreenState createState() => MoodTrackerScreenState();
}

class MoodTrackerScreenState extends State<MoodTrackerScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  int selectedMood = -1;
  final List<String> moodLabels = ['Very Sad', 'Sad', 'Neutral', 'Happy', 'Very Happy'];
  final List<Color> moodColors = [
    Colors.blue.shade300,
    Colors.blue.shade100,
    Colors.green.shade100,
    Colors.yellow.shade200,
    Colors.orange.shade300,
  ];
  final List<IconData> moodIcons = [
    FontAwesomeIcons.faceSadTear,
    FontAwesomeIcons.faceFrown,
    FontAwesomeIcons.faceMeh,
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceLaughBeam,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void selectMood(int index) {
    setState(() {
      selectedMood = index;
    });
    _animationController.forward().then((_) {
      _animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Mood Tracker'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.calendarDays),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How are you feeling today?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              'Track your mood to understand patterns and improve your mental wellbeing.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 30),
            // Mood selector
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: moodLabels.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => selectMood(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: selectedMood == index
                            ? moodColors[index]
                            : moodColors[index].withAlpha(alphaFromOpacity(0.3)),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: selectedMood == index
                              ? moodColors[index]
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedBuilder(
                            animation: _scaleAnimation,
                            builder: (context, child) {
                              double scale = selectedMood == index ? _scaleAnimation.value : 1.0;
                              return Transform.scale(
                                scale: scale,
                                child: Icon(
                                  moodIcons[index],
                                  size: 30,
                                  color: selectedMood == index
                                      ? Colors.white
                                      : moodColors[index].withAlpha(alphaFromOpacity(0.8)),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          Text(
                            moodLabels[index],
                            style: TextStyle(
                              color: selectedMood == index
                                  ? Colors.white
                                  : Colors.black87,
                              fontWeight: selectedMood == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            // Mood history
            Text(
              'Your Mood History',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 15),
            Container(
              height: 200,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildMoodBar(3, 0.7, Colors.orange.shade300),
                        _buildMoodBar(2, 0.4, Colors.green.shade100),
                        _buildMoodBar(4, 0.9, Colors.orange.shade300),
                        _buildMoodBar(1, 0.3, Colors.blue.shade100),
                        _buildMoodBar(3, 0.6, Colors.yellow.shade200),
                        _buildMoodBar(4, 0.8, Colors.orange.shade300),
                        _buildMoodBar(2, 0.5, Colors.green.shade100),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mon', style: TextStyle(color: Colors.grey.shade600)),
                      Text('Tue', style: TextStyle(color: Colors.grey.shade600)),
                      Text('Wed', style: TextStyle(color: Colors.grey.shade600)),
                      Text('Thu', style: TextStyle(color: Colors.grey.shade600)),
                      Text('Fri', style: TextStyle(color: Colors.grey.shade600)),
                      Text('Sat', style: TextStyle(color: Colors.grey.shade600)),
                      Text('Sun', style: TextStyle(color: Colors.grey.shade600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Mood notes
            Text(
              'Add a note (optional)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedMood != -1
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Mood logged successfully!')),
                  );
                  Navigator.pop(context);
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Text(
                  'Save Mood',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoodBar(int moodIndex, double height, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 120 * height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Icon(
              moodIcons[moodIndex],
              size: 16,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}

// New Screen 2: Breathing Exercise
class BreathingExerciseScreen extends StatefulWidget {
  const BreathingExerciseScreen({super.key});

  @override
  BreathingExerciseScreenState createState() => BreathingExerciseScreenState();
}

class BreathingExerciseScreenState extends State<BreathingExerciseScreen> with TickerProviderStateMixin {
  late AnimationController _breathingController;
  late Animation<double> _breathingAnimation;
  bool isPlaying = false;
  Timer? timer;
  int cycleCount = 0;
  int secondsElapsed = 0;
  String currentPhase = 'Ready';
  final List<String> phases = ['Inhale', 'Hold', 'Exhale', 'Hold'];
  int currentPhaseIndex = 0;

  @override
  void initState() {
    super.initState();
    _breathingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _breathingAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _breathingController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _breathingController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void startExercise() {
    setState(() {
      isPlaying = true;
      cycleCount = 0;
      secondsElapsed = 0;
      currentPhaseIndex = 0;
      currentPhase = phases[0];
    });
    _breathingController.forward();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsElapsed++;
        currentPhaseIndex = (secondsElapsed % 16) ~/ 4;
        currentPhase = phases[currentPhaseIndex];

        if (secondsElapsed % 16 == 0) {
          cycleCount++;
        }
      });
    });
  }

  void pauseExercise() {
    setState(() {
      isPlaying = false;
    });
    _breathingController.stop();
    timer?.cancel();
  }

  void resetExercise() {
    setState(() {
      isPlaying = false;
      cycleCount = 0;
      secondsElapsed = 0;
      currentPhaseIndex = 0;
      currentPhase = 'Ready';
    });
    _breathingController.reset();
    timer?.cancel();
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Breathing Exercise'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.circleInfo),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('About Breathing Exercise'),
                  content: const Text(
                    'This exercise guides you through a 4-4-4-4 breathing pattern: '
                        'inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, '
                        'and hold again for 4 seconds. This pattern can help reduce stress '
                        'and improve focus.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Got it'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Cycles: $cycleCount',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          formatTime(secondsElapsed),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    AnimatedBuilder(
                      animation: _breathingAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _breathingAnimation.value,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.8)),
                                  Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.2)),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).colorScheme.primary.withAlpha(alphaFromOpacity(0.3)),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                currentPhase,
                                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildPhaseIndicator('Inhale', 0, Colors.green.shade400),
                        _buildPhaseIndicator('Hold', 1, Colors.yellow.shade400),
                        _buildPhaseIndicator('Exhale', 2, Colors.blue.shade400),
                        _buildPhaseIndicator('Hold', 3, Colors.purple.shade400),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: resetExercise,
                  icon: const Icon(FontAwesomeIcons.rotateLeft),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    iconSize: 40,
                    color: Colors.white,
                    icon: Icon(isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play),
                    onPressed: isPlaying ? pauseExercise : startExercise,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const JournalScreen()),
                    );
                  },
                  icon: const Icon(FontAwesomeIcons.book),
                  label: const Text('Journal'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade200,
                    foregroundColor: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Take a moment to focus on your breath. Let your thoughts come and go without judgment.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseIndicator(String label, int index, Color color) {
    bool isActive = currentPhaseIndex == index;
    return Column(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: isActive ? color : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            color: isActive ? color : Colors.grey.shade500,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// New Screen 3: Journal
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  JournalScreenState createState() => JournalScreenState();
}

class JournalScreenState extends State<JournalScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final List<JournalEntry> journalEntries = [
    JournalEntry(
      title: 'A stressful day',
      content: 'Today was really challenging at work. I felt overwhelmed with the amount of tasks I had to complete. I took a 10-minute break to do some breathing exercises, which helped me regain focus.',
      date: '2023-05-15',
      mood: 'Sad',
    ),
    JournalEntry(
      title: 'Grateful moments',
      content: 'I\'m feeling grateful today for my family and friends. Had a wonderful dinner with my loved ones and shared many laughs. These moments remind me of what\'s truly important in life.',
      date: '2023-05-14',
      mood: 'Happy',
    ),
    JournalEntry(
      title: 'Morning meditation',
      content: 'Started my day with a 20-minute meditation session. It really helped set a positive tone for the day. I felt more centered and focused throughout the morning.',
      date: '2023-05-13',
      mood: 'Neutral',
    ),
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void saveJournalEntry() {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      final newEntry = JournalEntry(
        title: _titleController.text,
        content: _contentController.text,
        date: DateTime.now().toString().substring(0, 10),
        mood: 'Happy',
      );
      setState(() {
        journalEntries.insert(0, newEntry);
        _titleController.clear();
        _contentController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Journal entry saved successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Journal'),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Write your thoughts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        hintText: 'Title',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _contentController,
                      decoration: InputDecoration(
                        hintText: 'What\'s on your mind?',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                      maxLines: 5,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const MoodTrackerScreen()),
                              );
                            },
                            icon: const Icon(FontAwesomeIcons.faceSmile),
                            label: const Text('Add Mood'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: saveJournalEntry,
                            icon: const Icon(FontAwesomeIcons.floppyDisk),
                            label: const Text('Save'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Previous Entries',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: journalEntries.length,
                itemBuilder: (context, index) {
                  final entry = journalEntries[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entry.title,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                entry.date,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            entry.content,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getMoodColor(entry.mood).withAlpha(alphaFromOpacity(0.2)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  entry.mood,
                                  style: TextStyle(
                                    color: _getMoodColor(entry.mood),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                icon: const Icon(FontAwesomeIcons.ellipsisVertical, size: 16),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getMoodColor(String mood) {
    switch (mood.toLowerCase()) {
      case 'very sad':
        return Colors.blue.shade300;
      case 'sad':
        return Colors.blue.shade100;
      case 'neutral':
        return Colors.green.shade100;
      case 'happy':
        return Colors.yellow.shade200;
      case 'very happy':
        return Colors.orange.shade300;
      default:
        return Colors.grey.shade300;
    }
  }
}

class JournalEntry {
  final String title;
  final String content;
  final String date;
  final String mood;

  JournalEntry({
    required this.title,
    required this.content,
    required this.date,
    required this.mood,
  });
}