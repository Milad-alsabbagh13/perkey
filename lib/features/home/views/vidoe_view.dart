import 'package:flutter/material.dart';
import 'package:perkey/core/styles/colors.dart';
import 'package:perkey/core/widgets/primary_container.dart';
import 'package:perkey/features/influencer/views/influencer_home_view.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({Key? key}) : super(key: key);

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  // late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late AnimationController _scaleAnimationController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.asset(
        'assets/videos/video.mp4',
      )
      ..initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        _videoPlayerController.setVolume(0.0); // Mute the video
        setState(() {}); // Rerender to show the video
      });

    _scaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _scaleAnimation = Tween<double>(
      begin: 0.0, // Starts fully transparent
      end: 100, // Fades to 50% opacity
    ).animate(
      CurvedAnimation(parent: _scaleAnimationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    // _animationController.dispose();
    _scaleAnimationController.dispose();
    super.dispose();
  }

  void _handleTap(Widget destination) async {
    // _scaleAnimationController.forward();

    await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );

    // 3. When returning from the destination screen, reverse the fade animation
    //  _animationController.reverse();
    _scaleAnimationController.dispose();
    _videoPlayerController.play(); // Resume video
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height / 1.5),
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    GestureDetector(
                      onTap: () => _handleTap(InfluencerHomeView()),
                      behavior: HitTestBehavior.translucent,
                      child: const PrimaryContainer(text: 'Influencer'),
                    ),
                    AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder:
                          (c, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: child,
                          ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap:
                      () => _handleTap(
                        const Text('Business Home View'),
                      ), // Replace with actual BusinessHomeView()
                  behavior: HitTestBehavior.translucent,
                  child: const PrimaryContainer(
                    text: 'Business',
                    color: kSecondaryColor,
                    textColor: kOnSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
