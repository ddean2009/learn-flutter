
import 'package:flutter/material.dart';

class CardApp extends StatelessWidget{
  const CardApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Card(
        child: Column(
          children: [
            const ListTile(
              title: Text(
                'Han MeiMei',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('上海，张江'),
              leading: SizedBox(
                width: 20,
                child:Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('images/head.jpg'),
                      radius: 10,
                    ))
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                '18888888888',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(
                Icons.contact_phone,
                color: Colors.blue[500],
              ),
            ),
            ListTile(
              title: const Text('hanmeimei@163.com'),
              leading: Icon(
                Icons.contact_mail,
                color: Colors.blue[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}