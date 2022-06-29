import 'dart:math';

import 'package:flutter/material.dart';

class SliverAppBarApp extends StatelessWidget {
  const SliverAppBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('SliverAppBar'),
            background: Image.asset("images/head.jpg"),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.green,
                height: 100.0,
                child: Center(
                  child: ListTile(
                    title: Text(
                      '1888888888' + index.toString(),
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.contact_phone,
                      color: Colors.blue[500],
                    ),
                  ),
                ),
              );
            },
            childCount: 15,
          ),
        ),
      ],
    );
  }
}
