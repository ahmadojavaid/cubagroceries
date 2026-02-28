import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../main/utils/AppWidget.dart';
import 'components/hero_layout_card_component.dart';
import 'components/uncontained_layout_card_component.dart';

class CarouselViewSliderScreen extends StatefulWidget {
  static String tag = '/carousel_view_slider';

  final bool isDirect;

  CarouselViewSliderScreen({this.isDirect = false});

  @override
  _CarouselViewSliderScreenState createState() => _CarouselViewSliderScreenState();
}

class _CarouselViewSliderScreenState extends State<CarouselViewSliderScreen> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'CarouselView Slider', isDashboard: widget.isDirect),
      body: ListView(
        padding: EdgeInsets.only(left: 4, bottom: 16, right: 4),
        children: <Widget>[
          Container(
            height: 300,
            child: CarouselView.weighted(
              controller: controller,
              itemSnapping: true,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              flexWeights: const <int>[1, 7, 1],
              children: ImageInfoData.values.map((ImageInfoData image) {
                return HeroLayoutCardComponent(imageInfo: image);
              }).toList(),
            ),
          ),
          28.height,
          const Text(
            'Multi-browse layout',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ).paddingLeft(8),
          8.height,
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 50),
            child: CarouselView.weighted(
              flexWeights: const <int>[1, 2, 3, 2, 1],
              consumeMaxWeight: false,
              children: List<Widget>.generate(20, (int index) {
                return ColoredBox(
                  color: Colors.primaries[index % Colors.primaries.length].withValues(alpha: 0.8),
                  child: const SizedBox.expand(),
                );
              }),
            ),
          ),
          20.height,
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: CarouselView.weighted(
                flexWeights: const <int>[3, 3, 3, 2, 1],
                consumeMaxWeight: false,
                children: CardInfo.values.map((CardInfo info) {
                  return ColoredBox(
                    color: info.backgroundColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(info.icon, color: info.color, size: 32),
                          Text(
                            info.label,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            overflow: TextOverflow.clip,
                            softWrap: false,
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()),
          ),
          28.height,
          const Text(
            'Uncontained layout',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ).paddingLeft(8),
          8.height,
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: CarouselView(
              itemExtent: 330,
              shrinkExtent: 200,
              children: List<Widget>.generate(20, (int index) {
                return UncontainedLayoutCard(index: index, label: 'Show $index');
              }),
            ),
          )
        ],
      ),
    );
  }
}

enum ImageInfoData {
  image0('The Flow', 'Sponsored | Season 1 Now Streaming', 'images/integrations/img/carousal_slider_img_1.png'),
  image1('Through the Pane', 'Sponsored | Season 1 Now Streaming', 'images/integrations/img/carousal_slider_img_2.png'),
  image2('Iridescence', 'Sponsored | Season 1 Now Streaming', 'images/integrations/img/carousal_slider_img_3.png'),
  image3('Sea Change', 'Sponsored | Season 1 Now Streaming', 'images/integrations/img/carousal_slider_img_4.png'),
  image4('Blue Symphony', 'Sponsored | Season 1 Now Streaming', 'images/integrations/img/carousal_slider_img_5.png'),
  image5('When It Rains', 'Sponsored | Season 1 Now Streaming', 'images/integrations/img/carousal_slider_img_6.png');

  const ImageInfoData(this.title, this.subTitle, this.url);

  final String title;
  final String subTitle;
  final String url;
}

enum CardInfo {
  camera('Cameras', Icons.video_call, Color(0xff2354C7), Color(0xffECEFFD)),
  lighting('Lighting', Icons.lightbulb, Color(0xff806C2A), Color(0xffFAEEDF)),
  climate('Climate', Icons.thermostat, Color(0xffA44D2A), Color(0xffFAEDE7)),
  wifi('Wifi', Icons.wifi, Color(0xff417345), Color(0xffE5F4E0)),
  media('Media', Icons.library_music, Color(0xff2556C8), Color(0xffECEFFD)),
  security('Security', Icons.crisis_alert, Color(0xff794C01), Color(0xffFAEEDF)),
  safety('Safety', Icons.medical_services, Color(0xff2251C5), Color(0xffECEFFD)),
  more('Add', Icons.add, Color(0xff201D1C), Color(0xffE3DFD8));

  const CardInfo(this.label, this.icon, this.color, this.backgroundColor);

  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;
}
