import 'package:flutter/material.dart';
import 'package:school_app/core/extensions/context_extension.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  static const routeName = '/dashboard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Center(
        child: Text(
          'DASHBOARD',
          style: context.theme.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
