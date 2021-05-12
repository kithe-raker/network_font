import 'package:flutter/material.dart';
import 'package:network_font/network_font.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetworkFontExample App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NetworkFontExample(),
    );
  }
}

class NetworkFontExample extends StatefulWidget {
  @override
  _NetworkFontExampleState createState() => _NetworkFontExampleState();
}

class _NetworkFontExampleState extends State<NetworkFontExample> {
  int _index = 0;
  final List<NetworkFont> _list = [
    NetworkFont('Quicksand',
        url:
            'https://firebasestorage.googleapis.com/v0/b/banna-fe7c8.appspot.com/o/fonts%2FQuicksand-Regular.ttf?alt=media&token=7def3227-6f6d-45de-9b74-aab262754d6d'),
    NetworkFont('AksiMosi',
        url:
            'https://firebasestorage.googleapis.com/v0/b/banna-fe7c8.appspot.com/o/fonts%2FAksiMosi-0WK1v.ttf?alt=media&token=2cd2d109-bff7-400f-be16-6efcdd8762b3'),
    NetworkFont('CocoBold',
        url:
            'https://firebasestorage.googleapis.com/v0/b/banna-fe7c8.appspot.com/o/fonts%2FCocoBold-YzEZa.otf?alt=media&token=9811befe-8757-4f46-b626-71de8c1bbbc2'),
    NetworkFont('Colombia',
        url:
            'https://firebasestorage.googleapis.com/v0/b/banna-fe7c8.appspot.com/o/fonts%2FColombia-Rp0DV.ttf?alt=media&token=a1a3d435-6227-402f-8233-3c3f586c8d5c'),
    NetworkFont('HuntingStar',
        url:
            'https://firebasestorage.googleapis.com/v0/b/banna-fe7c8.appspot.com/o/fonts%2FHuntingStar-gxBK1.ttf?alt=media&token=df4059e4-2a8b-4f20-bd21-4936d0707c68'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _list[_index].family,
            style: TextStyle(fontSize: 27),
          ),
          SizedBox(
            height: 32,
          ),
          Text('NetworkFont Style', style: _list[_index].style(fontSize: 18)),
          Text(
            'NetworkFont Extension',
            style: TextStyle(fontSize: 18).network(_list[_index]),
          ),
          NetworkFontText(
            'NetworkFontText Widget',
            font: _list[_index],
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 32,
          ),
          ElevatedButton(
              onPressed: () => setState(
                  () => _index == _list.length - 1 ? _index = 0 : _index++),
              child: Text('Change Font')),
        ],
      ),
    ));
  }
}
