import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color.fromRGBO(37, 45, 54, 0.8),
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: const Icon(
                    Icons.person,
                    size: 70,
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Jeong Dongmin",
                  style: TextStyle(
                      color: Color.fromRGBO(37, 45, 54, 0.8),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  " Recyle Today : 5 Contributes ",
                  style: TextStyle(
                      color: Color.fromRGBO(37, 45, 54, 0.8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  " Points : 12300 points ",
                  style: TextStyle(
                      color: Color.fromRGBO(37, 45, 54, 0.8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                // SizedBox(
                //   height: 2,
                // ),
                Text(
                  " Rank : Planter 🌽",
                  style: TextStyle(
                      color: Color.fromRGBO(37, 45, 54, 0.8),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
