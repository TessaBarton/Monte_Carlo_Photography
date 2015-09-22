function [x_shift, y_shift] = shift_image_tnt( target, image, window, x_guess, y_guess)

 
lowestSSD = Inf;  

for v_offset = x_guess - window : x_guess + window
    for h_offset = y_guess - window : y_guess + window
        
        shiftedImage = circshift(image, [v_offset h_offset]);

        %% Loop through entire image and calculate SSD
        SSD = sum(sum((target-shiftedImage).^2));
        %% Replace the SSD if this offset produces better match
        if(SSD < lowestSSD)
            lowestSSD = SSD;
            x_shift = v_offset;
            y_shift = h_offset;
        end
    end
end
