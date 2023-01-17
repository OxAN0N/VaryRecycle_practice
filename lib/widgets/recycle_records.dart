import 'package:flutter/material.dart';

class RecycleRecords extends StatefulWidget {
  const RecycleRecords({super.key});

  @override
  State<RecycleRecords> createState() => _RecycleRecordsState();
}

class _RecycleRecordsState extends State<RecycleRecords> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 0),
            child: Text(
              "Records",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 45, 54, 0.8),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: Divider(
                  color: Color.fromRGBO(37, 45, 54, 0.15), thickness: 2.0),
            ),
          ),
          for (int i = 0; i < 10; i++)
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Recycle $i",
                style: const TextStyle(color: Color.fromRGBO(37, 45, 54, 0.8)),
              ),
            )
        ],
      ),
    );
  }
}
