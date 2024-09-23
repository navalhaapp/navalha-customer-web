import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:navalha/core/colors.dart';
import 'package:navalha/shared/shows_dialogs/dialog.dart';

class ApprovedScheduleBody extends StatelessWidget {
  const ApprovedScheduleBody({
    Key? key,
    required this.page,
    this.title,
    this.subTitle,
  }) : super(key: key);

  final String page;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 214, 255, 223),
          radius: 35,
          child: Icon(
            Icons.check,
            color: Colors.green,
            size: 35,
          ),
        ),
        TextPageHeader(
          title: title ?? 'Serviço Agendado',
          fontSize: 25,
        ),
        Text(
          subTitle ?? 'Agendamento realizado com sucesso!',
          style: const TextStyle(
            fontSize: 17,
            color: Colors.grey,
            fontFamily: "Mansny-light",
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
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
  final String page;
  final Map<String, dynamic> args;

  const SlideFadeTransition({
    Key? key,
    required this.child,
    this.offset = 1.0,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
    required this.page,
    required this.args,
  }) : super(key: key);

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
          Navigator.of(context).pushNamed(widget.page);
          showCustomDialog(context,
              SizedBox(width: 500, child: WhatsAppDialog(args: widget.args)));
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

class WhatsAppDialog extends StatelessWidget {
  const WhatsAppDialog({
    Key? key,
    required this.args,
  }) : super(key: key);

  final Map<String, dynamic> args;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
        // padding: EdgeInsets.symmetric(
        //     horizontal: size.width <= 500 ? 30 : size.width * 0.2),
        AlertDialog(
      alignment: Alignment.center,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(32.0),
        ),
      ),
      scrollable: true,
      backgroundColor: colorBackground181818,
      title: SizedBox(
        width: size.width * 0.6,
        child: const Text(
          textAlign: TextAlign.center,
          'Agendamento confirmado!',
          style: TextStyle(color: Colors.white),
        ),
      ),
      content: const Text(
        textAlign: TextAlign.center,
        'Para garantir que tudo esteja perfeito, não se esqueça de enviar uma mensagem para a barbearia informando sobre seu agendamento. Se tiver dúvidas ou precisar de mais informações, eles estão prontos para ajudar!',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 24, 24, 24)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    'Enviar mensagem',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  _openWhatsApp(args);
                }),
          ],
        ),
      ],
    );
  }
}

void _openWhatsApp(Map<String, dynamic> args) async {
  String url =
      'https://wa.me/55${args['barbershop_phone']}/?text=Olá *${args['professional_name']}*, agendei um *${args['service_name']}* com você pelo *Navalha* para o dia *${args['service_date']}* às *${args['service_hour']}*.%0A%0A*Observações*: ${args['service_observation'] == '' ? 'Nenhuma observação.' : args['service_observation']}%0A%0AAté lá!';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    null;
  }
}
