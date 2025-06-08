import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:yellosky_assignment/Widget/showSnackbar.dart';
import 'package:yellosky_assignment/Widget/sizedbox.dart';
import 'package:yellosky_assignment/utils/colors.dart';
import 'package:yellosky_assignment/utils/constant.dart';

class ProjectDetailScreen extends StatefulWidget {
  const ProjectDetailScreen({
    super.key,
    required this.proId,
    required this.projectName,
    required this.projectDesc,
    required this.projectlocation,
    required this.projectImage,
  });
  final String proId;
  final String projectName;
  final String projectDesc;
  final String projectlocation;
  final String projectImage;

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  File? _selectedMedia;
  List<String> _mediaPaths = [];
  bool _isImage = true;

  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoController;

  @override
  void initState() {
    super.initState();
    _loadProjectMedia();
  }

  Future<void> _loadProjectMedia() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'media_${widget.proId}';
    final files = prefs.getStringList(key) ?? [];
    setState(() {
      _mediaPaths = files;
    });
  }

  //select image/Video bottomsheet
  void _showMediaTypeSheet() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.image),
              title: Text("Upload Picture", style: blackContentStyl),
              onTap: () {
                Navigator.pop(context);
                _isImage = true;
                _showSourceOptions();
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text("Upload Video", style: blackContentStyl),
              onTap: () {
                Navigator.pop(context);
                _isImage = false;
                _showSourceOptions();
              },
            ),
          ],
        );
      },
    );
  }

  //imegevideo selection option(bottom sheet)
  void _showSourceOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("From Camera", style: blackContentStyl),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(isCamera: true);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("From Gallery", style: blackContentStyl),
              onTap: () {
                Navigator.pop(context);
                _pickMedia(isCamera: false);
              },
            ),
          ],
        );
      },
    );
  }

  //pick image/video
  Future<void> _pickMedia({required bool isCamera}) async {
    XFile? pickedFile;

    if (_isImage) {
      pickedFile = await _picker.pickImage(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
    } else {
      pickedFile = await _picker.pickVideo(
        source: isCamera ? ImageSource.camera : ImageSource.gallery,
      );
    }

    if (pickedFile != null) {
      _selectedMedia = File(pickedFile.path);

      if (!_isImage) {
        _videoController?.dispose();
        _videoController = VideoPlayerController.file(_selectedMedia!);
        await _videoController!.initialize();
        _videoController!.setLooping(true);
        _videoController!.play();
      }

      setState(() {});
      _showUploadDialog();
    }
  }

  //upload  & perview dialog
  void _showUploadDialog() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text("Upload File", style: blackSubHeadingStyl),
            content:
                _selectedMedia == null
                    ? Text("No file selected")
                    : _isImage
                    ? Image.file(_selectedMedia!, height: 150)
                    : _videoController != null &&
                        _videoController!.value.isInitialized
                    ? AspectRatio(
                      aspectRatio: _videoController!.value.aspectRatio,
                      child: VideoPlayer(_videoController!),
                    )
                    : SizedBox(
                      height: 150,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(themeColor),
                        ),
                      ),
                    ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _selectedMedia = null;
                  _videoController?.dispose();
                  _videoController = null;
                },
                child: Text("Cancel", style: blueButtonTextStyle),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  try {
                    final prefs = await SharedPreferences.getInstance();
                    final key = 'media_${widget.proId}';
                    final existing = prefs.getStringList(key) ?? [];

                    if (_selectedMedia != null) {
                      existing.add(_selectedMedia!.path);
                      await prefs.setStringList(key, existing);
                    }

                    Navigator.of(context, rootNavigator: true).pop();

                    setState(() {
                      _mediaPaths = existing;
                      _selectedMedia = null;
                      _videoController?.dispose();
                      _videoController = null;
                    });
                  } catch (e) {
                    print("Upload failed: $e");

                    showSnackbar(context, "Failed to upload file");
                  }
                },

                child: Text(
                  "Upload",
                  style: GoogleFonts.poppins(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: wColor,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text("Project Details", style: blackMainHeadingStyl),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 120.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(widget.projectImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              height12,
              Text(widget.projectName, style: blackSubHeadingStyl),
              height12,
              Text(widget.projectDesc, style: greyContentStyle),
              height8,
              Text(widget.projectlocation, style: blackContentStyl),
              height12,
              
             _mediaPaths.isNotEmpty? 
             
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                Divider(
                  color: gColor,
                ),
                Text("Uploaded Files", style: blackSubHeadingStyl),
              height12,
                 GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: _mediaPaths.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: (_, index) {
                      final path = _mediaPaths[index];
                      final isVideo =
                          path.endsWith(".mp4") || path.endsWith(".mov");
                 
                      if (isVideo) {
                        final controller = VideoPlayerController.file(File(path));
                        return FutureBuilder(
                          future: controller.initialize(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.done) {
                              return AspectRatio(
                                aspectRatio: controller.value.aspectRatio,
                                child: VideoPlayer(controller),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                      } else {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(File(path), fit: BoxFit.cover),
                        );
                      }
                    },
                  ),
               ],
             ): SizedBox()
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        onPressed: _showMediaTypeSheet,
        child: Icon(Icons.add, color: wColor),
      ),
    );
  }
}
