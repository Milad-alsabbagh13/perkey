import 'package:flutter/material.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/styles/text_styles.dart';

class PerkDetailView extends StatelessWidget {
  const PerkDetailView({
    super.key,
    required this.images,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.location,
  });
  final List<String> images;
  final String title;
  final String description;
  final String date;
  final String time;
  final String location;

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
              Text(title, style: TextStyles.styleSemiBold24(context)),
              SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  itemCount: images.length,
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
                            image: NetworkImage(images[index]),
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
