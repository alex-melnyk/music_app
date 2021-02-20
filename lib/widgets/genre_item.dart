import 'package:flutter/material.dart';

class GenreItem extends InkWell {
  GenreItem({
    Key key,
    @required String label,
    @required ImageProvider image,
    VoidCallback onPressed,
  }) : super(
          key: key,
          onTap: onPressed,
          customBorder: CircleBorder(),
          child: Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: image,
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        );
}
