
function [avg_slope] = avgSlope_Last5Years(nitrogen_per_Acre)
    avg_slope = (nitrogen_per_Acre(end) - nitrogen_per_Acre(end - 4)) / 5;
end