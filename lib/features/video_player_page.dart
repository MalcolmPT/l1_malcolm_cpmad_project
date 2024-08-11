import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String title;
  final String description;

  const VideoPlayerPage({
    Key? key,
    required this.videoUrl,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  //late will be declared later
  late VideoPlayerController _controller; //Declare controller
  late Future<void> _initializeVideoPlayerFuture; //Future video has no datatype

  @override
  void initState() {
    super.initState(); //Uri.parse makes video link passed into http format
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget
        .videoUrl)); //VideoPlayerController is from the plugin, the parameter is a url
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });   //Will only setState after initializing _controller, it will then play the video
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Video Player', style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFFAE9DD),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              //snapshot refers to the built future state
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading video: ${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AspectRatio(
                    //Aspect ratio maintain a specific width-to-height ratio for its child widget
                    aspectRatio: _controller.value
                        .aspectRatio, //Instead of entering a double we use this variable to play all types of videos
                    child: ClipRRect(
                      //Child to play video
                      borderRadius: BorderRadius.circular(12.0),
                      child: VideoPlayer(_controller),
                    ),
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator()); //Loading
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align content to the left
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller
                              .play(); //if its playing, pause button if not playing, play button
                    });
                  },
                  backgroundColor: Color(0xFF1A2947),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    size: 30.0,
                  ),
                ),
                const SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _controller
                          .seekTo(Duration.zero); //set the video timing to 0
                    });
                  },
                  backgroundColor: Color(0xFFFFA500),
                  child: const Icon(
                    Icons.replay,
                    size: 30.0,
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
