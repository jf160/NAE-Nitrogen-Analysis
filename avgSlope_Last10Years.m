function [avg_slope] = avgSlope_Last10Years(nitrogen_per_Acre)
    avg_slope = (nitrogen_per_Acre(end) - nitrogen_per_Acre(end - 9)) / 10;
end