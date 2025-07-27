import 'package:flutter/material.dart';
import 'package:perkey/core/styles/colors.dart';

class PerkContainer extends StatelessWidget {
  const PerkContainer({
    super.key,
    this.imagePath =
        'https://bloximages.chicago2.vip.townnews.com/newjerseyhills.com/content/tncms/assets/v3/editorial/5/06/5067fae5-d78a-5b6b-bec5-93d5d321bd47/6178096a7e11f.image.jpg?resize=750%2C500',
    this.title = 'Ymca',
    this.description = 'one swimming lesson at YMCA Madison Nj',
    this.date = 'Jun 22',
    this.time = '18:30',
    this.location = 'Madison, NJ',
  });
  final String imagePath;
  final String title;
  final String date;
  final String description;
  final String time;
  final String location;

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
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imagePath),
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
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
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
                    _buildInfoChip(Icons.calendar_today, date),
                    _buildInfoChip(Icons.access_time, time),
                    _buildInfoChip(Icons.location_on, location),
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

Widget _buildInfoChip(IconData icon, String text) {
  return Expanded(
    // Use Expanded to make sure each chip takes equal space in the row
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 2.0,
      ), // Small horizontal padding
      child: Column(
        // Use a column to stack icon and text if needed, or a Row if side-by-side
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(height: 2),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10, color: Colors.black54),
            maxLines: 1, // Ensure date/time/location don't wrap too much
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
