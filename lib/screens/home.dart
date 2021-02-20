import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:music_app/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Icon(
              MaterialCommunityIcons.beats,
              size: 32,
              color: Colors.orange,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  AntDesign.search1,
                  color: Colors.white,
                ),
                onPressed: () => _searchFocusNode.requestFocus(),
              ),
              IconButton(
                icon: Icon(
                  AntDesign.shoppingcart,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                SafeArea(
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeadline(),
                        Search(
                          focusNode: _searchFocusNode,
                        ),
                        _buildGenres(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: GlassBottomPanel(
              showCurrentPlay: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenres() {
    return Expanded(
      child: PageBar(
        tabs: [
          'Commercial',
          'Free license',
        ],
        itemBuilder: (context, index) {
          return GridView.count(
            padding: const EdgeInsets.only(
              top: 16,
              left: 24,
              right: 24,
              bottom: 240,
            ),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              GenreItem(
                label: 'Cloud Rap',
                image: AssetImage('assets/images/cloud_rap.jpg'),
              ),
              GenreItem(
                label: 'Trap',
                image: AssetImage('assets/images/trap.jpg'),
              ),
              GenreItem(
                label: 'Lo-Fi',
                image: AssetImage('assets/images/lo_fi.jpg'),
              ),
              GenreItem(
                label: 'Chillwave',
                image: AssetImage('assets/images/chillwave.jpg'),
              ),
              GenreItem(
                label: 'Dubstep',
                image: AssetImage('assets/images/dubstep.jpg'),
              ),
              GenreItem(
                label: 'House',
                image: AssetImage('assets/images/house.jpg'),
              ),
              GenreItem(
                label: 'Deep House',
                image: AssetImage('assets/images/deep_house.jpg'),
              ),
              GenreItem(
                label: 'Techno',
                image: AssetImage('assets/images/techno.jpg'),
              ),
              GenreItem(
                label: 'Rock',
                image: AssetImage('assets/images/rock.jpg'),
              ),
              GenreItem(
                label: 'Country',
                image: AssetImage('assets/images/country.jpg'),
              ),
            ],
          );
        },
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
