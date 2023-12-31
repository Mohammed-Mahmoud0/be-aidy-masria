import 'package:be_aydi/layouts/homepage.dart';
import 'package:be_aydi/shared/components.dart';
import 'package:flutter/material.dart';

class BeAydiMasria extends StatefulWidget {
  @override
  _BeAydiMasriaState createState() => _BeAydiMasriaState();
}

class _BeAydiMasriaState extends State<BeAydiMasria> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Color> colors = [Colors.white, Colors.red, Colors.black]; // Add your colors here
  int colorIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward().then((_) {
      // After animation completes, delay for some time and navigate to another page
      Future.delayed(Duration(seconds: 2), () {
        navigateAndFinish(context, HomePage());
      });
    });

    // Listen to animation changes
    _animation.addListener(() {
      if (_animation.isCompleted) {
        // Change color after each completion
        colorIndex = (colorIndex + 1) % colors.length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Center(
        child: StaggeredAnimationBuilder(
          animation: _animation,
          builder: (context, child, value) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Your logo widget here
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black, // Border color
                      width: 2.0, // Border width
                    ),
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0), // Clip rounded corners
                    child: Image.asset(
                      'assets/images/ic_launcher.png', // Replace with your asset path
                      width: 230.0,
                      height: 200.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 30), // Add some space between logo and text
                Transform.scale(
                  scale: (1 - value) + 0.8,
                  child: Transform.rotate(
                    angle: (1 - value) * 0.3,
                    child: FadeTransition(
                      opacity: _animation.drive(
                        Tween<double>(
                          begin: 0,
                          end: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'بأيدي مصرية',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.14, // Adjust the factor as needed,
                            fontWeight: FontWeight.bold,
                            color: colors[colorIndex],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class StaggeredAnimationBuilder extends StatelessWidget {
  final Animation<double> animation;
  final Widget Function(BuildContext, Widget?, double) builder;

  StaggeredAnimationBuilder({
    required this.animation,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return builder(context, child, animation.value);
      },
    );
  }
}
