import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final String description;
  final IconData icon;
  final int duration;
  const MenuCard({super.key, required this.description, required this.icon, required this.duration});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TweenAnimationBuilder<double>(
      duration: Duration(seconds: widget.duration + 2),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0.0, end: 40.0),
      child: Text(widget.description, style: theme.textTheme.bodyLarge),
      builder: (context, size, child) {
        return Card(
          shadowColor: theme.primaryColor,
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Icon(widget.icon, size: size), child!],
          ),
        );
      },
    );
  }
}
