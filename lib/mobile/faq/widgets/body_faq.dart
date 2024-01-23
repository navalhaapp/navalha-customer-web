import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:navalha/mobile/faq/faq_page.dart';
import 'package:navalha/shared/utils.dart';
import 'package:navalha/shared/widgets/page_transition.dart';
import 'package:navalha/shared/widgets/widget_empty.dart';
import '../../../../shared/shimmer/shimmer_faq.dart';
import '../provider/provider_faq.dart';
import 'expanded_faq.dart';

class FaqBody extends StatefulWidget {
  const FaqBody({Key? key}) : super(key: key);

  @override
  State<FaqBody> createState() => _FaqBodyState();
}

class _FaqBodyState extends State<FaqBody> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer(
      builder: (context, ref, child) {
        final getFaqProvider = ref.watch(faqListProvider(''));
        return SingleChildScrollView(
          child: Column(
            children: [
              getFaqProvider.when(
                data: (data) {
                  return data.result!.isNotEmpty
                      ? SizedBox(
                          height: size.height,
                          width: size.width,
                          child: ListView.builder(
                            itemCount: data.result!.length,
                            itemBuilder: (context, i) => Column(
                              children: [
                                ExpandedFaq(
                                  description: data.result![i].description!,
                                  sizeExpanded: 0.05,
                                  sizeNotExpanded:
                                      data.result![i].description!.length *
                                          0.00085,
                                  title: data.result![i].title!,
                                ),
                                data.result!.length - 1 == i
                                    ? SizedBox(height: size.height * 0.2)
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: WidgetEmpty(
                            topSpace: size.height * 0.2,
                            title: 'Ooops, erro!',
                            subTitle: 'Erro ao carregar dúvidas frequentes',
                            text: 'Tentar novamente',
                            onPressed: () {
                              navigationFadePush(const FaqPage(), context);
                              setState(() {});

                              showSnackBar(context, 'Ops, algo aconteceu!');
                            },
                          ),
                        );
                },
                error: (error, stackTrace) => Center(
                  child: WidgetEmpty(
                    topSpace: size.height * 0.2,
                    title: 'Ooops, erro!',
                    subTitle: 'Erro ao carregar dúvidas frequentes',
                    text: 'Tentar novamente',
                    onPressed: () {
                      navigationFadePush(const FaqPage(), context);
                    },
                  ),
                ),
                loading: () => const ShimmerFaq(),
              ),
            ],
          ),
        );
      },
    );
  }
}
