import 'package:app/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class MenuCard extends StatefulWidget {
  final String description;
  final IconData icon;
  final int duration;
  final Function function;
  const MenuCard({
    super.key,
    required this.description,
    required this.icon,
    required this.duration,
    required this.function,
  });

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
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 8,
              color: StudieTheme.primaryColor,
              style: BorderStyle.solid,
            ),
          ),
          color: StudieTheme.whiteSmoke,
          clipBehavior: Clip.hardEdge,
          shadowColor: theme.primaryColor,
          elevation: 10,
          child: Material(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            child: InkWell(
              splashColor: StudieTheme.secondaryColor,
              onTap: () => widget.function(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Icon(widget.icon, size: size), child!],
              ),
            ),
          ),
        );
      },
    );
  }
}
