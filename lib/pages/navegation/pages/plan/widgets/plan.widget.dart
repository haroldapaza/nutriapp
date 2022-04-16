import 'package:flutter/material.dart';
import 'package:nutriapp/pages/navegation/pages/plan/widgets/divider.widget.dart';
import 'package:nutriapp/pages/navegation/widgets/menu.dart';

class Plan extends StatefulWidget {
  const Plan({Key? key}) : super(key: key);

  @override
  _PlanState createState() => _PlanState();
}

class _PlanState extends State<Plan> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: Menu(),
      body: DividerPlan()
    );
  }
}