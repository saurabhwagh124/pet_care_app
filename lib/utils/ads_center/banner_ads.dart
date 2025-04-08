import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAds extends StatefulWidget {
  const BannerAds({super.key});

  @override
  State<BannerAds> createState() => _BannerAdsState();
}

class _BannerAdsState extends State<BannerAds> {
  final adUnitId = 'ca-app-pub-8462707009151961/5494629557';
  // final adUnitId = 'ca-app-pub-3940256099942544/6300978111';
  //test ad
  BannerAd? _bannerAd;
  AdSize size = const AdSize(height: 60, width: 350);

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  void _loadAd() {
    log("Loading ad .....");
    final bannerAd = BannerAd(
      size: size,
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
            log(ad.toString());
          });
        },
        onAdFailedToLoad: (ad, error) {
          log('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );
    bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: SizedBox(
              width: size.width.toDouble(),
              height: size.height.toDouble(),
              child: AdWidget(ad: _bannerAd!),
            ),
          );
  }
}
