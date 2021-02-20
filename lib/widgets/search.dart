import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Search extends Container {
  Search({
    Key key,
    FocusNode focusNode,
  }) : super(
          key: key,
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white12,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: Icon(
                  AntDesign.search1,
                  color: Colors.grey,
                  size: 32,
                ),
              ),
              Expanded(
                child: TextField(
                  focusNode: focusNode,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    helperStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'Search',
                  ),
                ),
              ),
            ],
          ),
        );
}
