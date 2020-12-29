function [acres] = LandAreaConversion(landData)
%input the land data matrix, this function assumes the land area is in
%[mi^2]
%the land area is in the 4th column
acres = [];
landCol = table2array(landData(:,4));
total = length(landCol);
for i=1:total
    acres(i) = landCol(i)*640;
end
acres = acres';
end
