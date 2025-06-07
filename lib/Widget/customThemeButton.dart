

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/utils/colors.dart';

Widget customThemeButton(String bttonText, VoidCallback ontap) {
    return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              shape: RoundedRectangleBorder(
                                
                                borderRadius: BorderRadius.circular(8),
                              )
                            ),
                            onPressed: ontap, child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 28),
                              child: Text(bttonText,style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w600, color: wColor),),
                            ));
  }