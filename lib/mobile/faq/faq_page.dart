import 'package:flutter/material.dart';
import 'package:navalha/core/colors.dart';
import 'package:navalha/mobile/faq/widgets/body_faq.dart';
import 'package:navalha/mobile/faq/widgets/schedule_help_button_.dart';
import 'package:navalha/shared/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/assets.dart';
import '../drawer/drawer_page.dart';
import '../../shared/shows_dialogs/dialog.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);
  static const route = '/faq-page';

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        top: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          extendBody: true,
          backgroundColor: colorBackground181818,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, size: 17),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.transparent,
            title: Center(
              child: Text(
                'Dúvidas frequentes',
                maxLines: 1,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  shadows: const [
                    Shadow(
                      blurRadius: 10,
                      offset: Offset(1, 1),
                      color: Color.fromARGB(255, 0, 0, 0),
                    )
                  ],
                ),
              ),
            ),
          ),
          endDrawer: const DrawerPage(),
          body: const FaqBody(),
          floatingActionButton: ScheduleHelpButton(
            labelName: 'Ajuda',
            onPressed: () => showCustomDialog(context, const _FaqDialog()),
          ),
        ),
      ),
    );
  }
}

class _FaqDialog extends StatelessWidget {
  const _FaqDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AlertDialog(
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
          'Ainda ficou com alguma dúvida?',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      content: const Text(
        textAlign: TextAlign.center,
        'Entre em contato, que responderemos o mais breve possível!',
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 33, 33, 33)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.04,
                      child: Image.asset(imgLogoGoogle),
                    ),
                    SizedBox(width: size.width * 0.02),
                    const Text(
                      'Gmail',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () => _launch(),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all<Color>(
                    colorContainers353535,
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 33, 33, 33)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.05,
                      child: Image.asset(imgLogoWhatsapp),
                    ),
                    SizedBox(width: size.width * 0.02),
                    const Text(
                      'WhatsApp',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () => launchInBrowser(urlWhats),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _launch() async {
  if (!await launchUrl(emailLaunchUri)) {
    throw Exception('Could not launch $emailLaunchUri');
  }
}

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri emailLaunchUri = Uri(
  scheme: 'mailto',
  path: 'navalha_app@outlook.com',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Example Subject & Symbols are allowed!',
  }),
);
