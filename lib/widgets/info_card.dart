import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;

  final String textValue;
  final double fontSizeValue;

  final String textLabel;
  final double fontSizeLabel;

  const InfoCard({
    super.key,
    required this.icon,
    required this.iconColor,

    required this.textValue,
    this.fontSizeValue = 16,

    required this.textLabel,
    this.fontSizeLabel = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 120,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: iconColor),
          SizedBox(height: 6),
          Text(
            textValue,
            style: GoogleFonts.poppins(
              fontSize: fontSizeValue,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 5),

          Text(
            textLabel,
            style: GoogleFonts.poppins(
              fontSize: fontSizeLabel,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
