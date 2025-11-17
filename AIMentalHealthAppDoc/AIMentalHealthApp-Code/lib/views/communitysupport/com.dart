import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// --- Global Constants and Helper Functions ---

// Helper function to convert opacity (0.0 to 1.0) to an alpha value (0 to 255).
// We use this to satisfy the specific requirement for opacity replacement.
int alphaFromOpacity(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

// Custom Colors based on the design's earthy palette
const Color primaryColor = Color(0xFF6B423D); // Dark Reddish Brown
const Color accentGreen = Color(0xFF5B7E5D); // Muted Green
const Color subtleBackground = Color(0xFFF7F4F0);
const Color cardColor = Colors.white;

// Font size constants for consistency
const double headingSize = 24.0;
const double titleSize = 18.0;
const double bodySize = 14.0;
const double iconSize = 20.0;
const double smallIconSize = 16.0;

// Placeholder asset paths (replace with your actual asset paths)
const String welcomeImagePath = 'https://img.freepik.com/free-vector/glowing-red-neon-valentines-day-lovely-heart-background_1017-42740.jpg?semt=ais_incoming&w=740&q=80';
const String meditationImagePath = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9Eo2eO5ioH9DPvNjbimZZAp8UdqZQWJFujg&s';
const String postSuccessImagePath = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAGzDC1ic96hA_xeSXop9QasU2W94sSDRlZA&s';

// Placeholder function for random user images
String getRandomUserImageUrl(String gender, int index) {
  final type = gender == 'men' ? 'men' : 'women';
  return 'https://randomuser.me/api/portraits/$type/$index.jpg';
}

// --- Data Models (Enums and Classes) ---

// Required enum with lowercase properties
enum PostType { media, affirmation, journal, event, thought, question }
enum NotificationStatus { newStatus, seen }

class PostData {
  final String user;
  final String profileUrl;
  final String timeAgo;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;

  PostData({
    required this.user,
    required this.profileUrl,
    required this.timeAgo,
    required this.content,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
  });
}

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final PostType type;
  final NotificationStatus status;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.status = NotificationStatus.newStatus,
  });
}

// --- Dummy Data ---

final List<PostData> dummyFeed = [
  PostData(
    user: 'Shirvani Ropgun',
    profileUrl: getRandomUserImageUrl('men', 11),
    timeAgo: '12m ago',
    content: 'Feeling grounded and centered after my morning meditation. Remember to breathe deeply!',
    imageUrl: 'assets/meditation_post.png', // Placeholder
    likes: 120,
    comments: 25,
  ),
  PostData(
    user: 'Malenia S. Smith',
    profileUrl: getRandomUserImageUrl('women', 7),
    timeAgo: '1h ago',
    content: 'What is your favorite way to reconnect with nature during a busy week?',
    likes: 58,
    comments: 15,
  ),
  PostData(
    user: 'Kallisto K. Davis',
    profileUrl: getRandomUserImageUrl('men', 4),
    timeAgo: '3h ago',
    content: 'Sharing a quick affirmation for anyone who needs it today: "I am worthy of all the good things coming my way."',
    likes: 210,
    comments: 32,
  ),
];

final List<NotificationItem> dummyNotifications = [
  NotificationItem(
    title: 'New Comment',
    message: 'Sarah commented on your latest post: "So true!"',
    time: '2 hours ago',
    type: PostType.thought,
    status: NotificationStatus.newStatus,
  ),
  NotificationItem(
    title: 'Community Event',
    message: 'The Weekly Mindful Meetup is starting in 10 minutes.',
    time: 'Yesterday',
    type: PostType.event,
    status: NotificationStatus.seen,
  ),
  NotificationItem(
    title: 'Like Alert',
    message: 'Alex liked your photo post from yesterday.',
    time: '2 days ago',
    type: PostType.media,
    status: NotificationStatus.seen,
  ),
];

// --- Widgets for Reusable Components ---

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool hasBorder;

  const UserAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 20,
    this.hasBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: hasBorder
            ? Border.all(
          color: accentGreen,
          width: 2,
        )
            : null,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: subtleBackground,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = primaryColor,
    this.textColor = Colors.white,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 50),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FaIcon(icon, color: textColor, size: 18),
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;

  const WhiteCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.radius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: padding,
      child: child,
    );
  }
}

// --- Screen Implementations ---

// 1. Welcome Screen

// 2. Community Feed Screen
class CommunityFeedScreen extends StatelessWidget {
  const CommunityFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(),
        title: const Text(
          'Community Support',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.bell, color: primaryColor, size: smallIconSize),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CommunityNotificationScreen()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(bottom: 80),
            children: [

              ...dummyFeed.map((post) => PostItem(post: post)),
              const SizedBox(height: 20),
              UserHostingCard(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostDetailScreen()),
                  );
                },
              ),
            ],
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNewPostScreen()),
                );
              },
              backgroundColor: accentGreen,
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class UserHostingCard extends StatelessWidget {
  final VoidCallback onTap;

  const UserHostingCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(
                    imageUrl: getRandomUserImageUrl('men', 8),
                    radius: 25,
                    hasBorder: true,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Malenia S. Smith',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
                  ),
                ],
              ),
              Text(
                'HOST',
                style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Hosting a small discussion about mindful eating. Join us!',
            style: TextStyle(fontSize: bodySize),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Join Now', style: TextStyle(color: accentGreen, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  FaIcon(FontAwesomeIcons.arrowRight, color: accentGreen, size: smallIconSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final PostData post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4.0),
      child: WhiteCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                UserAvatar(imageUrl: post.profileUrl, radius: 18),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.user,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
                    ),
                    Text(
                      post.timeAgo,
                      style: TextStyle(color: Colors.grey[600], fontSize: bodySize - 2),
                    ),
                  ],
                ),
                const Spacer(),
                FaIcon(FontAwesomeIcons.ellipsisVertical, color: Colors.grey[400], size: smallIconSize),
              ],
            ),
            const SizedBox(height: 12),
            Text(post.content, style: const TextStyle(fontSize: bodySize)),
            if (post.imageUrl != null) ...[
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    meditationImagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      width: double.infinity,
                      color: subtleBackground,
                      child: Center(
                        child: Text('Image Placeholder for: ${post.user}', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 12),
            Divider(color: Colors.grey[200], thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PostAction(
                  icon: FontAwesomeIcons.solidHeart,
                  count: post.likes,
                  color: primaryColor,
                ),
                PostAction(
                  icon: FontAwesomeIcons.solidMessage,
                  count: post.comments,
                  color: accentGreen,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PostDetailScreen()),
                    );
                  },
                ),
                PostAction(
                  icon: FontAwesomeIcons.shareFromSquare,
                  count: null,
                  color: Colors.grey[600]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PostAction extends StatelessWidget {
  final IconData icon;
  final int? count;
  final Color color;
  final VoidCallback? onTap;

  const PostAction({super.key,
    required this.icon,
    this.count,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            FaIcon(icon, size: smallIconSize, color: color),
            if (count != null) ...[
              const SizedBox(width: 8),
              Text(
                '$count',
                style: TextStyle(color: color, fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// 3. Add New Post Screen
class AddNewPostScreen extends StatelessWidget {
  const AddNewPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subtleBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.xmark, color: primaryColor, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add New Post',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What would you like to share?',
              style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600, color: primaryColor),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _PostTypeButton(
                  icon: FontAwesomeIcons.images,
                  label: 'Media',
                  type: PostType.media,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostDraftScreen(type: PostType.media)),
                    );
                  },
                ),
                _PostTypeButton(
                  icon: FontAwesomeIcons.solidCommentDots,
                  label: 'Journal',
                  type: PostType.journal,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostDraftScreen(type: PostType.journal)),
                    );
                  },
                ),
                _PostTypeButton(
                  icon: FontAwesomeIcons.solidSun,
                  label: 'Affirmation',
                  type: PostType.affirmation,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostDraftScreen(type: PostType.affirmation)),
                    );
                  },
                ),
                _PostTypeButton(
                  icon: FontAwesomeIcons.lightbulb,
                  label: 'Thought',
                  type: PostType.thought,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostDraftScreen(type: PostType.thought)),
                    );
                  },
                ),
                _PostTypeButton(
                  icon: FontAwesomeIcons.solidCalendarCheck,
                  label: 'Event',
                  type: PostType.event,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostDraftScreen(type: PostType.event)),
                    );
                  },
                ),
                _PostTypeButton(
                  icon: FontAwesomeIcons.solidCircleQuestion,
                  label: 'Question',
                  type: PostType.question,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PostDraftScreen(type: PostType.question)),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final PostType type;
  final VoidCallback onTap;

  const _PostTypeButton({
    required this.icon,
    required this.label,
    required this.type,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color typeColor;
    switch (type) {
      case PostType.media:
        typeColor = accentGreen;
        break;
      case PostType.affirmation:
        typeColor = Colors.orange;
        break;
      case PostType.journal:
        typeColor = Colors.purple;
        break;
      case PostType.event:
        typeColor = Colors.teal;
        break;
      case PostType.thought:
        typeColor = Colors.pink;
        break;
      case PostType.question:
        typeColor = primaryColor;
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: WhiteCard(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: typeColor.withAlpha(alphaFromOpacity(0.1)),
              ),
              child: FaIcon(icon, color: typeColor, size: iconSize),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(color: typeColor, fontWeight: FontWeight.w600, fontSize: bodySize - 1),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Post Draft Screen
class PostDraftScreen extends StatelessWidget {
  final PostType type;

  const PostDraftScreen({super.key, required this.type});

  String get _typeTitle {
    return 'New ${type.toString().split('.').last[0].toUpperCase()}${type.toString().split('.').last.substring(1)} Post';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subtleBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.arrowLeft, color: primaryColor, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _typeTitle,
          style: const TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Drafts (2)',
              style: TextStyle(color: primaryColor.withAlpha(alphaFromOpacity(0.7))),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                UserAvatar(imageUrl: getRandomUserImageUrl('women', 12), radius: 20),
                const SizedBox(width: 12),
                const Text('Shirvani Ropgun', style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize)),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: WhiteCard(
                padding: const EdgeInsets.all(0),
                child: TextField(
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(
                    hintText: "What's on your mind? Share your feelings...",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DraftActionIcon(icon: FontAwesomeIcons.camera, color: accentGreen, label: 'Add Photo'),
                _DraftActionIcon(icon: FontAwesomeIcons.tag, color: primaryColor, label: 'Tag Friends'),
                _DraftActionIcon(icon: FontAwesomeIcons.camera, color: Colors.orange, label: 'Add Location'),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(alphaFromOpacity(0.05)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.lock, color: primaryColor, size: smallIconSize),
                  const SizedBox(width: 10),
                  const Text('Hide from your community', style: TextStyle(color: primaryColor)),
                  const Spacer(),
                  const Icon(Icons.toggle_on_rounded, color: accentGreen, size: 30),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: 'Post',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PostSuccessfulScreen()),
                );
              },
            ),
            const SizedBox(height: 10),
            CustomButton(
              text: 'Save as Draft',
              onPressed: () => Navigator.pop(context),
              backgroundColor: Colors.white,
              textColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

class _DraftActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const _DraftActionIcon({required this.icon, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withAlpha(alphaFromOpacity(0.15)),
          ),
          child: FaIcon(icon, color: color, size: smallIconSize),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: bodySize - 2, color: Colors.grey[600])),
      ],
    );
  }
}

// 5. Post Successful Screen
class PostSuccessfulScreen extends StatelessWidget {
  const PostSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                postSuccessImagePath,
                height: 300,
                errorBuilder: (context, error, stackTrace) => FaIcon(
                  FontAwesomeIcons.solidCircleCheck,
                  size: 150,
                  color: accentGreen,
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Post Successful!',
                style: TextStyle(
                  fontSize: headingSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your new post has been published to the community feed. You can view it now.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: bodySize,
                  color: Colors.white.withAlpha(alphaFromOpacity(0.8)),
                ),
              ),
              const SizedBox(height: 40),
              CustomButton(
                text: 'See Your Post',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PostDetailScreen()),
                  );
                },
                backgroundColor: accentGreen,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate back to the main feed
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  'Go Back Home',
                  style: TextStyle(
                    color: Colors.white.withAlpha(alphaFromOpacity(0.9)),
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

// 6. Community Notification Screen
class CommunityNotificationScreen extends StatelessWidget {
  const CommunityNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subtleBackground,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Community Notification',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Filter Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FilterScreen()),
                );
              },
              icon: FaIcon(FontAwesomeIcons.sliders, size: smallIconSize, color: primaryColor),
              label: Text('Filter', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
            ),
          ),
          _NotificationSection(title: 'Today', items: dummyNotifications.take(1).toList()),
          _NotificationSection(title: 'Yesterday', items: dummyNotifications.skip(1).take(1).toList()),
          _NotificationSection(title: 'Last Week', items: dummyNotifications.skip(2).toList()),
        ],
      ),
    );
  }
}

class _NotificationSection extends StatelessWidget {
  final String title;
  final List<NotificationItem> items;

  const _NotificationSection({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold, color: primaryColor),
          ),
        ),
        WhiteCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: items.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FaIcon(
                      item.type == PostType.event ? FontAwesomeIcons.solidCalendarCheck : FontAwesomeIcons.solidMessage,
                      color: item.status == NotificationStatus.newStatus ? accentGreen : Colors.grey[400],
                      size: iconSize,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: bodySize,
                              color: item.status == NotificationStatus.newStatus ? primaryColor : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.message,
                            style: TextStyle(fontSize: bodySize - 2, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.time,
                            style: TextStyle(
                              fontSize: bodySize - 4,
                              color: accentGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

// 7. Filter/Settings Screen
class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subtleBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: FaIcon(FontAwesomeIcons.xmark, color: primaryColor, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Filter Notifications',
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _FilterOption(label: 'All Notifications', isSelected: true),
            _FilterOption(label: 'Comments & Replies', isSelected: false),
            _FilterOption(label: 'Likes', isSelected: false),
            _FilterOption(label: 'Mentions & Tags', isSelected: false),
            _FilterOption(label: 'Community Events', isSelected: false),
            const Spacer(),
            CustomButton(
              text: 'Apply Filters',
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterOption({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: WhiteCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: titleSize,
                color: isSelected ? primaryColor : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? accentGreen : Colors.white,
                border: Border.all(
                  color: isSelected ? accentGreen : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

// 8. Post Detail/User Profile Screen
class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock the post detail
    final post = dummyFeed.first;

    return Scaffold(
      backgroundColor: subtleBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: primaryColor,
            elevation: 0,
            expandedHeight: 250.0,
            floating: true,
            pinned: true,
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: iconSize),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                meditationImagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: primaryColor,
                  child: const Center(
                    child: Text('Post Image', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.ellipsisVertical, color: Colors.white, size: smallIconSize),
                onPressed: () {
                  // Show delete post modal
                  showDeletePostModal(context);
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PostHeader(post: post),
                      const SizedBox(height: 16),
                      Text(post.content, style: const TextStyle(fontSize: bodySize)),
                      const SizedBox(height: 16),
                      Divider(color: Colors.grey[200]),
                      _PostActionsRow(post: post),
                      Divider(color: Colors.grey[200]),
                      const Text('Comments', style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      ..._buildComments(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _CommentInputBar(),
    );
  }

  List<Widget> _buildComments() {
    return [
      _CommentItem(
        user: 'Malenia S. Smith',
        profileUrl: getRandomUserImageUrl('women', 7),
        timeAgo: '15m ago',
        content: 'This is such a beautiful picture and a great reminder. Thanks for sharing!',
      ),
      _CommentItem(
        user: 'Kallisto K. Davis',
        profileUrl: getRandomUserImageUrl('men', 4),
        timeAgo: '30m ago',
        content: 'Where was this taken? Looks incredibly peaceful.',
      ),
      _CommentItem(
        user: 'Another User',
        profileUrl: getRandomUserImageUrl('women', 1),
        timeAgo: '1h ago',
        content: 'Absolutely agree. Love the positive vibes!',
      ),
    ];
  }
}

class _PostHeader extends StatelessWidget {
  final PostData post;

  const _PostHeader({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(imageUrl: post.profileUrl, radius: 25),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.user,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: titleSize),
            ),
            Text(
              post.timeAgo,
              style: TextStyle(color: Colors.grey[600], fontSize: bodySize - 2),
            ),
          ],
        ),
      ],
    );
  }
}

class _PostActionsRow extends StatelessWidget {
  final PostData post;

  const _PostActionsRow({required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PostAction(
          icon: FontAwesomeIcons.solidHeart,
          count: post.likes,
          color: primaryColor,
        ),
        PostAction(
          icon: FontAwesomeIcons.solidMessage,
          count: post.comments,
          color: accentGreen,
        ),
        PostAction(
          icon: FontAwesomeIcons.shareFromSquare,
          count: null,
          color: Colors.grey[600]!,
        ),
      ],
    );
  }
}

class _CommentItem extends StatelessWidget {
  final String user;
  final String profileUrl;
  final String timeAgo;
  final String content;

  const _CommentItem({
    required this.user,
    required this.profileUrl,
    required this.timeAgo,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(imageUrl: profileUrl, radius: 15),
          const SizedBox(width: 10),
          Expanded(
            child: WhiteCard(
              padding: const EdgeInsets.all(12),
              radius: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: bodySize),
                      ),
                      Text(
                        timeAgo,
                        style: TextStyle(color: Colors.grey[500], fontSize: bodySize - 4),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(content, style: const TextStyle(fontSize: bodySize)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CommentInputBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      radius: 0,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            UserAvatar(imageUrl: getRandomUserImageUrl('men', 20), radius: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: subtleBackground,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.paperPlane, color: accentGreen, size: iconSize),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

// 9. Delete Post Modal (Implemented as a function to show a custom dialog)
void showDeletePostModal(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        child: WhiteCard(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.triangleExclamation,
                color: Colors.orange,
                size: 40,
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Post?',
                style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete this post? This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Cancel',
                      onPressed: () => Navigator.pop(context),
                      backgroundColor: Colors.grey[200]!,
                      textColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      text: 'Yes, Delete',
                      onPressed: () {
                        // Implement deletion logic
                        Navigator.pop(context); // Close modal
                        Navigator.pop(context); // Go back from PostDetailScreen
                      },
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// 10. Chat/Messaging Screen (Simplified version of the last screen)
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: subtleBackground,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: iconSize),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            UserAvatar(imageUrl: getRandomUserImageUrl('women', 13), radius: 18),
            const SizedBox(width: 10),
            const Text(
              'Malenia S. Smith',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.ellipsisVertical, color: Colors.white, size: smallIconSize),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const [
                _ChatBubble(
                  text: 'Hi there! I loved your recent post on mindful eating.',
                  isMe: false,
                ),
                _ChatBubble(
                  text: 'Oh, thank you so much! It means a lot. Do you have any tips?',
                  isMe: true,
                ),
                _ChatBubble(
                  text: 'I try to start my day with a 5-minute gratitude exercise before every meal.',
                  isMe: false,
                ),
              ],
            ),
          ),
          _CommentInputBar(), // Reusing the input bar widget
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isMe;

  const _ChatBubble({required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          padding: const EdgeInsets.all(12),
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          decoration: BoxDecoration(
            color: isMe ? accentGreen : cardColor,
            borderRadius: BorderRadius.circular(16).copyWith(
              topRight: isMe ? Radius.zero : const Radius.circular(16),
              topLeft: isMe ? const Radius.circular(16) : Radius.zero,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(alphaFromOpacity(0.05)),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isMe ? Colors.white : primaryColor,
              fontSize: bodySize,
            ),
          ),
        ),
      ),
    );
  }
}

// --- Main App and Navigation Hub ---

class CommunityApp extends StatelessWidget {
  const CommunityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Community Support UI',
      theme: ThemeData(
        scaffoldBackgroundColor: subtleBackground,
        primaryColor: primaryColor,
        fontFamily: 'Inter', // Assuming Inter or system font for modern look
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: primaryColor,
          displayColor: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: primaryColor),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: accentGreen,
          primary: primaryColor,
        ),
        useMaterial3: true,
      ),
    );
  }
}

void main() {
  // This is a hub screen to show all the created screens.
  // In a real app, you would run the CommunityApp directly.
  runApp(const CommunityApp());
}
