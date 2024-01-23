import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class RepprovedPaymentBody extends StatelessWidget {
  const RepprovedPaymentBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 255, 224, 214),
            radius: 35,
            child: Icon(
              Icons.do_not_disturb_alt_rounded,
              color: Color.fromARGB(255, 158, 43, 43),
              size: 35,
            ),
          ),
          TextPageHeader(
            title: 'Pagamento não autorizado!',
            fontSize: 25,
          ),
          Text(
            'Seu pagamento foi não foi autorizado!',
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
              fontFamily: "Mansny-light",
              fontWeight: FontWeight.bold,
            ),
          )
        ]);
  }
}

class TextPageHeader extends StatelessWidget {
  final String title;
  final double fontSize;
  const TextPageHeader({
    Key? key,
    required this.title,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: "Mansny-regular",
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}

enum Direction { vertical, horizontal }

class SlideFadeTransition extends StatefulWidget {
  final Widget child;

  final double offset;

  final Curve curve;

  final Direction direction;

  final Duration delayStart;

  final Duration animationDuration;

  const SlideFadeTransition({
    super.key,
    required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
  });

  @override
  // ignore: library_private_types_in_public_api
  _SlideFadeTransitionState createState() => _SlideFadeTransitionState();
}

class _SlideFadeTransitionState extends State<SlideFadeTransition>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _animationSlide;

  late AnimationController _animationController;

  late Animation<double> _animationFade;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    if (widget.direction == Direction.vertical) {
      _animationSlide = Tween<Offset>(
              begin: Offset(0, widget.offset), end: const Offset(0, 0))
          .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    } else {
      _animationSlide = Tween<Offset>(
              begin: Offset(widget.offset, 0), end: const Offset(0, 0))
          .animate(CurvedAnimation(
        curve: widget.curve,
        parent: _animationController,
      ));
    }

    _animationFade =
        Tween<double>(begin: -1.0, end: 1.0).animate(CurvedAnimation(
      curve: widget.curve,
      parent: _animationController,
    ));

    Timer(widget.delayStart, () {
      _animationController.forward();
      Timer(const Duration(milliseconds: 2000), () {
        if (mounted) {
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationFade,
      child: SlideTransition(
        position: _animationSlide,
        child: widget.child,
      ),
    );
  }
}
