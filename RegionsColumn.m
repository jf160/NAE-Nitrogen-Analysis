function [col] = RegionsColumn(landDataRaw)
%Countycodes are in col 2
col = table2array(landDataRaw(:,2));
col = cell2mat(col);
col = str2num(col);
for i=1:length(col)
    %southwest SW = 1
    if col(i) > 4000 && col(i) < 5000
        col(i) = 1;
    end
    if col(i) > 35000 && col(i) < 36000
        col(i) = 1;
    end
    if col(i) > 40000 && col(i) < 41000
        col(i) = 1;
    end
    if col(i) > 48000 && col(i) < 49000
        col(i) = 1;
    end
    %West 2
    if col(i) > 6000 && col(i) < 7000
        col(i) = 2;
    end
    if col(i) > 32000 && col(i) < 33000
        col(i) = 2;
    end
    if col(i) > 49000 && col(i) < 50000
        col(i) = 2;
    end
    if col(i) > 8000 && col(i) < 9000
        col(i) = 2;
    end
    if col(i) > 56000 && col(i) < 57000
        col(i) = 2;
    end
    if col(i) > 30000 && col(i) < 31000
        col(i) = 2;
    end
    if col(i) > 16000 && col(i) < 17000
        col(i) = 2;
    end
    if col(i) > 41000 && col(i) < 42000
        col(i) = 2;
    end
    if col(i) > 53000 && col(i) < 54000
        col(i) = 2;
    end
    %Midwest MW 3
    if col(i) > 38000 && col(i) < 39000
        col(i) = 3; %ND
    end
    if col(i) > 46000 && col(i) < 47000
        col(i) = 3; %SD
    end
    if col(i) > 31000 && col(i) < 32000
        col(i) = 3; %NE
    end
    if col(i) > 20000 && col(i) < 21000
        col(i) = 3; %KS
    end
    if col(i) > 27000 && col(i) < 28000
        col(i) = 3; %MN
    end
    if col(i) > 19000 && col(i) < 20000
        col(i) = 3; %IA
    end
    if col(i) > 29000 && col(i) < 30000
        col(i) = 3; %MO
    end
    if col(i) > 55000 && col(i) < 56000
        col(i) = 3; %WI
    end
    if col(i) > 17000 && col(i) < 18000
        col(i) = 3; %IL
    end
    if col(i) > 26000 && col(i) < 27000
        col(i) = 3; %MI
    end
    if col(i) > 18000 && col(i) < 19000
        col(i) = 3; %IN
    end
    if col(i) > 39000 && col(i) < 40000
        col(i) = 3; %OH
    end
    %Southeast SE 4
    if col(i) > 5000 && col(i) < 6000
        col(i) = 4; %AR
    end
    if col(i) > 22000 && col(i) < 23000
        col(i) = 4; %LA
    end
    if col(i) > 28000 && col(i) < 29000
        col(i) = 4; %MS
    end
    if col(i) > 21000 && col(i) < 22000
        col(i) = 4; %KY
    end
    if col(i) > 47000 && col(i) < 48000
        col(i) = 4; %TN
    end
    if col(i) > 1000 && col(i) < 2000
        col(i) = 4; %AL
    end
    if col(i) > 54000 && col(i) < 55000
        col(i) = 4; %WV
    end
    if col(i) > 51000 && col(i) < 52000
        col(i) = 4; %VA
    end
    if col(i) > 37000 && col(i) < 38000
        col(i) = 4; %NC
    end
    if col(i) > 45000 && col(i) < 46000
        col(i) = 4; %SC
    end
    if col(i) > 13000 && col(i) < 14000
        col(i) = 4; %GA
    end
    if col(i) > 12000 && col(i) < 13000
        col(i) = 4; %FL
    end
    if col(i) == 11001
        col(i) = 4; %DC
    end
    if col(i) > 24000 && col(i) < 25000
        col(i) = 4; %MD
    end
    if col(i) > 10000 && col(i) < 11000
        col(i) = 4; %DE
    end
    %Northeast NE 5
    if col(i) > 34000 && col(i) < 35000
        col(i) = 5; %NJ
    end
    if col(i) > 42000 && col(i) < 43000
        col(i) = 5; %PA
    end
    if col(i) > 36000 && col(i) < 37000
        col(i) = 5; %NY
    end
    if col(i) > 9000 && col(i) < 10000
        col(i) = 5; %CT
    end
    if col(i) > 44000 && col(i) < 45000
        col(i) = 5; %RI
    end
    if col(i) > 25000 && col(i) < 26000
        col(i) = 5; %MA
    end
    if col(i) > 50000 && col(i) < 51000
        col(i) = 5; %VT
    end
    if col(i) > 33000 && col(i) < 34000
        col(i) = 5; %NH
    end
    if col(i) > 23000 && col(i) < 24000
        col(i) = 5; %ME
    end
    

end