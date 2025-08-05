// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String description;
  final IconData icon;
  const MenuCard({super.key, required this.description, required this.icon});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shadowColor: theme.primaryColor,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon),
            Text(description, style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
