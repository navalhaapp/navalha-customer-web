import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navalha/web/shared/navalha_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

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
          showCupertinoDialog(
            context: context,
            builder: (context) => NavalhaDialog(
              title: 'Agendamento confirmado!',
              content:
                  'Para garantir que tudo esteja perfeito, não se esqueça de enviar uma mensagem para a barbearia informando sobre seu agendamento. Se tiver dúvidas ou precisar de mais informações, eles estão prontos para ajudar!',
              cancelText: 'Voltar',
              onCancel: () => Navigator.pop(context),
              confirmText: 'Enviar',
              textConfirmColor: Colors.white,
              onConfirm: () async {
                Navigator.pop(context);
                _openWhatsApp(widget.args['services']);
              },
            ),
          );
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


  void _openWhatsApp(List<dynamic> services) async {
    String url =
      'https://wa.me/55${services[0]['barbershop_phone']}/?text=Olá, agendei os seguintes serviços com você pelo *Navalha*:%0A';

    for (var service in services) {
      url +=
          '*${service['service_name']}* com *${service['professional_name']}* para o dia *${service['service_date']}* às *${service['service_hour']}*.%0A';
      url +=
          '*Observações*: ${service['service_observation'] == '' ? 'Nenhuma observação.' : service['service_observation']}%0A%0A';
    }

    url += 'Até lá!';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
    null;
  }
}
