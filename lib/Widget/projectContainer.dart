import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

class ProjectContainer extends StatelessWidget {
  const ProjectContainer({super.key,required this.projectImage,required this.projectName,required this.projectId,required this.ontap, required this.projectLocation, required this.projectDesc});
  final String projectImage;
  final String projectName;
  final String projectId;
  final VoidCallback ontap;
  final String projectLocation;
  final String projectDesc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: ontap,
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10)
                )
              ),
              child: Image.network(
                            projectImage,
                            
                            fit: BoxFit.fill,
                          ),
            ),
                        height12,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                projectName,
                style: blackSubHeadingStyl,
              ),
            ),
            height4,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                projectDesc,
                style: greyContentStyle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            height8,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(projectLocation, style: GoogleFonts.poppins(
                fontSize: 12.sp, fontWeight: FontWeight.w400, color: bColor),),
            ),
            height4
          ],
        ),
      ),
    );
  }
}