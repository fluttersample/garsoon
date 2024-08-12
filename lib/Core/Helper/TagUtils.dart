
class TagUtils {
  static final TagUtils _singleton = TagUtils._internal();

  factory TagUtils() {
    return _singleton;
  }

  TagUtils._internal();

  List<String> tags = [];

  //
  //
  // TabFavouritesController? findFavouriteController() {
  //   TabFavouritesController? controller;
  //   for (var i = 0; i < tags.length; i++) {
  //     try {
  //       controller = Get.find<TabFavouritesController>(tag: tags[i]);
  //     } catch (e) {
  //       continue;
  //     }
  //   }
  //
  //   return controller;
  // }


}
