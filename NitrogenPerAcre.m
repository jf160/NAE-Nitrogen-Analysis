function [nitroPerAcre] = NitrogenPerAcre(landAcre,nitrogenData)
    %acre land is assumed to be a column vector
    %nitrogen is assumed to be a matrix, with nitrogen data starting at col 3
    rawNitro = table2cell(nitrogenData);
    rawNitro(:,1) = [];
    rawNitro(:,1) = [];
    rawNitro(:,1) = [];
    rawNitro = cell2mat(rawNitro);
    %makes sure there is no division by 0
    for k=1:length(landAcre)
        if landAcre(k) < 1
            landAcre(k) = 1;
        end
    end
    [r,c] = size(rawNitro);
    for i=1:r
        for j=1:c
            if(isnan(rawNitro(i,j)))
                rawNitro(i,j) = 0;
            end
        end
    end
    
    comNitro = [];
    cnt = 1;
    for i=1:2:c-1
        comNitro(:,cnt) = rawNitro(:,i) + rawNitro(:,i+1);
        cnt = cnt + 1;
    end
    
    [r,c] = size(comNitro);
    for h=1:c
        comNitro(:,h) = comNitro(:,h)./landAcre;
    end
    nitroPerAcre = comNitro;
end