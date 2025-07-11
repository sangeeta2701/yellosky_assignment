import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yellosky_assignment/Controller/authController.dart';
import 'package:yellosky_assignment/Model/projectModel.dart';
import 'package:yellosky_assignment/Screens/project_detail_screen.dart';
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

  Future<void> fetchProjects() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('projects').get();
    final projects =
        snapshot.docs
            .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
            .toList();

    setState(() {
      allProjects = projects;
      filteredProjects = projects;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchUsername();
    });
    fetchProjects();
  }

  String? userName;
  bool isLoading = true;

  Future<void> fetchUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');
    print("id of the user is: $uid");

    if (uid != null) {
      final docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (docSnapshot.exists) {
        setState(() {
          userName = docSnapshot.data()?['name'] ?? 'User';
          isLoading = false;
        });
      }
    } else {
      setState(() {
        userName = 'Guest';
        isLoading = false;
      });
    }
  }

  //serach feature
  List<ProjectModel> allProjects = [];
  List<ProjectModel> filteredProjects = [];

  //serach project
  void searchProjects(String query) {
    final results =
        allProjects.where((project) {
          final name = project.name.toLowerCase();
          return name.contains(query.toLowerCase());
        }).toList();

    setState(() {
      filteredProjects = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,

      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Welcome!", style: blackMainHeadingStyl),
                        isLoading
                            ? Text('Loading...')
                            : Text(
                              'Dear, ${userName ?? "User"}',
                              style: GoogleFonts.poppins(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: themeColor,
                              ),
                            ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Authcontroller.logoutUser(context);
                      },
                      icon: Icon(Icons.logout_outlined),
                    ),
                  ],
                ),

                height20,
                TextField(
                  controller: searchController,
                  onChanged: searchProjects,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintText: "Search...",
                    hintStyle: blackContentStyl,
                    prefixIcon: Icon(Icons.search, color: bColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: gColor.shade300),
                    ),
                  ),
                ),
                height20,
                Text("Recent Projects", style: blackSubHeadingStyl),
                height12,
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : (filteredProjects.isEmpty
                        ? Center(child: Text("No projects found."))
                        : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredProjects.length,
                          itemBuilder: (context, index) {
                            final project = filteredProjects[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ProjectContainer(
                                projectImage:
                                    "https://miro.medium.com/v2/resize:fit:1100/format:webp/1*8Ts9_oEByDWlShu3kj9X9g.png",
                                projectName: project.name,
                                projectId: project.id,
                                projectLocation: project.locationName,
                                projectDesc: project.description,
                                ontap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => ProjectDetailScreen(
                                            proId: project.id,
                                            projectName: project.name,
                                            projectDesc: project.description,
                                            projectlocation:
                                                project.locationName,
                                            projectImage:
                                                "https://miro.medium.com/v2/resize:fit:1100/format:webp/1*8Ts9_oEByDWlShu3kj9X9g.png",
                                          ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
