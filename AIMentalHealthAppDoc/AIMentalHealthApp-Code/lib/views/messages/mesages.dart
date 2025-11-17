import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mindful Moments',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.teal.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal.shade50,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.teal.shade700),
          titleTextStyle: TextStyle(
            color: Colors.teal.shade900,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MessagesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Data Models
class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String senderImage;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final bool isOnline;
  final String role; // Added to identify if it's a therapist or support person

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isOnline,
    required this.role,
  });
}

class Conversation {
  final String id;
  final List<Message> messages;
  final String participantId;
  final String participantName;
  final String participantImage;

  Conversation({
    required this.id,
    required this.messages,
    required this.participantId,
    required this.participantName,
    required this.participantImage,
  });
}

// Dummy Data - Updated for mental health context
final List<Message> dummyMessages = [
  Message(
    id: 'MSG-001',
    senderId: '1',
    senderName: 'Dr. Sarah Johnson',
    senderImage: 'https://randomuser.me/api/portraits/women/11.jpg',
    lastMessage: 'How are you feeling today?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    unreadCount: 2,
    isOnline: true,
    role: 'Therapist',
  ),
  Message(
    id: 'MSG-002',
    senderName: 'Support Group',
    senderId: '2',
    senderImage: 'https://randomuser.me/api/portraits/women/22.jpg',
    lastMessage: 'Thank you for sharing your thoughts with us',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    unreadCount: 0,
    isOnline: false,
    role: 'Support Group',
  ),
  Message(
    id: 'MSG-003',
    senderId: '3',
    senderName: 'Dr. Michael Chen',
    senderImage: 'https://randomuser.me/api/portraits/men/33.jpg',
    lastMessage: 'Let\'s schedule our next session',
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    unreadCount: 1,
    isOnline: true,
    role: 'Therapist',
  ),
  Message(
    id: 'MSG-004',
    senderId: '4',
    senderName: 'Emma Rodriguez',
    senderImage: 'https://randomuser.me/api/portraits/women/44.jpg',
    lastMessage: 'The meditation techniques you shared really helped',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    unreadCount: 0,
    isOnline: false,
    role: 'Peer Support',
  ),
  Message(
    id: 'MSG-005',
    senderId: '5',
    senderName: 'Crisis Helpline',
    senderImage: 'https://randomuser.me/api/portraits/men/55.jpg',
    lastMessage: 'Remember we\'re here 24/7 if you need support',
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 3,
    isOnline: true,
    role: 'Support',
  ), Message(
    id: 'MSG-001',
    senderId: '1',
    senderName: 'Dr. Sarah Johnson',
    senderImage: 'https://randomuser.me/api/portraits/women/11.jpg',
    lastMessage: 'How are you feeling today?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    unreadCount: 2,
    isOnline: true,
    role: 'Therapist',
  ),
  Message(
    id: 'MSG-002',
    senderName: 'Support Group',
    senderId: '2',
    senderImage: 'https://randomuser.me/api/portraits/women/22.jpg',
    lastMessage: 'Thank you for sharing your thoughts with us',
    timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    unreadCount: 0,
    isOnline: false,
    role: 'Support Group',
  ),
  Message(
    id: 'MSG-003',
    senderId: '3',
    senderName: 'Dr. Michael Chen',
    senderImage: 'https://randomuser.me/api/portraits/men/33.jpg',
    lastMessage: 'Let\'s schedule our next session',
    timestamp: DateTime.now().subtract(const Duration(hours: 3)),
    unreadCount: 1,
    isOnline: true,
    role: 'Therapist',
  ),
  Message(
    id: 'MSG-004',
    senderId: '4',
    senderName: 'Emma Rodriguez',
    senderImage: 'https://randomuser.me/api/portraits/women/44.jpg',
    lastMessage: 'The meditation techniques you shared really helped',
    timestamp: DateTime.now().subtract(const Duration(hours: 5)),
    unreadCount: 0,
    isOnline: false,
    role: 'Peer Support',
  ),
  Message(
    id: 'MSG-005',
    senderId: '5',
    senderName: 'Crisis Helpline',
    senderImage: 'https://randomuser.me/api/portraits/men/55.jpg',
    lastMessage: 'Remember we\'re here 24/7 if you need support',
    timestamp: DateTime.now().subtract(const Duration(days: 1)),
    unreadCount: 3,
    isOnline: true,
    role: 'Support',
  ),
];

// Screens
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<Message> _filteredMessages = [];

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

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _filteredMessages = List.from(dummyMessages);
    _searchController.addListener(_filterMessages);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterMessages() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMessages = List.from(dummyMessages);
      } else {
        _filteredMessages = dummyMessages
            .where((message) =>
        message.senderName.toLowerCase().contains(query) ||
            message.lastMessage.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support Network',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.teal.shade700),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Column(
            children: [
              _buildSearchBar(),
              const SizedBox(height: 2),
              Expanded(
                child: _filteredMessages.isEmpty
                    ? _buildEmptyState()
                    : _buildMessagesList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 500),
              pageBuilder: (_, __, ___) => const NewMessageScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );
        },
        backgroundColor: Colors.teal.shade600,
        child: const Icon(Icons.edit, color: Colors.white),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.teal.shade400),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Search conversations...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.teal.shade400),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.message_outlined,
            size: 80,
            color: Colors.teal.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 20),
          Text(
            'No conversations found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Try a different search term',
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredMessages.length,
      itemBuilder: (context, index) {
        final message = _filteredMessages[index];
        return MessageCard(
          message: message,
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) => ChatScreen(
                  participantId: message.senderId,
                  participantName: message.senderName,
                  participantImage: message.senderImage,
                  role: message.role,
                ),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class MessageCard extends StatelessWidget {
  final Message message;
  final VoidCallback onTap;

  const MessageCard({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(message.senderImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (message.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          message.senderName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          message.role,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatTime(message.timestamp),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message.lastMessage,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (message.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade600,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 24,
                            minHeight: 24,
                          ),
                          child: Text(
                            message.unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return DateFormat('dd/MM/yyyy').format(timestamp);
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

class ChatScreen extends StatefulWidget {
  final String participantId;
  final String participantName;
  final String participantImage;
  final String role;

  const ChatScreen({
    super.key,
    required this.participantId,
    required this.participantName,
    required this.participantImage,
    required this.role,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Load messages for this conversation
    _loadMessages();

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    // In a real app, you would fetch messages from an API
    // For now, we'll use dummy data
    setState(() {
      _messages.addAll([
        Message(
          id: 'MSG-001',
          senderId: widget.participantId,
          senderName: widget.participantName,
          senderImage: widget.participantImage,
          lastMessage: 'Hello, how are you feeling today?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
          unreadCount: 0,
          isOnline: true,
          role: widget.role,
        ),
        Message(
          id: 'MSG-002',
          senderId: 'current-user',
          senderName: 'You',
          senderImage: 'https://randomuser.me/api/portraits/men/1.jpg',
          lastMessage: 'I\'ve been feeling a bit anxious lately',
          timestamp: DateTime.now().subtract(const Duration(minutes: 25)),
          unreadCount: 0,
          isOnline: true,
          role: 'User',
        ),
        Message(
          id: 'MSG-003',
          senderId: widget.participantId,
          senderName: widget.participantName,
          senderImage: widget.participantImage,
          lastMessage: 'I understand. Would you like to talk about what\'s causing these feelings?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 20)),
          unreadCount: 0,
          isOnline: true,
          role: widget.role,
        ),
        Message(
          id: 'MSG-004',
          senderId: 'current-user',
          senderName: 'You',
          senderImage: 'https://randomuser.me/api/portraits/men/1.jpg',
          lastMessage: 'It\'s mainly work stress and not getting enough sleep',
          timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
          unreadCount: 0,
          isOnline: true,
          role: 'User',
        ),
        Message(
          id: 'MSG-005',
          senderId: widget.participantId,
          senderName: widget.participantName,
          senderImage: widget.participantImage,
          lastMessage: 'That sounds challenging. Have you tried the breathing exercises we discussed?',
          timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
          unreadCount: 0,
          isOnline: true,
          role: widget.role,
        ),
      ]);
    });

    // Scroll to bottom after messages are loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: 'MSG-${_messages.length + 1}',
      senderId: 'current-user',
      senderName: 'You',
      senderImage: 'https://randomuser.me/api/portraits/men/1.jpg',
      lastMessage: _messageController.text,
      timestamp: DateTime.now(),
      unreadCount: 0,
      isOnline: true,
      role: 'User',
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    // Scroll to bottom after sending a message
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );

    // Simulate a reply after a delay
    Future.delayed(const Duration(seconds: 1), () {
      final replyMessage = Message(
        id: 'MSG-${_messages.length + 1}',
        senderId: widget.participantId,
        senderName: widget.participantName,
        senderImage: widget.participantImage,
        lastMessage: 'Thank you for sharing that with me. It\'s important to acknowledge these feelings.',
        timestamp: DateTime.now(),
        unreadCount: 0,
        isOnline: true,
        role: widget.role,
      );

      setState(() {
        _messages.add(replyMessage);
      });

      // Scroll to bottom after receiving a reply
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.participantImage),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.participantName,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Online',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: Colors.teal.shade700),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.teal.shade700),
            onPressed: () {},
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isMe = message.senderId == 'current-user';
                  return ChatBubble(
                    message: message,
                    isMe: isMe,
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.teal.shade400),
            onPressed: () {},
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Share your thoughts...',
                  border: InputBorder.none,
                ),
                textCapitalization: TextCapitalization.sentences,
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Colors.teal.shade600),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe)
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(message.senderImage),
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isMe ? Colors.teal.shade600 : Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.lastMessage,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: isMe ? Colors.white70 : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 24),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    return DateFormat('hh:mm a').format(timestamp);
  }
}

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<Message> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _filteredContacts = List.from(dummyMessages);
    _searchController.addListener(_filterContacts);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = List.from(dummyMessages);
      } else {
        _filteredContacts = dummyMessages
            .where((message) => message.senderName.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connect with Support',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.teal.shade700),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.teal.shade400),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search support contacts...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: _filteredContacts.isEmpty
                  ? _buildEmptyState()
                  : _buildContactsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_search_outlined,
            size: 80,
            color: Colors.teal.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 20),
          Text(
            'No support contacts found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.teal.shade700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Try a different search term',
            style: TextStyle(
              fontSize: 14,
              color: Colors.teal.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = _filteredContacts[index];
        return ContactCard(
          contact: contact,
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (_, __, ___) => ChatScreen(
                  participantId: contact.senderId,
                  participantName: contact.senderName,
                  participantImage: contact.senderImage,
                  role: contact.role,
                ),
                transitionsBuilder: (_, animation, __, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class ContactCard extends StatelessWidget {
  final Message contact;
  final VoidCallback onTap;

  const ContactCard({
    super.key,
    required this.contact,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(contact.senderImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (contact.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.senderName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          contact.role,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.teal.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    contact.isOnline ? 'Available now' : 'Offline',
                    style: TextStyle(
                      fontSize: 14,
                      color: contact.isOnline ? Colors.green.shade700 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.message,
              color: Colors.teal.shade600,
            ),
          ],
        ),
      ),
    );
  }
}