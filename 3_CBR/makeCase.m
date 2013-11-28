function c = makeCase(AUs, class)
        if(length(AUs) < 45 || ((length(AUs) == 45) &&  (any(AUs > 1) == 1)))
        % Must be a vector of activated AUs
        au = zeros(1,45);
        for i = 1:length(AUs)
           au(AUs(i)) = 1;
        end
        c = makeStruct(au, class, 1);
    else 
       assert(length(AUs) == 45); 
       c = makeStruct(AUs, class, 1);           
    end
end

function c = makeStruct(au, class, typicality)
    c = struct('au', au, 'class', class, 'typicality', typicality);
end