function c = makeCaseFromActivatedAUs(activate_aus, class)
    au = zeros(1,45);
    for i = 1:length(activate_aus)
       au(activate_aus(i)) = 1;
    end
    c = struct('au', au, 'class', class, 'typicality', 1);
end