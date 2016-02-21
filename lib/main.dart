import 'dart:math' as math;

import 'dart:async';

import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import 'package:flutter/services.dart';

void main() {
  runApp(new DefaultAssetBundle(bundle:rootBundle,child: new Cats()));
}

class Cat extends StatelessComponent {
  @override
  Widget build(BuildContext context) {
    return new ClipRect(
        child: new Container(
            width: 100.0,
            height: 100.0,

            child: new NetworkImage(
                //fit:ImageFit.cover,
                //alignment:const FractionalOffset(0.0,0.5),
                src: 'https://i.ytimg.com/vi/UIrEM_9qvZU/maxresdefault.jpg')));
  }
}

class CatMetadata {
  Cat cat;
  Offset offset;
  CatMetadata(this.cat, this.offset);
}

class Cats extends StatefulComponent {
  CatsState createState() => new CatsState();
}

class CatsState extends State<Cats> {
  math.Random random = new math.Random();
  List<CatMetadata> catMetadata = [];

  Size size = Size.zero;

void initState(){
  super.initState();
}

  Widget build(_) {
    if (ui.window.size == Size.zero) {
      return new SizeObserver(
          onSizeChanged: (_) => setState(() {}), child: new Container());
    } else if (size == Size.zero) {
      size = ui.window.size;
      for (int i = 0; i < 20; i++) {
        addCat();
        print("addCat");
      }
    }
    print("$catMetadata");
    List<Widget> stackChildren = catMetadata
        .map((CatMetadata c) => new Positioned(
            left: c.offset.dx,
            top: c.offset.dy,
            child: new GestureDetector(onTap: () {
              setState(() {
                new Timer(const Duration(seconds: 2), () {
                  setState(() {
                    addCat();
                  });
                });
                catMetadata.remove(c);
              });
            }, child: c.cat)))
        .toList();

    return new Stack(children: stackChildren);
  }

  void addCat() {
    CatMetadata newCatMetadata = new CatMetadata(
        new Cat(),
        new Offset(random.nextDouble() * (ui.window.size.width - 100.0),
            random.nextDouble() * (ui.window.size.height - 100.0)));
    catMetadata.add(newCatMetadata);
  }
}
