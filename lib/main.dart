import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Entry point — boots the Flutter app
void main() {
  runApp(const MyApp());
}

// Data model representing a single blog post
class BlogPost {
  final String title;
  final String description;
  final String author;
  final String date;
  final String imageUrl;

  BlogPost({
    required this.title,
    required this.description,
    required this.author,
    required this.date,
    required this.imageUrl,
  });
}

// Sample data simulating a blog feed (4 posts)
final List<BlogPost> dummyPosts = [
  BlogPost(
    title: 'Getting Started with Flutter',
    description: 'Learn the basics of building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.',
    author: 'Jane Doe',
    date: 'Jun 8, 2026',
    imageUrl: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=400&h=250&fit=crop',
  ),
  BlogPost(
    title: 'Mastering ListView.builder',
    description: 'Discover how to efficiently render long lists in Flutter without compromising performance or memory.',
    author: 'John Smith',
    date: 'Jun 5, 2026',
    imageUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=400&h=250&fit=crop',
  ),
  BlogPost(
    title: 'Modern UI Design Principles',
    description: 'Explore spacing, typography, and elevation to create clean, Medium-style interfaces in your apps.',
    author: 'Alex Johnson',
    date: 'Jun 1, 2026',
    imageUrl: 'https://images.unsplash.com/photo-1507238691740-187a5b1d37b8?w=400&h=250&fit=crop',
  ),
  BlogPost(
    title: 'State Management Simplified',
    description: 'A beginner-friendly guide to understanding Provider, Riverpod, and when to use them.',
    author: 'Sarah Lee',
    date: 'May 28, 2026',
    imageUrl: 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400&h=250&fit=crop',
  ),
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Blog Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        primaryColor: const Color(0xFF111827),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          foregroundColor: Color(0xFF111827),
        ),
      ),
      home: const MyBlogPage(),
    );
  }
}

class MyBlogPage extends StatelessWidget {
  const MyBlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Blog',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          // Property 1: itemCount — tells Flutter how many items to render;
          // prevents infinite scroll and index errors
          itemCount: dummyPosts.length,

          // Property 2: scrollDirection — Axis.vertical scrolls top-to-bottom
          // (default); change to Axis.horizontal for a carousel layout
          scrollDirection: Axis.vertical,

          // Property 3: itemBuilder — lazily builds only visible items on screen;
          // more memory-efficient than ListView(children: []) for long lists
          itemBuilder: (context, index) {
            return BlogCard(post: dummyPosts[index]);
          },
        ),
      ),
    );
  }
}

// Reusable card widget that displays a single blog post
class BlogCard extends StatelessWidget {
  final BlogPost post;

  const BlogCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        // Shows a snackbar with the post title when tapped
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Opened: ${post.title}')),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  post.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  // Fallback grey box if the image fails to load
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF111827),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      post.description,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 14, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          post.author,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey[500]),
                        const SizedBox(width: 4),
                        Text(
                          post.date,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.grey[500],
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
      ),
    );
  }
}