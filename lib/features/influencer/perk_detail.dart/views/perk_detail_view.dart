import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:overlapped_carousel/overlapped_carousel.dart';
import 'package:perkey/core/constants.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/styles/text_styles.dart';
import 'package:perkey/core/widgets/build_info_chip.dart';

class PerkDetailView extends StatelessWidget {
  PerkDetailView({super.key, required this.perk});
  final Map<String, dynamic> perk;

  @override
  Widget build(BuildContext context) {
    final List<String> imgList = perk[DataBaseConstants.kImagesKey];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  perk[DataBaseConstants.kBusinessNameKey],
                  style: TextStyles.styleSemiBold24(
                    context,
                  ).copyWith(fontSize: 22),
                ),
              ),
              SizedBox(height: 12),

              /// images list view
              Center(
                //Wrap the OverlappedCarousel widget with SizedBox to fix a height. No need to specify width.
                child: CarouselSlider(
                  options: CarouselOptions(autoPlay: true),
                  items:
                      imgList
                          .map(
                            (item) => Center(
                              child: SizedBox(
                                height: 400,
                                child: Image.network(item, fit: BoxFit.cover),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
              SizedBox(height: 10),

              /// offer
              Text(
                perk[DataBaseConstants.kOfferKey],
                style: TextStyles.styleSemiBold24(context),
              ),
              SizedBox(height: 10),

              ///requirement
              Row(
                children: [
                  SvgPicture.asset(
                    perk[DataBaseConstants.kRequirementKey] == 'instagram'
                        ? 'assets/icons/instagram.svg'
                        : 'assets/icons/facebook.svg',
                  ),
                  Text(
                    perk[DataBaseConstants.kRequirementKey] == 'instagram'
                        ? 'Instagram Post'
                        : 'Facebook Post',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

              ///Description
              SizedBox(height: 10),

              ///date, time, location
              Row(
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween, // Distribute space between elements
                children: [
                  buildInfoChip(
                    Icons.calendar_today,
                    perk[DataBaseConstants.kDateKey],
                  ),
                  buildInfoChip(
                    Icons.access_time,
                    perk[DataBaseConstants.kTimeKey],
                  ),
                  buildInfoChip(
                    Icons.location_on,
                    perk[DataBaseConstants.kLocationKey],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    perk[DataBaseConstants.kDescriptionKey],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60.0,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                backgroundColor: kPrimaryColor,
                foregroundColor: Colors.black,
              ),
              child: Text('Claim Perk', style: TextStyle(fontSize: 18.0)),
            ),
          ),
        ),
      ),
    );
  }
}
