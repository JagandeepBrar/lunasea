part of tautulli_commands;

Future<Uint8List?> _commandPMSImageProxy(
  Dio client, {
  String? image,
  int? ratingKey,
  int? width,
  int? height,
  int? opacity,
  String? background,
  int? blur,
  String? imageFormat,
  TautulliFallbackImage? fallbackImage,
  bool? refresh,
}) async {
  if (image == null && ratingKey == null)
    assert(false, 'image and ratingKey cannot both be null.');
  if (image != null)
    assert(ratingKey == null, 'image and ratingKey cannot both be defined.');
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'pms_image_proxy',
      if (image != null) 'img': image,
      if (ratingKey != null) 'rating_key': ratingKey,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (opacity != null) 'opacity': opacity,
      if (background != null) 'background': background,
      if (blur != null) 'blur': blur,
      if (imageFormat != null) 'img_format': imageFormat,
      if (fallbackImage != null && fallbackImage != TautulliFallbackImage.NULL)
        'fallback': fallbackImage,
      if (refresh != null) 'refresh': refresh,
    },
    options: Options(
      responseType: ResponseType.bytes,
    ),
  );
  return (response.data as Uint8List?);
}
