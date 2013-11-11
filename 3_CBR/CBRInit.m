function [ cbr ] = CBRInit(x,y)

cbr = cell(1,6);

for i=1:size(x,1)
    cbr{y(i)} = vertcat(cbr{y(i)},x(i,:));
end

end