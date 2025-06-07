import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({super.key, required this.proId, required this.projectName,required this.projectDesc, required this.projectlocation,required this.projectImage});
  final String proId;
  final String projectName;
  final String projectDesc;
  final String projectlocation;
  final String projectImage;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Project Details", style: blackMainHeadingStyl,),
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(image: NetworkImage(widget.projectImage), fit: BoxFit.cover)
              ),
            ),
            height12,
            Text(widget.projectName, style: blackSubHeadingStyl,),
            height12,
            Text(widget.projectDesc, style: greyContentStyle,),
            height8,
            Text(widget.projectlocation, style: blackContentStyl,)
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        onPressed: (){}, child: Icon(Icons.add, color: wColor,),),
    );
  }
}