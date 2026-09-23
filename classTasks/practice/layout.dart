import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Layout Practice',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const LayoutScreen(),
    );
  }
}

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data to populate the grid since we don't have the original local images
    final List<Map<String, String>> profiles = [
      {
        'name': 'Joona Joki',
        'email': 'joona.joki@example.com',
        'cell': '042-980-32-24',
        'image': 'https://randomuser.me/api/portraits/men/1.jpg',
      },
      {
        'name': 'Amelia Zaina',
        'email': 'amelia.zaina@example.com',
        'cell': '0930-503-4823',
        'image': 'https://randomuser.me/api/portraits/women/2.jpg',
      },
      {
        'name': 'Naomi Perrin',
        'email': 'naomi.perrin@example.com',
        'cell': '06-66-53-70-79',
        'image': 'https://randomuser.me/api/portraits/women/3.jpg',
      },
      {
        'name': 'Anastasia Fabre',
        'email': 'anastasia.fabre@example.com',
        'cell': '(585)-932-2220',
        'image': 'https://randomuser.me/api/portraits/women/4.jpg',
      },
      {
        'name': 'Pinja Rantala',
        'email': 'pinja.rantala@example.com',
        'cell': '044-398-65-46',
        'image': 'https://randomuser.me/api/portraits/women/5.jpg',
      },
      {
        'name': 'Yair Klinkert',
        'email': 'yair.klinkert@example.com',
        'cell': '(803)-502-6222',
        'image': 'https://randomuser.me/api/portraits/men/6.jpg',
      },
      {
        'name': 'Kristen Stanley',
        'email': 'kristen.stanley@example.com',
        'cell': '044-398-65-46',
        'image': 'https://randomuser.me/api/portraits/women/7.jpg',
      },
      {
        'name': 'Chloe Renaud',
        'email': 'chloe.renaud@example.com',
        'cell': '(803)-502-6222',
        'image': 'https://randomuser.me/api/portraits/women/8.jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: const Icon(Icons.menu, color: Colors.white),
        title: const Text(
          'Ch 5: Layouts',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      // We use a GridView to lay out the items in 2 columns
      body: GridView.builder(
        padding: const EdgeInsets.all(2.0), // Small padding around grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 items per row
          childAspectRatio: 1.0, // Square items
          crossAxisSpacing: 2.0, // Space between columns
          mainAxisSpacing: 2.0, // Space between rows
        ),
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return ProfileCard(
            name: profile['name']!,
            email: profile['email']!,
            cell: profile['cell']!,
            imageUrl: profile['image']!,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

// Custom Widget for each item in the grid
class ProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String cell;
  final String imageUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.cell,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Stack allows us to overlay text on top of the image
    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Background Image
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        // 2. Name aligned at the top center
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                // Add a text shadow so it's readable over light images
                shadows: [
                  Shadow(
                    offset: Offset(1, 1),
                    blurRadius: 3.0,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),
        ),
        // 3. Email and Cell aligned at the bottom inside a translucent box
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: Colors.black.withOpacity(0.5), // Semi-transparent black background
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Email:\n$email',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cell: $cell',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
