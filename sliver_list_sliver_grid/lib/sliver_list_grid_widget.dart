import 'dart:math';

import 'package:flutter/material.dart';

class SliverListGridApp extends StatelessWidget {
  const SliverListGridApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 200.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('SliverList and SliverGrid'),
          ),
        ),
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200.0,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 50.0,
            childAspectRatio: 4.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.green[100 * (index % 9)],
                child: Text('grid item $index'),
              );
            },
            childCount: 20,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.green,
                height: 50.0,
                child: Center(
                  child: ListTile(
                    title: Text(
                      '100' + index.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.green[100 * (index % 9)],
                    ),
                  ),
                ),
              );
            },
            childCount: 15,
          ),
        ),
        SliverFixedExtentList(
          itemExtent: 100.0,
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.white : Colors.green,
                height: 50.0,
                child: Center(
                  child: ListTile(
                    title: Text(
                      '200' + index.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.green[100 * (index % 9)],
                    ),
                  ),
                ),
              );
            },
            childCount: 15,
          ),
        )
      ],
    );
  }
}
