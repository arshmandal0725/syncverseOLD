import 'package:flutter/material.dart';

class MySubscription extends StatefulWidget {
  const MySubscription({super.key});

  @override
  State<MySubscription> createState() => _MySubscriptionState();
}

class _MySubscriptionState extends State<MySubscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF152D5E),
        title: Text("Subscription"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Your current plan will be end on 10/8/23",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              )),
          ListTile(
            title: Text("Plan Price"),
            subtitle: Text("4000"),
          ),
          ListTile(
            title: Text("Next billing date"),
            subtitle: Text("28/11/23"),
          ),
          ListTile(
            title: Text("Extend plan"),
            subtitle: Text("See the plan"),
          ),
          ListTile(
            title: Text("Past Reciepts"),
            subtitle: Text("View on the web"),
          ),
          ListTile(
            title: Text("Payment Help"),
            subtitle: Text("View on the web"),
          ),
          const Divider(
            thickness: 2,
          ),
          Text(
            "Cancel Subscription",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          )
        ],
      ),
    );
  }
}
