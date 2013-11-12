function cbr = retain(cbr, newCase)

    % 
    for i = 1:size(cbr,1)
       if(all(cbr(i).au == newCase.au) && cbr(i).class == newCase.class)
          cbr(i).typicality = cbr(i).typicality + 1;
          return;
       end
    end
    
    cbr(size(cbr,1)+1) = newCase;
end