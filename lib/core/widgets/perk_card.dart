import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:perkey/core/constants.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/widgets/build_info_chip.dart';

class PerkCard extends StatelessWidget {
  const PerkCard({super.key, required this.perk});
  final Map<String, dynamic> perk;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      height: 200,
      color: kOnTertiaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image container
          Container(
            width: MediaQuery.of(context).size.width * 0.45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(perk[DataBaseConstants.kImagesKey][0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),

          /// Title, description, place column
          Expanded(
            // <--- Use Flexible here!
            // This is the default, but good to be explicit
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      perk[DataBaseConstants.kBusinessNameKey],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      perk[DataBaseConstants.kOfferKey],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        SvgPicture.asset(
                          perk[DataBaseConstants.kRequirementKey] == 'Facebook'
                              ? 'assets/icons/facebook.svg'
                              : 'assets/icons/instagram.svg',
                          width: 20,
                          height: 20,
                        ),
                        Text(
                          perk[DataBaseConstants.kRequirementKey] == 'instagram'
                              ? 'Instagram post'
                              : 'Facebook post',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Text(
                      perk[DataBaseConstants.kDescriptionKey],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
