function [interpolant] = bil_interpolate(x)

[rows, columns] = size(x);
interpolant = zeros( rows, columns );

disp([rows, columns])

for row = 2:rows-1
    for col = 2:columns-1
        if x(row,col) == 0
            running_mean = 0;
            for box_row = -1:1
                for box_col = -1:1
                    neighbor = x(row + box_row, col - box_col);
                    if  neighbor ~= 0
                        running_mean = running_mean + neighbor/8;
                    end
                end
            end
            interpolant(row,col) = running_mean;
        else
            interpolant(row,col) = x(row,col);
        end
    end
end
end