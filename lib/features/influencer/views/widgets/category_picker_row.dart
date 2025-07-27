import 'package:flutter/material.dart';
import 'package:perkey/core/styles/colors.dart';

class CategoryPickerRow extends StatefulWidget {
  final Function(String category) onCategorySelected;

  const CategoryPickerRow({Key? key, required this.onCategorySelected})
    : super(key: key);

  @override
  State<CategoryPickerRow> createState() => _CategoryPickerRowState();
}

class _CategoryPickerRowState extends State<CategoryPickerRow> {
  String? _selectedCategory =
      'All'; // Nullable to indicate no selection initially

  final List<String> _categories = [
    'All',
    'Restaurants',
    'Gym',
    'Coffee Shops',
    'Bars',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height:
              70, // Give the Wrap a fixed height for demonstration, or let it grow
          child: ListView.builder(
            // Using ListView.builder for horizontal scrolling
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  selectedColor: kPrimaryColor, // Color when selected
                  backgroundColor: kOnTertiaryColor, // Color when not selected
                  labelStyle: TextStyle(
                    color:
                        _selectedCategory == category
                            ? kOnPrimaryColor
                            : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCategory = selected ? category : 'All';
                    });
                    // Call the provided function with the selected category
                    if (_selectedCategory != null) {
                      widget.onCategorySelected(_selectedCategory!);
                    } else {
                      // Handle case where selection is cleared, if necessary
                      widget.onCategorySelected(
                        '',
                      ); // Or null, depending on your function signature
                    }
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
