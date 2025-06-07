import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yellosky_assignment/Widget/projectContainer.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello!", style: blackMainHeadingStyl,),
            Text("username", style: GoogleFonts.poppins(
    fontSize: 13.sp, fontWeight: FontWeight.w600, color: themeColor),),
            height20,
            TextField(
                      controller: searchController,
                      // onChanged: searchPatients,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        hintText: "Search...",
                        hintStyle:blackContentStyl,
                        prefixIcon: Icon(Icons.search, color: bColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: gColor.shade300),
                        ),
                      ),
                    ),
                    height20,
                    Text("Recent Projects", style: blackSubHeadingStyl,),
                    height16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProjectContainer(projectImage: "", projectName: "Dummy Project 1", projectId: "1", ontap: (){}, projectLocation: "Bangalore"),
                        ProjectContainer(projectImage: "", projectName: "Dummy Project 2", projectId: "1", ontap: (){}, projectLocation: "Bangalore"),
                      ],
                    )

          ],
        ),
      )),
    );
  }
}