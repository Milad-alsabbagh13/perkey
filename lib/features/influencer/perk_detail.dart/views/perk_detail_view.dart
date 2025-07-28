import 'package:flutter/material.dart';
import 'package:perkey/core/constants.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/styles/text_styles.dart';

class PerkDetailView extends StatelessWidget {
  const PerkDetailView({super.key, required this.perk});
  final Map<String, dynamic> perk;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                perk[DataBaseConstants.kBusinessNameKey],
                style: TextStyles.styleSemiBold24(context),
              ),
              SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: perk[DataBaseConstants.kImagesKey].length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                              perk[DataBaseConstants.kImagesKey][index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
