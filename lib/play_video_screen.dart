// import 'package:agp_ziauddin_virtual_clinic/constants/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// class PlayVideoScreeen extends StatefulWidget {
//   final String videoUrl;
//   const PlayVideoScreeen({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   State<PlayVideoScreeen> createState() => _PlayVideoScreeenState();
// }

// class _PlayVideoScreeenState extends State<PlayVideoScreeen> {
//   late VideoPlayerController controller;
//   late Future<void> initializeVideoPlayerFuture;
//   bool isPlay = true;

//   loadVideoPlayer() {
//     controller = VideoPlayerController.network(widget.videoUrl)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..setLooping(true)
//       ..initialize().then((value) => controller.play());
//     // controller = VideoPlayerController.network(widget.videoUrl);
//     initializeVideoPlayerFuture = controller.initialize();
//     controller.play();
//     controller.setLooping(true);

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     controller.dispose();
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loadVideoPlayer();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor:black,
//       body: SafeArea(
//           child: FutureBuilder(
//               future: initializeVideoPlayerFuture,
//               builder: (context, snapshot) {
//                 return snapshot.connectionState == ConnectionState.done
//                     ? Stack(
//                         children: [
//                           Center(
//                             child: AspectRatio(
//                               aspectRatio: 16 / 9,
//                               child: VideoPlayer(controller),
//                             ),
//                           ),
//                           Align(
//                             alignment: Alignment.center,
//                             child: IconButton(
//                               onPressed: () {
//                                 if (controller.value.isPlaying) {
//                                   controller.pause();
//                                 } else {
//                                   controller.play();
//                                 }
//                                 setState(() {});
//                               },
//                               icon: Icon(
//                                 controller.value.isPlaying
//                                     ? Icons.pause
//                                     : Icons.play_arrow,
//                                 color:white,
//                                 size: 60,
//                               ),
//                             ),
//                           ),
//                         ],
//                       )
//                     : Center(
//                         child: CircularProgressIndicator(
//                           color: white,
//                         ),
//                       );
//               })),
//     );
//   }
// }
