import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // app name
          const Text(
            'NhamFood',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)
            
          ),

          const SizedBox(height: 8),
          const Text('Version 1.0.0'),

          const Divider(height: 32),

          // about
         
          const SizedBox(height: 6),
          const Text(
            'This is a school project built with Flutter.\n'
            'National University of Managment.\n'
  
          ),

          const Divider(height: 32),

          // team members
          const Text(
            'Team Members',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),

          _member('1.', 'Phorn Sopheak'),
          _member('2.', 'Dary Azan'),
          _member('3.', 'Thoeurn Sovanhang'),
          _member('4.', 'Mouern ChanThā'),
         
          const Divider(height: 32),

          // api credit
        ],
      ),
    );
  }

  Widget _member(String num, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(num, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(width: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w500)),
          
        ],
      ),
    );
  }
}