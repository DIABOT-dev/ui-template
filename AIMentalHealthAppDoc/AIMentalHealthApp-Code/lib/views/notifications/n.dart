import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


// Notification type enum
enum NotificationType { reminder, alert, update }

// Notification model
class NotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime time;
  final NotificationType type;
  late final bool isRead;
  final String? imageUrl;
  final String? senderName;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.time,
    required this.type,
    this.isRead = false,
    this.imageUrl,
    this.senderName,
  });
}

// Main notifications screen
class NotificationsScreenssssss extends StatefulWidget {
  const NotificationsScreenssssss({super.key});

  @override
  NotificationsScreenssssssState createState() => NotificationsScreenssssssState();
}

class NotificationsScreenssssssState extends State<NotificationsScreenssssss> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  List<NotificationModel> notifications = [
    NotificationModel(
      id: 1,
      title: 'Mindfulness Reminder',
      body: 'Take a moment to breathe and center yourself',
      time: DateTime.now().subtract(const Duration(minutes: 15)),
      type: NotificationType.reminder,
      senderName: 'Dr. Sarah Johnson',
    ),
    NotificationModel(
      id: 2,
      title: 'New Meditation Available',
      body: 'Check out our new "Ocean Waves" meditation session',
      time: DateTime.now().subtract(const Duration(hours: 2)),
      type: NotificationType.update,
      imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
      senderName: 'Mindful App',
    ),
    NotificationModel(
      id: 3,
      title: 'Appointment Reminder',
      body: 'Your therapy session is tomorrow at 3:00 PM',
      time: DateTime.now().subtract(const Duration(hours: 5)),
      type: NotificationType.alert,
      senderName: 'Dr. Michael Chen',
    ),
    NotificationModel(
      id: 4,
      title: 'Weekly Progress Report',
      body: 'Your mood has improved by 15% this week',
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.update,
      senderName: 'Mental Health Tracker',
    ),
    NotificationModel(
      id: 5,
      title: 'Community Event',
      body: 'Join our virtual support group meeting tonight',
      time: DateTime.now().subtract(const Duration(days: 1)),
      type: NotificationType.reminder,
      imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
      senderName: 'Community Manager',
    ),
  ];

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
        title: const Text('Notifications'),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: NotificationCard(
                      notification: notifications[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationDetailScreen(
                              notification: notifications[index],
                            ),
                          ),
                        );
                      },
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.shade400,
            Colors.teal.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.notifications_active,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 10),
              const Text(
                'Your Notifications',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${notifications.where((n) => !n.isRead).length} new',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      for (var notification in notifications) {
                        notification.isRead = true;
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Mark all as read'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationHistoryScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal.shade600,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('View History'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Notification card widget
class NotificationCard extends StatefulWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationCard({super.key,
    required this.notification,
    required this.onTap,
  });

  @override
  NotificationCardState createState() => NotificationCardState();
}

class NotificationCardState extends State<NotificationCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isHovered = true),
      onTapUp: (_) => setState(() => _isHovered = false),
      onTapCancel: () => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.translationValues(0, _isHovered ? -5 : 0, 0),
        decoration: BoxDecoration(
          color: widget.notification.isRead
              ? Colors.grey.withValues(alpha: 0.1)
              : Colors.teal.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: _isHovered ? 0.2 : 0.1),
              blurRadius: _isHovered ? 10 : 6,
              offset: Offset(0, _isHovered ? 4 : 2),
            ),
          ],
          border: Border.all(
            color: widget.notification.isRead
                ? Colors.grey.withValues(alpha: 0.2)
                : Colors.teal.withValues(alpha: 0.3),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildNotificationIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.notification.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: widget.notification.isRead
                                  ? Colors.grey.shade700
                                  : Colors.teal.shade800,
                            ),
                          ),
                        ),
                        if (!widget.notification.isRead)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.teal.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.notification.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          if (widget.notification.senderName != null) ...[
                            Icon(
                              Icons.person,
                              size: 14,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              widget.notification.senderName!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(width: 12),
                          ],
                          Icon(
                            Icons.access_time,
                            size: 14,
                            color: Colors.grey.shade500,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatTime(widget.notification.time),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.notification.imageUrl != null) ...[
                const SizedBox(width: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.notification.imageUrl!,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon() {
    IconData icon;
    Color color;

    switch (widget.notification.type) {
      case NotificationType.reminder:
        icon = Icons.notifications;
        color = Colors.blue;
        break;
      case NotificationType.alert:
        icon = Icons.warning;
        color = Colors.orange;
        break;
      case NotificationType.update:
        icon = Icons.info;
        color = Colors.teal;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: color,
        size: 24,
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hr ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM d').format(time);
    }
  }
}

// Notification detail screen
class NotificationDetailScreen extends StatefulWidget {
  final NotificationModel notification;

  const NotificationDetailScreen({super.key, required this.notification});

  @override
  NotificationDetailScreenState createState() => NotificationDetailScreenState();
}

class NotificationDetailScreenState extends State<NotificationDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _scaleController.forward();
    _slideController.forward();

    // Mark notification as read
    widget.notification.isRead = true;
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Details'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SlideTransition(
              position: _slideAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _getNotificationColor().withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _getNotificationIcon(),
                            color: _getNotificationColor(),
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              widget.notification.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: _getNotificationColor(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        widget.notification.body,
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          if (widget.notification.senderName != null) ...[
                            const Icon(Icons.person, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              widget.notification.senderName!,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 16),
                          ],
                          const Icon(Icons.access_time, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('MMM d, yyyy • h:mm a').format(widget.notification.time),
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            if (widget.notification.imageUrl != null) ...[
              SlideTransition(
                position: _slideAnimation,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    widget.notification.imageUrl!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
            SlideTransition(
              position: _slideAnimation,
              child: _buildActionButtons(),
            ),
            const SizedBox(height: 30),
            SlideTransition(
              position: _slideAnimation,
              child: _buildRelatedContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  // Show snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Action completed successfully'),
                      backgroundColor: Colors.teal.shade400,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Take Action'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.teal.shade400,
                  side: BorderSide(color: Colors.teal.shade400),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Dismiss'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRelatedContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Related Content',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildRelatedCard(
                'Meditation Guide',
                'Learn mindfulness techniques',
                Icons.self_improvement,
                Colors.purple,
              ),
              const SizedBox(width: 16),
              _buildRelatedCard(
                'Breathing Exercises',
                'Reduce stress in 5 minutes',
                Icons.air,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildRelatedCard(
                'Sleep Stories',
                'Improve your sleep quality',
                Icons.bedtime,
                Colors.indigo,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedCard(String title, String subtitle, IconData icon, Color color) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getNotificationIcon() {
    switch (widget.notification.type) {
      case NotificationType.reminder:
        return Icons.notifications;
      case NotificationType.alert:
        return Icons.warning;
      case NotificationType.update:
        return Icons.info;
    }
  }

  Color _getNotificationColor() {
    switch (widget.notification.type) {
      case NotificationType.reminder:
        return Colors.blue;
      case NotificationType.alert:
        return Colors.orange;
      case NotificationType.update:
        return Colors.teal;
    }
  }
}

// Notification settings screen
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  NotificationSettingsScreenState createState() => NotificationSettingsScreenState();
}

class NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool _mindfulnessReminders = true;
  bool _appointmentAlerts = true;
  bool _newContentUpdates = true;
  bool _communityEvents = false;
  bool _weeklyReports = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Settings'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Notification Types'),
            const SizedBox(height: 16),
            _buildSettingSwitch(
              'Mindfulness Reminders',
              'Daily reminders for meditation and breathing exercises',
              _mindfulnessReminders,
                  (value) => setState(() => _mindfulnessReminders = value),
              Icons.self_improvement,
              Colors.teal,
            ),
            _buildSettingSwitch(
              'Appointment Alerts',
              'Reminders for therapy sessions and appointments',
              _appointmentAlerts,
                  (value) => setState(() => _appointmentAlerts = value),
              Icons.event,
              Colors.blue,
            ),
            _buildSettingSwitch(
              'New Content Updates',
              'Notifications about new meditations and articles',
              _newContentUpdates,
                  (value) => setState(() => _newContentUpdates = value),
              Icons.new_releases,
              Colors.purple,
            ),
            _buildSettingSwitch(
              'Community Events',
              'Invitations to virtual support groups and events',
              _communityEvents,
                  (value) => setState(() => _communityEvents = value),
              Icons.groups,
              Colors.orange,
            ),
            _buildSettingSwitch(
              'Weekly Reports',
              'Summary of your mood and progress',
              _weeklyReports,
                  (value) => setState(() => _weeklyReports = value),
              Icons.insights,
              Colors.indigo,
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Notification Preferences'),
            const SizedBox(height: 16),
            _buildTimePicker(),
            const SizedBox(height: 20),
            _buildSettingSwitch(
              'Sound',
              'Play sound for notifications',
              _soundEnabled,
                  (value) => setState(() => _soundEnabled = value),
              Icons.volume_up,
              Colors.grey,
            ),
            _buildSettingSwitch(
              'Vibration',
              'Vibrate for notifications',
              _vibrationEnabled,
                  (value) => setState(() => _vibrationEnabled = value),
              Icons.vibration,
              Colors.grey,
            ),

            const SizedBox(height: 30),
            _buildSectionTitle('Quiet Hours'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.nightlight, color: Colors.indigo),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'No notifications between',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('10:00 PM'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Text('to'),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('7:00 AM'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Settings saved successfully'),
                      backgroundColor: Colors.teal.shade400,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade400,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }

  Widget _buildSettingSwitch(
      String title,
      String subtitle,
      bool value,
      Function(bool) onChanged,
      IconData icon,
      Color color,
      ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.teal.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.access_time, color: Colors.teal),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Daily Reminder Time',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'When to receive mindfulness reminders',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () async {
              final TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: _reminderTime,
              );
              if (picked != null) {
                setState(() {
                  _reminderTime = picked;
                });
              }
            },
            child: Text(
              _reminderTime.format(context),
              style: TextStyle(
                color: Colors.teal.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Notification history screen
class NotificationHistoryScreen extends StatefulWidget {
  const NotificationHistoryScreen({super.key});

  @override
  NotificationHistoryScreenState createState() => NotificationHistoryScreenState();
}

class NotificationHistoryScreenState extends State<NotificationHistoryScreen> {
  List<NotificationModel> historyNotifications = [
    NotificationModel(
      id: 6,
      title: 'Mood Check-in',
      body: 'How are you feeling today? Take a moment to check in',
      time: DateTime.now().subtract(const Duration(days: 2)),
      type: NotificationType.reminder,
      senderName: 'Mental Health Tracker',
    ),
    NotificationModel(
      id: 7,
      title: 'New Article Available',
      body: 'Read "5 Ways to Improve Your Sleep Quality"',
      time: DateTime.now().subtract(const Duration(days: 3)),
      type: NotificationType.update,
      senderName: 'Mindful App',
    ),
    NotificationModel(
      id: 8,
      title: 'Session Completed',
      body: 'Your therapy session has been completed successfully',
      time: DateTime.now().subtract(const Duration(days: 4)),
      type: NotificationType.alert,
      senderName: 'Dr. Sarah Johnson',
    ),
    NotificationModel(
      id: 9,
      title: 'Achievement Unlocked',
      body: 'You\'ve completed 7 days of mindfulness practice!',
      time: DateTime.now().subtract(const Duration(days: 5)),
      type: NotificationType.update,
      imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
      senderName: 'Mindful App',
    ),
    NotificationModel(
      id: 10,
      title: 'Weekly Challenge',
      body: 'Try our new "Gratitude Journal" challenge this week',
      time: DateTime.now().subtract(const Duration(days: 6)),
      type: NotificationType.reminder,
      senderName: 'Community Manager',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification History'),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: historyNotifications.length,
              itemBuilder: (context, index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: NotificationCard(
                    notification: historyNotifications[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationDetailScreen(
                            notification: historyNotifications[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.teal.shade400,
            Colors.teal.shade600,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.history,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 10),
              const Text(
                'Notification History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      historyNotifications.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Clear History'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal.shade600,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Back to Notifications'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}