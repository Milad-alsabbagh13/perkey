import 'package:flutter/material.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/widgets/primary_container.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  bool _showNextScreen = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/video.mp4',
      )
      ..initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true); // Loop the video
        _videoPlayerController.setVolume(50); // Mute the video
        setState(() {}); // Rerender to show the video
      });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 1500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Starts off-screen at the bottom
      end: Offset.zero, // Slides up to cover the screen
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _showNextScreen = true;
      _animationController.forward(); // Start the slide-up animation
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _videoPlayerController.pause();
        // Navigator.of(context)
        //     .push(
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) =>
        //         const HomeView(),
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) {
        //       return FadeTransition(
        //           opacity: animation, child: child); // Or any other transition
        //     },
        //   ),
        // )
        //       .then((_) {
        //     // When returning from NextScreen, reset the animation
        //     setState(() {
        //       _showNextScreen = false;
        //     });
        //     _animationController.reverse(); // Slide the NextScreen back down
        //     _videoPlayerController.play(); // Resume video if it was paused
        //   });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          // Video Player as the background
          SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width:
                    _videoPlayerController.value.isInitialized
                        ? _videoPlayerController.value.size.width
                        : 0,
                height:
                    _videoPlayerController.value.isInitialized
                        ? _videoPlayerController.value.size.height
                        : 0,
                child:
                    _videoPlayerController.value.isInitialized
                        ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        )
                        : Container(
                          color: Colors.black,
                        ), // Placeholder while loading
              ),
            ),
          ),
          Container(color: Colors.white.withAlpha(125)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 1.5),
                PrimaryContainer(text: 'Influencer'),
                SizedBox(height: 10),
                PrimaryContainer(
                  text: 'Business',
                  color: kSecondaryColor,
                  textColor: kOnSecondaryColor,
                ),
              ],
            ),
          ),
          // Gradient Overlay for better readability and tap area indication
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: Padding(
          //     padding: const EdgeInsets.all(20.0),
          //     child: SizedBox(
          //       width: 300,
          //       height: 300,
          //       child: Image.asset('assets/images/logo.png'),
          //     ),
          //   ),
          // ),
          // Tap Detector for the video screen
          // GestureDetector(
          //   onTap: _handleTap,
          //   behavior:
          //       HitTestBehavior
          //           .translucent, // Ensures taps are registered even on transparent parts
          //   child: const Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(bottom: 50.0),
          //           child: Icon(
          //             Icons.keyboard_arrow_up,
          //             color: Colors.white,
          //             size: 60,
          //           ),
          //         ),
          //         Text(
          //           'Tap to Play and win',
          //           style: TextStyle(color: Colors.white, fontSize: 18),
          //         ),
          //         SizedBox(height: 50),
          //       ],
          //     ),
          //   ),
          // ),
          if (_showNextScreen)
            SlideTransition(
              position: _slideAnimation,
              // child: const HomeView(),
            ),
        ],
      ),
    );
  }
}
