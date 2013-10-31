###!
color-tunes.coffee
Copyright 2012 Shao-Chung Chen. Modified 2013 Oliver Chang.
Licensed under the MIT license (http://www.opensource.org/licenses/mit-license.php)
###

getColorMap = (canvas, sx, sy, w, h, nc=8) ->
  pdata = canvas.getContext("2d").getImageData(sx, sy, w, h).data
  pixels = []
  for y in [sy...(sy + h)] by 1
    indexBase = (y * w * 4)
    for x in [sx...(sx + w)] by 1
      index = (indexBase + (x * 4))
      pixels.push [pdata[index], pdata[index+1], pdata[index+2]] # [r, g, b]
  (new MMCQ).quantize pixels, nc

colorDist = (a, b) ->
  square = (n) -> (n * n)
  (square(a[0] - b[0]) + square(a[1] - b[1]) + square(a[2] - b[2]))

rgbToHex = (arr) ->
  decimalToHex = (n) ->
    n = n.toString(16)
    if n.length < 2 then n += "0" else n

  triple.map(decimalToHex).join("") for triple in arr

# Extract three main colors from an image.
# Args: [[imageId] [colorFunc]]
# imageId: the id of an <img> tag with a valid src to use as our image
# colorFunc: a function taking one argument, a three-el list [bg, fg1, fg2]
#            of hex color values; e.g. ['000000', 'ffffff', '000fff']
@color = (imageId="palette-image", colorFunc) ->
  image = new Image
  image.src = document.getElementById(imageId).src
  canvas = document.createElement('canvas')

  window.onload = ->
    # Use a small, square area for the image.
    # Do not show the image, but use this for computation purposes.
    # 36px x 36px is an arbitrarily chosen magic number based on
    # this SO answer: http://stackoverflow.com/a/13675803/1832800
    image.height = image.width = 36

    canvas.width = image.width
    canvas.height = image.height
    canvas.getContext("2d").drawImage image, 0, 0, image.width, image.height

    colorMap = getColorMap canvas, 0, 0, image.width, image.height, 10
    palette = colorMap.cboxes.map (cbox) -> { count: cbox.cbox.count(), rgb: cbox.color }
    palette.sort (a, b) -> (b.count - a.count)
    bgColor = palette.shift().rgb

    distanceFrom = (color) -> colorDist bgColor, color.rgb
    fgPalette = palette
    palette.sort (a, b) -> distanceFrom(b) - distanceFrom(a)
    fgColor = fgPalette.shift().rgb
    fgColor2 = fgPalette.shift().rgb

    colors = rgbToHex [bgColor, fgColor, fgColor2]
    if colorFunc
      colorFunc colors
