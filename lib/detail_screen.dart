import 'package:flutter/material.dart';
import 'package:wisata_bandung_app/model/tourism_place.dart';

var informationTextStyle = const TextStyle(fontFamily: 'Oxygen');

class DetailScreen extends StatelessWidget {
  final TourismPlace place;

  const DetailScreen({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.maxWidth > 800) {
        return DetailWebPage(place: place);
      } else {
        return DetailMobilePage(place: place);
      }
    });
  }
}

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({super.key});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: Colors.red,
      ),
    );
  }
}

class DetailWebPage extends StatefulWidget {
  final TourismPlace place;

  const DetailWebPage({required this.place, super.key});

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 64.0,
          ),
          child: Center(
            child: SizedBox(
              width: 1200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Wisata Bandung',
                    style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(widget.place.imageAsset),
                            ),
                            const SizedBox(height: 16),
                            Scrollbar(
                              controller: _scrollController,
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ListView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  children: widget.place.imageUrls.map((url) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(url),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Card(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  child: Text(
                                    widget.place.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: 'Staatliches',
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today),
                                        const SizedBox(width: 8.0),
                                        Text(
                                          widget.place.openDays,
                                          style: informationTextStyle,
                                        ),
                                      ],
                                    ),
                                    const FavoriteButton(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.access_time),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      widget.place.openTime,
                                      style: informationTextStyle,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    const Icon(Icons.monetization_on),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      widget.place.ticketPrice,
                                      style: informationTextStyle,
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      widget.place.description,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                        fontFamily: 'Oxygen',
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class DetailMobilePage extends StatelessWidget {
  final TourismPlace place;
  const DetailMobilePage({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Hero(
                  tag: place.name,
                  child: Image.asset(
                    // 'images/farm-house.jpg',
                    place.imageAsset,
                    // height: 500,
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const FavoriteButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Text(
                place.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Staatliches'),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        place.openDays,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        place.openTime,
                        style: informationTextStyle,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Icon(Icons.monetization_on),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        place.ticketPrice,
                        style: informationTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                // 'Berada di jalur utama Bandung-Lembang, Farm House menjadi objek wisata yang tidak pernah sepi pengunjung. Selain karena letaknya strategis, kawasan ini juga menghadirkan nuansa wisata khas Eropa. Semua itu diterapkan dalam bentuk spot swafoto Instagramable.',
                place.description,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16.0, fontFamily: 'Oxygen'),
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // children: [
                //   Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Image.network(
                //         'https://media-cdn.tripadvisor.com/media/photo-s/0d/7c/59/70/farmhouse-lembang.jpg',
                //         // height: 200,
                //         // width: 200,
                //         loadingBuilder: (context, child, loadingProgress) {
                //           if (loadingProgress == null) {
                //             return child;
                //           }
                //           return Center(
                //             child: CircularProgressIndicator(
                //               value: loadingProgress.expectedTotalBytes !=
                //                       null
                //                   ? loadingProgress.cumulativeBytesLoaded /
                //                       (loadingProgress.expectedTotalBytes ??
                //                           1)
                //                   : null,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Image.network(
                //         'https://media-cdn.tripadvisor.com/media/photo-w/13/f0/22/f6/photo3jpg.jpg',
                //         // height: 200,
                //         // width: 200,
                //         loadingBuilder: (context, child, loadingProgress) {
                //           if (loadingProgress == null) {
                //             return child;
                //           }
                //           return Center(
                //             child: CircularProgressIndicator(
                //               value: loadingProgress.expectedTotalBytes !=
                //                       null
                //                   ? loadingProgress.cumulativeBytesLoaded /
                //                       (loadingProgress.expectedTotalBytes ??
                //                           1)
                //                   : null,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                //   Padding(
                //     padding: const EdgeInsets.all(4.0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.circular(10),
                //       child: Image.network(
                //         'https://media-cdn.tripadvisor.com/media/photo-m/1280/16/a9/33/43/liburan-di-farmhouse.jpg',
                //         // height: 200,
                //         // width: 200,
                //         loadingBuilder: (context, child, loadingProgress) {
                //           if (loadingProgress == null) {
                //             return child;
                //           }
                //           return Center(
                //             child: CircularProgressIndicator(
                //               value: loadingProgress.expectedTotalBytes !=
                //                       null
                //                   ? loadingProgress.cumulativeBytesLoaded /
                //                       (loadingProgress.expectedTotalBytes ??
                //                           1)
                //                   : null,
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ],

                children: place.imageUrls.map((url) {
                  print(url);
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        url,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
