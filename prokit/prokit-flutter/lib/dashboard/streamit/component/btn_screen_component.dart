import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prokit_flutter/dashboard/streamit/screen/home_screen.dart';


class FilterDropdown extends StatefulWidget {
  const FilterDropdown({super.key});

  @override
  State<FilterDropdown> createState() => _FilterDropdownState();
}

class _FilterDropdownState extends State<FilterDropdown>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String _selected = "All";

  final List<String> filters = ["All", "TV Shows", "Movies", "Videos"];

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _selectFilter(String value) {
    setState(() {
      _selected = value;
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Blur background when expanded
        if (_isExpanded)
          Positioned.fill(
            child: GestureDetector(
              onTap: _toggleDropdown, 
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(),
              ),
            ),
          ),

        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isExpanded)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: filters
                    .where((f) => f != _selected) 
                    .toList()
                    .reversed
                    .map(
                      (filter) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () => _selectFilter(filter),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: _selected == filter
                                  ? streamITAppColors.red
                                  : streamITAppColors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              filter,
                              style: GoogleFonts.roboto(
                                color: _selected == filter
                                    ? streamITAppColors.white
                                    : streamITAppColors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: streamITAppColors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: streamITAppColors.black.withAlpha((0.1 * 255).toInt()),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selected,
                      style: GoogleFonts.roboto(
                        color: streamITAppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _isExpanded
                          ? Icons.close
                          : Icons.keyboard_arrow_up_rounded,
                      color: streamITAppColors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
