import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

class ProjectContainer extends StatelessWidget {
  const ProjectContainer({super.key,required this.projectImage,required this.projectName,required this.projectId,required this.ontap, required this.projectLocation});
  final String projectImage;
  final String projectName;
  final String projectId;
  final VoidCallback ontap;
  final String projectLocation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
     
      width: 150,
      decoration: BoxDecoration(
        color: wColor,
        borderRadius: BorderRadius.circular(10),
       boxShadow: [
                  BoxShadow(
                    color: gColor.withOpacity(0.4),
                    blurRadius: 5,
                    spreadRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: ontap,
              child: Center(
                  child: Image.network(
                projectImage,
                height: 120,
              )),
            ),
            Text(
              projectName,
              style: blackSubHeadingStyl,
            ),
            height4,
            Text(
              "Project Desc",
              style: greyContentStyle,
            ),
            height8,
            Text("Project Location", style: GoogleFonts.poppins(
    fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),)
          ],
        ),
      ),
    );
  }
}