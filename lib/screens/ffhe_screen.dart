import 'dart:math';

import 'package:flutter/material.dart';

class FfheScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic cityImages = [
      "actionvance-guy5aS3GvgA-unsplash.jpg",
      "muzammil-soorma-5eARmrl56u0-unsplash.jpg",
      "elijah-mears-SScbTSOJ00E-unsplash.jpg",
      "florian-wehde-V4cHacmEnW8-unsplash.jpg",
      "alex-iby-cNgsAdd4-m4-unsplash.jpg",
      "jacob-creswick-ra3oAd6hrnM-unsplash.jpg",
      "izayah-ramos-cR05i3WgRlQ-unsplash.jpg",
      "luca-micheli-RpvC77-exG0-unsplash.jpg",
      "nicola-tolin-bKx2zZUvv9k-unsplash.jpg",
      "tom-conway-tKSYZE5RTzw-unsplash.jpg",
      "joshua-peacock-ae4KypxWHr8-unsplash.jpg",
      "mana5280-tUoA7sCrRto-unsplash.jpg",
      "steven-pahel-645g50Mxy8s-unsplash.jpg",
      "jason-brower-G7IAWGOreww-unsplash.jpg",

    ];
    Random rnd;
    int min = 0;
    int max = cityImages.length - 1;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
    String image_name = cityImages[r].toString();



  ListTile buildListTile(leadingIcon, titleText, subtitleText, trailingIcon) {
    return ListTile(
      leading: Icon(leadingIcon),
      title: Text(titleText),
      subtitle: Text(subtitleText),
      trailing: Icon(trailingIcon),
    );
  }

    return Scaffold(

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images\/" + image_name), fit: BoxFit.cover)),

        child: Center(
          child: Column(
            children: [

            ],
          ),
        ),
      ),




    );
  }
}
