function  [x_guess, y_guess] = pyramid_scheme_tnt( target, image )

[height, width] = size(target);
   if((height < 128) && (width < 128)) 
       [x_guess, y_guess] = shift_image_tnt( target, image, 20, 0, 0 );
   else
       resize_t = imresize(target, 1/2);
       resize_i = imresize(image, 1/2);
       [x_shift, y_shift] = pyramid_scheme_tnt( resize_t, resize_i);
       % align
       [x_guess, y_guess] = shift_image_tnt( target, image, 4, 2*x_shift, 2*y_shift );
   end
  
end