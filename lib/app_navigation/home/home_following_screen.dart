import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:verbose_share_world/app_navigation/comments.dart';
import 'package:verbose_share_world/profile/user_profile.dart';
import 'package:verbose_share_world/app_theme/application_colors.dart';
import 'package:verbose_share_world/generated/l10n.dart';

class FollowingItems {
  String image;
  String name;

  FollowingItems(this.image, this.name);
}

class HomeFollowingTabScreen extends StatefulWidget {
  @override
  _HomeFollowingTabScreenState createState() => _HomeFollowingTabScreenState();
}

class _HomeFollowingTabScreenState extends State<HomeFollowingTabScreen> {
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  BannerAd? _anchoredBanner;
  bool _loadingAnchoredBanner = false;

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _anchoredBanner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        AppBar().preferredSize.height;
    List<FollowingItems> _followingItems = [
      FollowingItems('assets/images/Layer707.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer709.png', 'Harshu Makkar'),
      FollowingItems('assets/images/Layer948.png', 'Mrs. White'),
      FollowingItems('assets/images/Layer884.png', 'Marie Black'),
      FollowingItems('assets/images/Layer915.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer946.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer948.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer949.png', 'Emili Williamson'),
      FollowingItems('assets/images/Layer950.png', 'Emili Williamson'),
    ];

    final theme = Theme.of(context);
    return Builder(
      builder: (BuildContext context) {
        if (!_loadingAnchoredBanner) {
          _loadingAnchoredBanner = true;
          _createAnchoredBanner(context);
        }
        return Column(
          children: [
            if (_anchoredBanner != null)
              Container(
                width: _anchoredBanner!.size.width.toDouble(),
                height: _anchoredBanner!.size.height.toDouble(),
                child: AdWidget(ad: _anchoredBanner!),
              ),
            Expanded(
              child: Container(
                height: bHeight,
                color: ApplicationColors.lightGrey,
                child: FadedSlideAnimation(
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: _followingItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                leading: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                UserProfileScreen()));
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(
                                        _followingItems[index].image),
                                  ),
                                ),
                                title: Text(
                                  _followingItems[index].name,
                                  style: theme.textTheme.bodyText1!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  S.of(context).today1000Am,
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      color: ApplicationColors.textGrey,
                                      fontSize: 11),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Image.asset(
                                      'assets/Icons/ic_share.png',
                                      scale: 3,
                                    ),
                                    SizedBox(width: 20),
                                    Icon(
                                      Icons.bookmark_border,
                                      size: 18,
                                      color: ApplicationColors.grey,
                                    ),
                                    SizedBox(width: 20),
                                    Icon(
                                      Icons.more_vert,
                                      size: 18,
                                      color: ApplicationColors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => CommentScreen()));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child:
                                      Image.asset(_followingItems[index].image),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.remove_red_eye,
                                          size: 18,
                                          color: ApplicationColors.grey,
                                        ),
                                        SizedBox(width: 8.5),
                                        Text(
                                          S.of(context).onepointtwok,
                                          style: TextStyle(
                                              color: ApplicationColors.grey,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        FaIcon(
                                          Icons.repeat_rounded,
                                          color: ApplicationColors.grey,
                                          size: 18,
                                        ),
                                        SizedBox(width: 8.5),
                                        Text(
                                          '287',
                                          style: TextStyle(
                                              color: ApplicationColors.grey,
                                              fontSize: 12,
                                              letterSpacing: 0.5),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.chat_bubble_outline,
                                          color: ApplicationColors.grey,
                                          size: 18,
                                        ),
                                        SizedBox(width: 8.5),
                                        Text(
                                          '287',
                                          style: TextStyle(
                                              color: ApplicationColors.grey,
                                              fontSize: 12,
                                              letterSpacing: 0.5),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.favorite_border,
                                          color: ApplicationColors.grey,
                                          size: 18,
                                        ),
                                        SizedBox(width: 8.5),
                                        Text(
                                          S.of(context).eightpointtwok,
                                          style: TextStyle(
                                              color: ApplicationColors.grey,
                                              fontSize: 12,
                                              letterSpacing: 1),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  beginOffset: Offset(0, 0.3),
                  endOffset: Offset(0, 0),
                  slideCurve: Curves.linearToEaseOut,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
