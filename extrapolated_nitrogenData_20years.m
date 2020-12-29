function [extrapolated_data] = extrapolated_nitrogenData_20years(nitrogen_data, average_slope)
    % takes in the nitrogen
    % only returns extrapolated data
    extrapolated_data = [nitrogen_data(end)];
    for (i = 1:1:20)
        extrapolated_data(end + 1) = extrapolated_data(end) + average_slope;
    end
end
