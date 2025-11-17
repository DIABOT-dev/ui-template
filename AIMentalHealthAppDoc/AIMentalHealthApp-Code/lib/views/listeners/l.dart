import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListenersScreen extends StatefulWidget {
  const ListenersScreen({super.key});

  @override
  State<ListenersScreen> createState() => _ListenersScreenState();
}

class _ListenersScreenState extends State<ListenersScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
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
        leading: const BackButton(),
        title: const Text('Listeners'),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Favorites', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 10),
                SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      FavoritePersonCard(name: 'Helen', imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg'),
                      FavoritePersonCard(name: 'Georg', imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg', isOnline: true),
                      FavoritePersonCard(name: 'Konst', imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg'),
                      FavoritePersonCard(name: 'Roselle', imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg', isOnline: true),
                      FavoritePersonCard(name: 'Eleanor', imageUrl: 'https://randomuser.me/api/portraits/women/5.jpg'),
                      FavoritePersonCard(name: 'Mark', imageUrl: 'https://randomuser.me/api/portraits/men/6.jpg', isOnline: true),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Available Listeners', style: Theme.of(context).textTheme.titleLarge),
                    const Icon(FontAwesomeIcons.bell, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 10),
                ListenerCard(
                  name: 'Georg Strobel',
                  description: 'Happy to hear from you! Feel free to call or message anytime.',
                  imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
                  likes: 125,
                  messages: 32,
                  calls: 54,
                  rating: 4.4,
                ),
                const SizedBox(height: 9),
                ListenerCard(
                  name: 'Hershey',
                  description: 'Everyone deserves a caring ear. Let’s talk whenever you need.',
                  imageUrl: 'https://randomuser.me/api/portraits/men/12.jpg',
                  likes: 125,
                  messages: 32,
                  calls: 32,
                  rating: 3.4,
                ),
                const SizedBox(height: 9),
                ListenerCard(
                  name: 'Alice Johnson',
                  description: 'Here to listen without judgment. Share what’s on your mind.',
                  imageUrl: 'https://randomuser.me/api/portraits/women/13.jpg',
                  likes: 200,
                  messages: 45,
                  calls: 60,
                  rating: 4.8,
                ),
                const SizedBox(height: 9),
                ListenerCard(
                  name: 'David Lee',
                  description: 'Need a friendly chat? I’m always here to listen and connect.',
                  imageUrl: 'https://randomuser.me/api/portraits/men/14.jpg',
                  likes: 98,
                  messages: 20,
                  calls: 30,
                  rating: 4.0,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FavoritePersonCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool isOnline;

  const FavoritePersonCard({
    required this.name,
    required this.imageUrl,
    this.isOnline = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(imageUrl),
              ),
              if (isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(name, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class ListenerCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;
  final int likes;
  final int messages;
  final int calls;
  final double rating;

  const ListenerCard({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.messages,
    required this.calls,
    required this.rating,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('$rating', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Fixed overflow issue by restructuring the layout
            Column(
              children: [
                // Statistics row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.heart, size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Text('$likes', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.message, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('$messages', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.phone, size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Text('$calls', style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Action buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Message Icon Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              name: name,
                              imageUrl: imageUrl,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blue, width: 1.5),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.message,
                          size: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    // Call Icon Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CallScreen(
                              name: name,
                              imageUrl: imageUrl,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          FontAwesomeIcons.phone,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String name;
  final String imageUrl;

  const ChatScreen({
    required this.name,
    required this.imageUrl,
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello there! How are you feeling today?",
      isUser: false,
      time: "10:30 AM",
    ),
    ChatMessage(
      text: "Hi! I'm feeling a bit anxious lately.",
      isUser: true,
      time: "10:32 AM",
    ),
    ChatMessage(
      text: "I'm sorry to hear that. Would you like to talk about what's been making you feel anxious?",
      isUser: false,
      time: "10:33 AM",
    ),
    ChatMessage(
      text: "Yes, I've been stressed about work and it's affecting my sleep.",
      isUser: true,
      time: "10:35 AM",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    _animationController.forward();

    // Scroll to bottom after a short delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isUser: true,
          time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
        ),
      );
      _messageController.clear();
    });

    // Scroll to bottom after sending message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });

    // Simulate a reply after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.add(
          ChatMessage(
            text: "Thank you for sharing that with me. It sounds like work stress is really taking a toll on you. Have you tried any relaxation techniques?",
            isUser: false,
            time: "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}",
          ),
        );
      });

      // Scroll to bottom after receiving reply
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.imageUrl),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(),
                ),
                const Text(
                  'Online now',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CallScreen(
                    name: widget.name,
                    imageUrl: widget.imageUrl,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ScaleTransition(
        scale: _scaleAnimation,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.only(
                      bottom: 8,
                      left: message.isUser ? 40 : 0,
                      right: message.isUser ? 0 : 40,
                    ),
                    child: Column(
                      crossAxisAlignment: message.isUser
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? Colors.blue
                                : Colors.grey.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            message.text,
                            style: TextStyle(
                              color: message.isUser ? Colors.white : Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message.time,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.attach_file,
              color: Colors.grey.withValues(alpha: 0.7),
            ),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.withValues(alpha: 0.1),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final String time;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class CallScreen extends StatefulWidget {
  final String name;
  final String imageUrl;

  const CallScreen({
    required this.name,
    required this.imageUrl,
    super.key,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _slideController;
  late Animation<double> _pulseAnimation;
  late Animation<Offset> _slideAnimation;
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isCallActive = true;
  Duration callDuration = const Duration();

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _pulseController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: Curves.easeOut,
      ),
    );

    _slideController.forward();

    // Start the call timer
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted && isCallActive) {
        setState(() {
          callDuration = const Duration(seconds: 1) + callDuration;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  void _endCall() {
    setState(() {
      isCallActive = false;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      Navigator.pop(context);
    });
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SlideTransition(
        position: _slideAnimation,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade50,
                Colors.blue.shade100,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Text(
                _formatDuration(callDuration),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 40),
              ScaleTransition(
                scale: _pulseAnimation,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(widget.imageUrl),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isCallActive ? 'Connected' : 'Call ended',
                style: TextStyle(
                  fontSize: 16,
                  color: isCallActive ? Colors.green : Colors.red,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCallButton(
                    icon: isMuted ? Icons.mic_off : Icons.mic,
                    color: isMuted ? Colors.red : Colors.white,
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      setState(() {
                        isMuted = !isMuted;
                      });
                    },
                  ),
                  _buildCallButton(
                    icon: isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                    color: isSpeakerOn ? Colors.green : Colors.white,
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      setState(() {
                        isSpeakerOn = !isSpeakerOn;
                      });
                    },
                  ),
                  _buildCallButton(
                    icon: Icons.chat,
                    color: Colors.white,
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            name: widget.name,
                            imageUrl: widget.imageUrl,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              _buildCallButton(
                icon: Icons.call_end,
                color: Colors.white,
                backgroundColor: Colors.red,
                size: 60,
                onPressed: _endCall,
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required Color color,
    required Color backgroundColor,
    double size = 50,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: color,
          size: size * 0.5,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final String name;
  final String imageUrl;

  const ProfileScreen({
    required this.name,
    required this.imageUrl,
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Profile', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(widget.imageUrl),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'Available',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.solidStar, color: Colors.amber, size: 12),
                              const SizedBox(width: 4),
                              const Text(
                                '4.8',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.amber,
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
              const SizedBox(height: 32),
              _buildProfileSection(
                title: 'About Me',
                content: 'I\'m a certified mental health counselor with over 8 years of experience in helping people navigate through life\'s challenges. My approach is empathetic, non-judgmental, and client-centered. I specialize in anxiety, depression, relationship issues, and stress management.',
              ),
              const SizedBox(height: 24),
              _buildProfileSection(
                title: 'Specializations',
                content: 'Anxiety, Depression, Stress Management, Relationship Issues, Self-Esteem, Career Counseling, Grief Counseling, Life Transitions',
              ),
              const SizedBox(height: 24),
              _buildProfileSection(
                title: 'Languages',
                content: 'English, Spanish, French',
              ),
              const SizedBox(height: 24),
              _buildProfileSection(
                title: 'Experience',
                content: '8+ years of counseling experience\nWorked with over 500 clients\nSpecialized training in Cognitive Behavioral Therapy (CBT)',
              ),
              const SizedBox(height: 24),
              _buildProfileSection(
                title: 'Education',
                content: 'Master\'s in Clinical Psychology\nCertified in CBT and Mindfulness-Based Stress Reduction',
              ),
              const SizedBox(height: 24),
              _buildProfileSection(
                title: 'Availability',
                content: 'Monday - Friday: 9:00 AM - 8:00 PM\nSaturday: 10:00 AM - 4:00 PM\nSunday: 12:00 PM - 6:00 PM',
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                name: widget.name,
                                imageUrl: widget.imageUrl,
                              ),
                            ),
                          );
                        },
                        icon: Icon(FontAwesomeIcons.message, size: 16, color: Colors.blue),
                        label: Text('Message', style: TextStyle(color: Colors.blue)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.blue),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CallScreen(
                                name: widget.name,
                                imageUrl: widget.imageUrl,
                              ),
                            ),
                          );
                        },
                        icon: Icon(FontAwesomeIcons.phone, size: 16, color: Colors.white),
                        label: Text('Call Now', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}