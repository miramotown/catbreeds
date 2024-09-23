class ImageUtil {

  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getSvgPath(String name, {String format = 'svg'}) {
    return 'assets/svg/$name.$format';
  }

  static String getLottiePath(String name, {String format = 'json'}) {
    return 'assets/lottie/$name.$format';
  }

  static String getGifPath(String name, {String format = 'gif'}) {
    return 'assets/gif/$name.$format';
  }

}