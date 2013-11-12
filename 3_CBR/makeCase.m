function c = makeCase(AUs, class)
        if(length(AUs) < 45 || ((length(AUs) == 45) &&  (any(AUs > 1) == 1)))
        % Must be a vector of activated AUs
        au = zeros(1,45);
        for i = 1:length(AUs)
           au(AUs(i)) = 1;
        end
        c = struct('au', au, 'class', class, 'typicality', 1);
    else 
       assert(length(AUs) == 45); 
       c = struct('au', AUs, 'class', class, 'typicality', 1);           
    end
end