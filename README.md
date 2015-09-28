# Monte_Carlo_Photography README

We have 3 files: Russian_Image_Alignment.m, pyramid_scheme_tnt.m, shift_image_tnt.m, automatic_contrast.m.

Russian_Image_Alignment.m is the main program and it has the main script.
- It reads in the image and makes the pixels into doubles
- It splits the 3 panel image into 3 separate panels by just grabbing each third of the original image
- It crops the 3 images by cutting out 20% of each of the 4 sides. This is how we are only looking at the center cut.
- It calls pyramid_scheme which applies the pyramid_scheme onto the image, returning the optimal x shift and y shift values.
- Then the script calls circshift on the image with those xshift and yshift values, in order to align the images.
- Then the 3 images are layered on top of each other in the correct R G B order 
- Then the result is shown

pyramid_scheme_tnt.m runs the pyramid scheme on the image. 
- It takes in two images: the target and the image, call this IMG. 
  The pyramid_scheme moves IMG around so that it can find the best placement to match it to the target image.
- First the base case is when the image is less than 128 x 128 pixels.
  In that case, we apply the brute force algorithm in shift_image_tnt.m
- If the image is not under 128 x 128 pixels, we shrink in half on both the horizontal and vertical direction.
  Then we recursively call pyramid_scheme_tnt() on the shrunken image so that we can pass the values given by this 
  recursive call to shift_image_tnt(), multiplied by 2. This is how we are speeding up the process (by only brute
  forcing a small image and using the values from that to shift the bigger image, as opposed to brute forcing the
  entire image).
  
shift_image_tnt.m runs the brute force alignment algorithm.
- First it loops through the given window of pixels we want to try out.
  It is the same number of pixels in the x and y directions, but the window size changes depending on the shift values
  calculated by pyramid_scheme_tnt()
- Then it shifts the image by the shift amount of the current loop iteration.
- Then it calculates the SSD of the image.
- The algorithm just selects the x shift and y shifts that correspond to the iteration with the lowest SSD.

Extras:

automatic_contrast.m does linear automatic contrasting by utilizing the exposure thresholds of the R G and B images.
- First it reads in the image and splits the 3 panel image into 3 separate images.
- Then it calls imadjust on the individual images so that the minimum exposure value is set to the minimum and
  the maximum exposure value is set to the maximum of the spectrum.
- Then it plots the images and then shows them.
NOTE: This method was an attempt at automatically contrasting the images, but if we continued to try to do this, we would
      try to match the exposure values to an S curve instead of a straight line.
