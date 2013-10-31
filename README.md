ColorTunes
==========

This is a HTML5/JavaScript version of the iTunes 11 album view,
which is able to detect the colors in an album cover and generate a color scheme
for its track list based on the reduced color space.

Color palettes generation is based on the [MMCQ (median cut color quantization) algorithm *(PDF)*](http://www.leptonica.com/papers/mediancut.pdf)
from the [Leptonica library](http://www.leptonica.com/).

This branch is a place for me to store changes to the core application
for use on colors on [oychang.com](http://oychang.com/).


Demo
----
* [http://dannvix.github.com/ColorTunes](http://dannvix.github.com/ColorTunes/)
* [oychang.com](http://oychang.com/)


Build
-----
Requires `coffee` in `$PATH`.

Optional: `yui-compressor` (for minification)

Assuming in root project directory, run `make`.


Usage
-----
Signature of coffee function:

    # Extract three main colors from an image.
    # Args: [[imageId] [colorFunc]]
    # imageId: the id of an <img> tag with a valid src to use as our image
    # colorFunc: a function taking one argument, a three-el list [bg, fg1, fg2]
    #            of hex color values; e.g. ['000000', 'ffffff', '000fff']
    @color = (imageId="palette-image", colorFunc) ->

In HTML:

    ...
    <img src="img.jpg" id="palette-image">
    ...
    <script type="text/javascript" src="colors.min.js"></script>
    <script type="text/javascript">
        color("palette-image", function(p) { console.log(p); });
    </script>


Acknowledgements
----------------
Million thanks to [Zhusee Zhang](http://twitter.com/zhusee2) for the [page design](http://github.com/zhusee2/coverTunes). Thank [Nick Rabinowitz](http://github.com/nrabinowitz) for his [JavaScript port](https://gist.github.com/1104622) of the MMCQ algorithm.
