import 'package:flutter/material.dart';
import 'package:varyrecycle/widgets/count_graph.dart';
import 'package:varyrecycle/widgets/home_user_card.dart';
import 'package:varyrecycle/widgets/recycle_records.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 247, 232, 1),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Row(
              children: const [
                Icon(
                  Icons.recycling,
                  color: Colors.lightGreen,
                  size: 30,
                ),
                Text(
                  "VaryRecycle",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: LineChartSample2(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: UserCard(),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: RecycleRecords(),
            ),
          ],
        ),
      ),
    );
  }
}
