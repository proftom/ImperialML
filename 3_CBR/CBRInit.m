function [ cbr ] = CBRInit(x,y)
    noExamples = size(x,1);
    count = 0;
    % Pre-allocate arrays for better performance
    cbr = repmat(makeCase([],[]), noExamples, 1 );
    
    for i= 1:size(x, 1)
        au = x(i, :);
        class = y(i);
        found = 0;
        
        if count > 0
            for j = 1:count
               if all(cbr(j).au == au) && cbr(j).class == class
                  cbr(j) = incrementTypicality(cbr(j));
                  found = 1;
                  break;
               end
            end
        end
        
        if found == 0
            count = count + 1;
            cbr(count) = makeCase(au, class);
        end
    end
    % Trim the array
    cbr = cbr(1:count);
end

function c = makeCase(example, class)
    c = struct('au', example, 'class', class, 'typicality', 1);
end

function c = incrementTypicality(c)
    c.typicality = c.typicality + 1;
end