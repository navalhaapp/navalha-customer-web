// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/schedule/model/model_delete_service_cache.dart';
import 'package:navalha/mobile/schedule/model/model_reserved_time.dart';
import 'package:navalha/mobile/schedule/provider/provider_delete_service_cache.dart';
import 'package:navalha/shared/model/barber_shop_model.dart';
import 'package:navalha/shared/utils.dart';
import '../../../core/assets.dart';
import '../../../core/colors.dart';
import '../../../shared/providers.dart';

class CardServiceSelectedWeb extends StatefulWidget {
  final String observation;
  final String nameService;
  final double price;
  final double originalprice;
  final String initialHour;
  final String finalHour;
  final String professionalName;
  final String professionalImg;
  final String date;
  final String cacheId;
  final int i;
  final Function onConfirm;
  final BarberShop barberShop;
  final bool packageSchedule;

  const CardServiceSelectedWeb({
    Key? key,
    required this.observation,
    required this.nameService,
    required this.price,
    required this.originalprice,
    required this.initialHour,
    required this.finalHour,
    required this.professionalName,
    required this.professionalImg,
    required this.date,
    required this.cacheId,
    required this.i,
    required this.onConfirm,
    required this.barberShop,
    this.packageSchedule = false,
  }) : super(key: key);

  @override
  State<CardServiceSelectedWeb> createState() => _CardServiceSelectedWebState();
}

class _CardServiceSelectedWebState extends State<CardServiceSelectedWeb> {
  bool loading = false;
  late StateController<ReservedTime> reservedTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(
      builder: (context, ref, child) {
        final deleteCacheController =
            ref.watch(DeleteCacheServiceStateController.provider.notifier);
        reservedTime = ref.watch(reservedTimeProvider.state);
        var totalPriceProvider = ref.watch(totalPriceServiceProvider.state);
        var serviceCache = ref.watch(listServicesCacheProvider.state);
        final listResumePayment = ref.watch(listResumePaymentProvider.notifier);
        return Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              margin: const EdgeInsets.only(
                bottom: 15,
                left: 20,
                right: 20,
                top: 10,
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                color: Color.fromARGB(255, 28, 28, 28),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.nameService,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                          ),
                        ),
                        Visibility(
                          visible: !widget.packageSchedule,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Visibility(
                                visible: widget.originalprice != widget.price,
                                child: Text(
                                  'R\$ ${widget.originalprice.toStringAsFixed(2).replaceAll('.', ',')} ',
                                  style: TextStyle(
                                    color: widget.originalprice != widget.price
                                        ? colorFontUnable116116116
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                    decoration:
                                        widget.originalprice != widget.price
                                            ? TextDecoration.lineThrough
                                            : null,
                                    fontSize:
                                        widget.originalprice != widget.price
                                            ? 10
                                            : 17,
                                  ),
                                ),
                              ),
                              Text(
                                'R\$ ${widget.price.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${widget.initialHour} - ${widget.finalHour}',
                      style: TextStyle(
                        color: colorFontUnable116116116,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: size.width,
                      height: size.height * 0.0008,
                      color: colorFontUnable116116116,
                    ),
                    const SizedBox(height: 10),
                    _ContainerHeaderItem(
                      label: 'Profissional',
                      value: Row(
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                              widget.professionalName,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 153, 153, 153),
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            padding: EdgeInsets.zero,
                            width: 20,
                            height: 20,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: SizedBox(
                                    width: size.width * 0.05,
                                    height: size.width * 0.05,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: imgLoading3,
                                      image: widget.professionalImg,
                                      fit: BoxFit.cover,
                                      fadeInDuration:
                                          const Duration(milliseconds: 500),
                                      fadeInCurve: Curves.easeIn,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 3),
                    _ContainerHeaderItem(
                      label: 'Dia',
                      value: Text(
                        formatarDataMMddYYYYToDDmmYYYY(widget.date),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 153, 153, 153),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: widget.observation.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Row(
                                children: [
                                  Text(
                                    textAlign: TextAlign.start,
                                    'Observações',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text(
                                textAlign: TextAlign.start,
                                widget.observation,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 153, 153, 153),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -10,
              right: 10,
              child: IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  ResponseDeleteServiceCache response =
                      await deleteCacheController.deleteCacheService(
                    widget.cacheId,
                  );
                  if (response.status == 'success') {
                    serviceCache.state.removeAt(widget.i);
                    listResumePayment.state.services.removeAt(widget.i);
                    showSnackBar(context, 'Serviço removido');
                    widget.onConfirm();
                    if (serviceCache.state.isEmpty) {
                      totalPriceProvider.state.clear();
                      totalPriceProvider.state.discount = null;
                    }
                    Navigator.of(context).pushNamed('/resume');
                  } else {
                    showSnackBar(context, 'Ops, algo aconteceu!');
                  }
                  setState(() {
                    loading = false;
                  });
                },
                icon: !loading
                    ? const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      )
                    : const SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _ContainerHeaderItem extends StatelessWidget {
  const _ContainerHeaderItem({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        value
      ],
    );
  }
}

String formatarData(String data) {
  List<String> partes = data.split('-');
  String ano = partes[0];
  String mes = partes[1];
  String dia = partes[2];

  return dia + mes + ano;
}

String formatarDataMMddYYYYToDDmmYYYY(String data) {
  List<String> partes = data.split('-');
  String dia = partes[1];
  String mes = partes[0];
  String ano = partes[2];

  return '$dia/$mes/$ano';
}
