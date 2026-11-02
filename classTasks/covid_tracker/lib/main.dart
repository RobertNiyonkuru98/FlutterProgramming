import 'package:flutter/material.dart';
import 'widgets/covid_card.dart';

void main() {
  runApp(const CovidTrackerApp());
}

class CovidTrackerApp extends StatelessWidget {
  const CovidTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'COVID-19 Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF141414), // Dark background matching mockup
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141414),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const CovidDashboardScreen(),
    );
  }
}

class CovidDashboardScreen extends StatelessWidget {
  const CovidDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COVID-19 Tracker'),
      ),
      // Vertically scrollable layout meeting the assignment requirement
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        physics: const BouncingScrollPhysics(),
        children: const [
          // 1. Total Cases Card
          CovidCard(
            title: 'Total Cases',
            count: 9231249,
            icon: Icons.calculate_outlined,
            color: Color(0xFFE5B869), // Warm gold/yellow
          ),

          // 2. Active Cases Card
          CovidCard(
            title: 'Active Cases',
            count: 123214,
            icon: Icons.thermostat_outlined,
            color: Color(0xFFE09F3E), // Amber/orange
          ),

          // 3. Deaths Card
          CovidCard(
            title: 'Deaths',
            count: 51245,
            icon: Icons.dangerous_outlined,
            color: Color(0xFFE63946), // Red
          ),

          // 4. Recovered Card
          CovidCard(
            title: 'Recovered',
            count: 7452340,
            icon: Icons.health_and_safety_outlined,
            color: Color(0xFF588157), // Green
          ),
        ],
      ),
    );
  }
}
