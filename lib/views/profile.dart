import 'package:animated_background/animated_background.dart';
import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with TickerProviderStateMixin {
  // todo check in apple phone if screenshot of recording can be done.
  final _noScreenshot = NoScreenshot.instance;
  final con = FlipCardController();
  final con1 = FlipCardController();
  final cong = GestureFlipCardController();
  final cong1 = GestureFlipCardController();

  @override
  void initState() {
    _noScreenshot.screenshotOff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: AnimatedBackground(
        vsync: this,
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMinRadius: 10,
            spawnMaxRadius: 25,
            maxOpacity: 0.7,
            minOpacity: 0.4,
            image: Image(
              image: AssetImage(
                'assets/images/baiust_logo.png',
              ),
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: GestureFlipCard(
              animationDuration: const Duration(milliseconds: 300),
              axis: FlipAxis.values[0],
              controller: cong1,
              enableController: true,
              frontWidget: const CardFront(),
              backWidget: const CardBack(),
            ),
          ),
        ),
      ),
    );
  }
}

class CardFront extends StatelessWidget {
  const CardFront({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BothSide();
  }
}

class BothSide extends StatelessWidget {
  const BothSide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 280,
          height: 450,
          child: Stack(
            children: [
              // * White Background Card
              Positioned(
                top: 0,
                child: Container(
                  color: Colors.white,
                  width: 280,
                  height: 450,
                ),
              ),
              const TopWave(),
              const BottomWave(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    InstituteNameWithLogo(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Transport Card',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.orange,
                      height: 2,
                      thickness: 2,
                      indent: 50,
                      endIndent: 50,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    UserImage(),
                    SizedBox(
                      height: 8,
                    ),
                    FittedBox(
                      child: Text(
                        'Name: Nahid Hasan Noyon',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'ID: 1109020',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Batch: 9th',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Department: CSE',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Blood Group: O+',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Valid Till: Spring-22',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.white,
        width: 130,
        height: 130,
        child: RippleAnimation(
          repeat: true,
          color: Colors.green,
          minRadius: 60,
          ripplesCount: 6,
          child: const Center(
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(90),
              child: Image(
                image: AssetImage(
                  'assets/images/nahid.jpg',
                ),
              ),
            ),
          ),
        ),
      ).animate().fade(duration: 500.ms).scale(delay: 500.ms),
    );
  }
}

class InstituteNameWithLogo extends StatelessWidget {
  const InstituteNameWithLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'BANGLADESH ARMY',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2500.ms, color: const Color(0xFF80DDFF))
                .animate() // this wraps the previous Animate in another Animate
                .fadeIn(duration: 2500.ms, curve: Curves.easeOutQuad)
                .slide(),
            const Text(
              'INTERNATIONAL UNIVERSITY',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2500.ms, color: const Color(0xFF80DDFF))
                .animate() // this wraps the previous Animate in another Animate
                .fadeIn(duration: 2500.ms, curve: Curves.easeOutQuad)
                .slide(),
            const Text(
              'OF SCIENCE & TECHNOLOGY',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 2500.ms, color: const Color(0xFF80DDFF))
                .animate() // this wraps the previous Animate in another Animate
                .fadeIn(duration: 2500.ms, curve: Curves.easeOutQuad)
                .slide(),
            const Text(
              'BAIUST, Cumilla',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF))
                .animate() // this wraps the previous Animate in another Animate
                .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                .slide(),
          ],
        ),
        const Spacer(),
        const Image(
          image: AssetImage(
            'assets/images/baiust_logo.png',
          ),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const BothSide();
  }
}

class TopWave extends StatelessWidget {
  const TopWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green,
          width: 280,
          height: 50,
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.white, Colors.white],
                      [Colors.yellow, Colors.yellow],
                      [Colors.white, Colors.white],
                    ],
                    durations: [4000, 4000, 4000],
                    heightPercentages: [0.1, 0.2, 0.3],
                  ), //depth of curves
                  waveFrequency: 1, //number of curves in waves
                  backgroundColor: Colors.green, //background colors
                  size: const Size(
                    280,
                    40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BottomWave extends StatelessWidget {
  const BottomWave({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [Colors.yellow, Colors.yellow],
            [Colors.white, Colors.white],
            [Colors.green, Colors.green],
          ],
          durations: [4000, 4000, 4000],
          heightPercentages: [0.01, 0.05, 0.1],
          gradientBegin: Alignment.topLeft,
          gradientEnd: Alignment.bottomRight,
        ),
        waveFrequency: 1, //number of curves in waves
        backgroundColor: Colors.white, //background colors
        size: const Size(
          280,
          50,
        ),
      ),
    );
  }
}
