function [interpolant] = filter_bil_interpolate(cfa_result)
box_filter = [ 2/16 2/16 2/16; 2/16 0 2/16; 2/16 2/16 2/16];
interpolant = imfilter(cfa_result, box_filter, 'replicate');
end

