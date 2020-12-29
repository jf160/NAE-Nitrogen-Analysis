%% Housekeeping Commands
clc
clear
close all

% land = readtable('LND01.xls');
% nitrogen = readtable('NAE Nitrogen Data.xlsx');
% county_codes = land.STCOU;
% county_codes = cell2mat(county_codes);
% new_county_codes = county_codes(:,3:5);
% county_code_ints = [];
% for i = 1:1:length(new_county_codes)
% 	county_code_ints = [county_code_ints;str2double(new_county_codes(i))];
% end

% county_codes = cell2mat(county_codes);

% Land = land data in [miles ^2].
% Nitrogen_Fertilizer_Use = nitrogen use in [kg] down to the county level.
% C = control.
% cost_nitrogen = cost of nitrogen [$].
% county_nitrogen = Nitrogen fertilizer use per county [kg].
% county_land = Land Area per county [acre].
% prompt = input prompt.
% landAcre = land data converted to [acres].
% nitroPerAcre = nitrogen per acre [kg/acre].
% regionTag = Tells what region given county is in varies 1-5.
% regionNPA = nitrogen per acre of each region 
% SW = symbol representing the southwest region.
% W = symbol representing the western region.
% MW = symbol representing the mid-west region.
% SE = symbol representing the woutheast region.
% NE = symbol representing the northeast region.
% time = year vector for plots 1987-2027 [yr].
% SW_slope = linear slope of nitrogen used per acre per year in the southwest region. 
% W_slope = linear slope of nitrogen used per acre per year in the western region. 
% MW_slope = linear slope of nitrogen used per acre per year in the midwest region. 
% SE_slope = linear slope of nitrogen used per acre per year in the southeast region. 
% NE_slope = linear slope of nitrogen used per acre per year in the northeast region.
% extrapolated_data_SW = extrapolated nitrogen used per acre for the next twenty years in the southwestern region. 
% extrapolated_data_W = extrapolated nitrogen used per acre for the next twenty years in the western region. 
% extrapolated_data_MW = extrapolated nitrogen used per acre for the next twenty years in the midwest region. 
% extrapolated_data_SE = extrapolated nitrogen used per acre for the next twenty years in the southeast region. 
% extrapolated_data_NE = extrapolated nitrogen used per acre for the next twenty years in the northeast region. 
%US_mean = the mean nitrogen per acre for all 5 regions
% SW_last = the last value in the predicted nitrogen trend for SW
% MW_last = the last value in the predicted nitrogen trend for MW
% SE_last = the last value in the predicted nitrogen trend for SE
% NE_last = the last value in the predicted nitrogen trend for NE
%% ENGI 1331 NAE Project - Maintaining Nitrogen Cycle
% Christian Arreola, Nathan Cao, Justin Francisco, Sameer Ahmad, Aiden Dalrymple, Colby Bowers

% Referenced Inputs
Nitrogen_Fertilizer_Use = readtable('NitrogenDataFormatted.xlsx'); % [kg] ; nitrogen data set of how much nitrogen has been produced in each in the nation from 1987 to 2006.
Land = readtable('LandAreaFormatted.xls'); % [miles ^ 2] ; land mass data set for each county in the nation.



% Data Validation
% check if length is right; then string compare; this is to check between land area and nitrogen data datasets

% Length Validation
[Land_row, Land_col] = size(Land); % [-]
[NitrogenUsage_row, NitrogenUsage_col] = size(Nitrogen_Fertilizer_Use); % [-]
if NitrogenUsage_row ~= Land_row
	error('Data sets do not correspond. Terminating program.');
end

% Negative Value Validation and User inputs
% checks if the inputted values are negative values, and if so will repeatedly ask the user to input a positive value until done so.
C = 0;
while C == 0
cost_nitrogen = input('Enter in an appropriate cost of fertilizer [$/kg]: '); % [$/kg]

if  cost_nitrogen < 0
	C = 0;
	warning('Invalid input, negative numbers not permitted. Re-enter data.');
else
	C = 1;
end
end
    
% County Validation
term = 0;
test = Land.Areaname;
for ii = 1:1:Land_row
	% nitrogen - county is in col 4
	% land - county is paired with state in col 1, strsplit() with ‘,’ delimiter to get county
	county_nitrogen = Nitrogen_Fertilizer_Use.CO(ii); % [-]
    
	county_land = strsplit(char(test(ii)), ','); % [-]
	county_land = county_land(1); % [-]
    
	if (~(strcmpi(char(county_land), char(county_nitrogen))))
        prompt = sprintf('Counties do not match correspond at row %0.0f. Please edit data',ii);
        fprintf('\n');
    	warning(prompt);
        term = 1;
	end
end
if term == 1
    error('Counties do not match. Terminating program.');
end

%convert to all land from mi^2 acres
landAcre = LandAreaConversion(Land);
%changes the land from acres to kg per acre
nitroPerAcre = NitrogenPerAcre(landAcre,Nitrogen_Fertilizer_Use);

%creates a tag ranging from 1 - 5 to group each county into a region
regionTag = RegionsColumn(Land);


[NPAr,NPAc] = size(nitroPerAcre);
regionNPA = [];

SW = [];
W = [];
MW = [];
SE = [];
NE = [];

%uses the region tags to add up the total nitrogen into their respective
%regions
for j=1:NPAr
    if regionTag(j) == 1
        SW = [SW; nitroPerAcre(j,:)];
    end
    if regionTag(j) == 2
        W = [W; nitroPerAcre(j,:)];
    end
    if regionTag(j) == 3
        MW = [MW; nitroPerAcre(j,:)];
    end
    if regionTag(j) == 4
        SE = [SE; nitroPerAcre(j,:)];
    end
    if regionTag(j) == 5
        NE = [NE; nitroPerAcre(j,:)];
    end
    
end

%adds the counties nitrogen per acre up for each year to get the total
%nitrogen consumption for each year for the respective region
SW = sum(SW);
W = sum(W);
MW = sum(MW);
SE = sum(SE);
NE = sum(NE);

%getting the mean for each region
SW_mean = mean(SW);
W_mean = mean(W);
MW_mean = mean(MW);
SE_mean = mean(SE);
NE_mean = mean(NE);

%getting the nation mean for reference
US_mean = [SW_mean,W_mean,MW_mean,SE_mean,NE_mean];
US_mean = mean(US_mean);


%plotting all of the experimental data
time = 1987:1:2006;

subplot(2,3,1)
plot(time, SW, 'o');
title('Nitrogen per Acre in the Southwest')
xlabel('Time (t) [years]')
ylabel('Nitrogen per Acre [kg/acre]');
grid on

subplot(2,3,2);
plot(time,W,'ro');
title('Nitrogen per Acre Over Time in the West')
xlabel('Time (t) [years]')
ylabel('Nitrogen per Acre [kg/acre]');
grid on

subplot(2,3,3);
plot(time,MW,'go');
title('Nitrogen per Acre Over Time in the Midwest')
xlabel('Time (t) [years]')
ylabel('Nitrogen per Acre [kg/acre]');
grid on

subplot(2,3,4);
plot(time,SE,'mo');
title('Nitrogen per Acre Over Time in the Southeast')
xlabel('Time (t) [years]')
ylabel('Nitrogen per Acre [kg/acre]');
grid on

subplot(2,3,5);
plot(time,NE,'ko');
title('Nitrogen per Acre Over Time in the Northeast')
xlabel('Time (t) [years]')
ylabel('Nitrogen per Acre [kg/acre]');
grid on

% data extrapolation 
SW_slope = avgSlope_Last10Years(SW);
extrapolated_data_SW = extrapolated_nitrogenData_20years(SW, SW_slope);
SW = [SW, extrapolated_data_SW];

%The west has too much missing data to draw a conclusion

% W_slope = avgSlope_Last5Years(W);
% extrapolated_data_W = extrapolated_nitrogenData_20years(W, W_slope);
% W = [W, extrapolated_data_W];

MW_slope = avgSlope_Last10Years(MW);
extrapolated_data_MW = extrapolated_nitrogenData_20years(MW, MW_slope);
MW = [MW, extrapolated_data_MW];

SE_slope = avgSlope_Last10Years(SE);
extrapolated_data_SE = extrapolated_nitrogenData_20years(SE, SE_slope);
SE = [SE, extrapolated_data_SE];

NE_slope = avgSlope_Last10Years(NE);
extrapolated_data_NE = extrapolated_nitrogenData_20years(NE, NE_slope);
NE = [NE, extrapolated_data_NE];

time = 1987:1:2027;


%plotting the predictions based on the average slope of the last 10 years
%of data
figure(2);
plot(time,NE,'k');
title('Predicted Trends for Each Region (Contiguous US)');
xlabel('Time (t) [years]')
ylabel('Nitrogen per Acre [kg/acre]');
xlim([1975 2030]);
hold on
plot(time,SE,'m');
plot(time,MW,'g');
% plot(time,W,'r');
plot(time, SW);
yline(US_mean,'r--');
legend('NE','SE','MW','SW','US Mean','location','northwest');

%predicted corrections - or how off from the national mean each region is
SW_last = SW(end);

MW_last = MW(end);
SE_last = SE(end);
NE_last = NE(end);

%subtracts the national mean from the predicted value in 2027, which
%suggests how the US should shift consumption of nitrogen at that time
SW_correction = US_mean - SW_last;
MW_correction = US_mean - MW_last;
SE_correction = US_mean - SE_last;
NE_correction = US_mean - NE_last;

correctionVector = [SW_correction, MW_correction, SE_correction, NE_correction];
regionNames = ["Southwest","Midwest","Southeast","Northeast"];

saveas(figure(1),'Nitrogen Trend per Region (Contiguous US).jpg');
saveas(figure(2),'Nitrogen Future Prediction (Contiguous US).jpg');

for i=1:4
    if correctionVector(i) < 0
        prompt = sprintf('\nFor the %s, nitrogen use should be reduced by %0.2f [kg/acre]. It will save %0.2f $ [kg/acre]',regionNames(i), abs(correctionVector(i)),abs(correctionVector(i))*cost_nitrogen); 
        fprintf(prompt);
    else
        prompt = sprintf('\nFor the %s, nitrogen use should be increased by %0.2f [kg/acre]. It will cost %0.2f $ [kg/acre]',regionNames(i), abs(correctionVector(i)),abs(correctionVector(i))*cost_nitrogen);
        fprintf(prompt);
    end
end

fprintf('\nNote: the West is not included in the final graph because there was too little values to accurately make a future prediction.');