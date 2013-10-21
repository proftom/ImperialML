function LIFDemo

dt = 0.1; % large step size

% Time points
Tmin = 0;
Tmax = 25;
T1 = Tmin:dt:Tmax;

% Parameters
tau = 5;
v_r = -65;
R = 1;
I = 20;

threshold = -50;

% Euler method with large step size
y = zeros(1,length(T1));
y(1) = v_r; % initial value

for t = 1:length(T1)-1
    dydt = (v_r + R*I - y(t))/tau;
    y(t+1) = y(t) + dt*dydt;
    
    if(y(t+1) > threshold)
        y(t) = 30;
        y(t+1) = v_r;
    end
    
    % shut off the dendritic current after 10 ms
    %if(T1(t) > 10)
    %    I = 0;
    %end
end

% Plot the results
hold on
plot(T1,y,'Color','Blue')
xlabel('t')
ylabel('y')