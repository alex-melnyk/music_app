import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music_app/widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 13, 13),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            SafeArea(
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeadline(),
                    Search(),
                    Expanded(
                      child: CustomTabBar(
                        tabs: [
                          'Tracks',
                          'Albums',
                          'Reviews',
                          'Contacts',
                        ],
                        itemBuilder: (context, index) {
                          return Container();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadline() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 16,
      ),
      child: Text(
        'Find the best music\nfor you banger',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 32,
          color: Colors.white70,
        ),
      ),
    );
  }
}
