import 'dart:developer';

import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:perkey/core/shared/perk_list.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/styles/text_styles.dart';
import 'package:perkey/core/widgets/perk_container.dart';
import 'package:perkey/features/business/views/business_home_view.dart';
import 'package:perkey/features/influencer/perk_detail.dart/views/perk_detail_view.dart';
import 'package:perkey/features/influencer/views/widgets/category_picker_row.dart';

class InfluencerHomeView extends StatefulWidget {
  InfluencerHomeView({super.key});

  @override
  State<InfluencerHomeView> createState() => _InfluencerHomeViewState();
}

class _InfluencerHomeViewState extends State<InfluencerHomeView> {
  int _currentIndex = 0;
  // <--- State variable to hold the current index
  final List<Widget> _pages = [
    const Center(child: Text('Home Page', style: TextStyle(fontSize: 16))),
    const Center(child: Text('Likes Page', style: TextStyle(fontSize: 16))),
    const Center(child: Text('Search Page', style: TextStyle(fontSize: 16))),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 16))),
  ];
  List<Map<String, dynamic>> selectedPerks = [];
  String? selectedPerksFilter = 'All';

  void _handleIndexChanged(int index) {
    log(index.toString());
    setState(() {
      _currentIndex = index; // Update the state with the new index
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseCategory(selectedPerksFilter);
  }

  void chooseCategory(String? cat) {
    selectedPerks = [];
    setState(() {
      // If 'cat' is null or 'all', show all perks
      if (cat == null || cat == 'All' || cat == '') {
        selectedPerks = List.from(
          perks,
        ); // Create a new list to avoid modifying the original
      } else {
        // Filter the 'perks' list based on the selected category
        selectedPerks = perks.where((perk) => perk['category'] == cat).toList();
      }
      selectedPerksFilter = cat;
    });
  }

  final NotchBottomBarController _notchController = NotchBottomBarController(
    index: 0,
  );
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [CircleAvatar(child: Icon(Icons.person))]),
      body: Column(
        children: [
          Center(
            child: Text(
              'Welcome Back Austin',
              style: TextStyles.styleMedium16(context).copyWith(fontSize: 20),
            ),
          ),
          CategoryPickerRow(
            onCategorySelected: (cat) {
              chooseCategory(cat);
            },
          ),
          selectedPerks.isEmpty
              ? Center(
                child: Text('There is no perks for this category right now'),
              )
              : Expanded(
                child: ListView.builder(
                  itemCount: selectedPerks.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PerkDetailView(
                                  images: selectedPerks[index]['images'],
                                  title: selectedPerks[index]['title'],
                                  description: selectedPerks[index]['desc'],
                                  date: selectedPerks[index]['date'],
                                  time: selectedPerks[index]['time'],
                                  location: selectedPerks[index]['location'],
                                );
                              },
                            ),
                          );
                        },
                        child: PerkContainer(
                          title: selectedPerks[index]['title'],
                          imagePath: selectedPerks[index]['images'][0],
                        ),
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: AnimatedNotchBottomBar(
        /// Provide NotchBottomBarController
        notchBottomBarController: _notchController,
        color: Colors.white,
        showLabel: true,
        textOverflow: TextOverflow.visible,
        maxLine: 1,
        shadowElevation: 5,
        kBottomRadius: 14.0,

        notchColor: kPrimaryColor,

        /// restart app if you change removeMargins
        removeMargins: false,
        bottomBarWidth: 500,
        showShadow: false,
        durationInMilliSeconds: 300,

        itemLabelStyle: const TextStyle(fontSize: 10),

        elevation: 1,
        bottomBarItems: const [
          BottomBarItem(
            inActiveItem: Icon(Icons.home_filled, color: Colors.blueGrey),
            activeItem: Icon(Icons.home_filled, color: Colors.white),
            itemLabel: 'Perks',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.star, color: Colors.blueGrey),
            activeItem: Icon(Icons.star, color: Colors.white),
            itemLabel: 'Previous Perks',
          ),
          BottomBarItem(
            inActiveItem: Icon(Icons.settings, color: Colors.blueGrey),
            activeItem: Icon(Icons.settings, color: Colors.white),
            itemLabel: 'Page 3',
          ),
        ],
        onTap: (index) {
          log('current selected index $index');
          _pageController.jumpToPage(index);
        },
        kIconSize: 24.0,
      ),
    );
  }
}
