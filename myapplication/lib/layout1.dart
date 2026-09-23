import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    home: LayoutScreen(),
));

class LayoutScreen extends StatelessWidget {
    const LayoutScreen({super.key});

    @override
    Widget build(BuildContext context){
        final List<Map<String, String>> profiles = [
            {
                'name': 'Robert Tony',
                'email': 'tonyquano98@gmail.com',
                'phone': '+250793917259',
                'image': '',
            },
            {
                'name': 'Amelia Zaina',
                'email': 'amelia.zaina@example.com',
                'phone': '0930-503-4823',
                'image': '',
            },
            {
                'name': 'Naomi Perrin',
                'email': 'naomi.perrin@example.com',
                'phone': '06-66-53-70-79',
                'image': '',
            },
            {
                'name': 'Anastasia Fabre',
                'email': 'anastasia.fabre@example.com',
                'phone': '(585)-932-2220',
                'image': '',
            },
            {
                'name': 'Pinja Rantala',
                'email': 'pinja.rantala@example.com',
                'phone': '044-398-65-46',
                'image': '',
            },
            {
                'name': 'Yair Klinkert',
                'email': 'yair.klinkert@example.com',
                'phone': '(803)-502-6222',
                'image': '',
            },
            {
                'name': 'Kristen Stanley',
                'email': 'kristen.stanley@example.com',
                'phone': '044-398-65-46',
                'image': '',
            },
            {
                'name': 'Chloe Renaud',
                'email': 'chloe.renaud@example.com',
                'phone': '(803)-502-6222',
                'image': '',
            },
        ];

        return Scaffold(
            appBar: AppBar(
                title: Text('Ch 5: Layouts', style: TextStyle(color: Colors.white),),
                backgroundColor: Colors.lightBlue[600],
                centerTitle: true,
            ),
            body: GridView.builder(
                padding: const EdgeInsets.all(2.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 2.0,
                ),
                itemCount: profiles.length,
                itemBuilder: (context, index){
                    final profile = profiles[index];
                    return ProfileCard(
                        name: profile['name']!,
                        email: profile['email']!,
                        phone: profile['phone']!,
                        imageUrl: profile['image']!,                        
                    );
                }
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: (){},
                backgroundColor: Colors.lightBlue,
                child: const Icon(Icons.add, color: Colors.white),
            ),
        );
    }
}

class ProfileCard extends StatelessWidget{
    final String name;
    final String email;
    final String phone;
    final String imageUrl;

    const ProfileCard({
        super.key,
        required this.name,
        required this.email,
        required this.phone,
        required this.imageUrl,
    });

    @override
    Widget build(BuildContext context){
        return Stack(
            fit: StackFit.expand,
            children: [
                Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                ),
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
                                shadows: [
                                    Shadow(
                                        offset: Offset(1, 1),
                                        blurRadius: 3.0,
                                        color: Colors.black87,
                                    )
                                ],
                            ),
                        ),
                    ),
                ),
                
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: double.infinity,
                        color: Colors.black.withValues(alpha: 0.5),
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    'Email: \n$email',
                                    style: const TextStyle(
                                        color:Colors.white,
                                        fontSize: 10,                    
                                    ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                    'Phone: $phone',
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