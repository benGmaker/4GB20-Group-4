%% Initialize robotarm
fs = 2048;
Ts = 1/fs;
Tsim =10;

nSamplesForVisualization = 200;

initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]

acc = 0.5; %amount of acceleration [m/s^2 or something]

d1 = 0.1;
safety_margin = 0.05; %rad
%minimum and maximum angles between which the arm whill move
%******IMPORTANT: these values have to be set according to the motor you
%want to control and at the end of the script the motor you write to has to
%be changed
min =  safety_margin + -pi/2; %R: -pi/2 X: 0.2  Z: -0.4
max = -safety_margin +  pi/2; %R:  pi/2 X: 1.47 Z:  0.3 
x_init = 0; %initial position of the robot arm

%declaring empty arrays 
t = 0:Ts:Tsim;
a = zeros(1,length(t));
v = zeros(1,length(t));
x = zeros(1,length(t));



t0 = 0; %starting time
sign = 1; %initial sign of the acceleration
x_start = x_init; %initial starting poistion
x_end = max; %end position

isnotdone = true;
while isnotdone
    dt01 = sqrt( (abs(x_end-x_start) - 2*d1)/(acc));%computing the time difference between t1 and t0
    t1 = dt01 + t0; %computing t1
    v_max = acc*dt01; %computing the velocity it reaches after the acceleration
    t2 = t1 + (2*d1)/v_max; %computing t2
    t3 = dt01 + t2; %computing t3
    if t3 >= Tsim %if t3 is later than the end time of the simulation we stop the arm from moving any further
        %Thus the loop is done running
        isnotdone = false;
        continue
    end 
    a(1,round(t0*fs)+1:round(t1*fs)) = sign*acc; %writing down the acceleration
    a(1,round(t2*fs):round(t3*fs)) = -sign*acc; %writing down the deceleration
    %because the array is already zeros we do not have to write down
    %anything between t1 and t2
    t0 = t3; %setting new zero time
    if x_end == max %swapping the direction of acceleration.
        x_start = max;
        x_end = min;
    else
        x_start = min;
        x_end = max;
    end
    sign = -1*sign; %swapping the sign
end

x(1) = x_init;
for i=2:length(a)
    v(i) = a(i)*Ts + v(i-1);
    x(i) = v(i)*Ts + x(i-1);
end
    
    

%To check if the constant acceleration is correct you can plot the acceleration, velocity and position by incommenting the following section:
%
figure()
plot(t,a)
title("Acceleration")
xlabel("time (s)")
ylabel("angular acceleration (rad/s^2)")

figure()
plot(t,v)
title('Velocity')
xlabel("time (s)")
ylabel("angular velocity (rad/s)")

figure()
plot(t,x)
title("position")
xlabel("time (s)")
ylabel("angle (rad)")

%}

%setting default values of the arm
phiX = zeros(1,length(t)) + initialAngleKrukX;
phiZ = zeros(1,length(t)) + initialAngleKrukZ;
phiR = zeros(1,length(t));
solenoid =  zeros(1,length(t));

%******IMPORTANT: here you can overwrite one of the refrence signals to perform
%to perform the acceleration experiment
%phiX = x; 
%phiZ = x;
phiR = x;

%{
%Code for performing step response
stepX = 0; %recommended +- 0.3 
stepZ = 0; %+-0.15
stepR = 0.79    ;%+-0.79

nSamplesForVisualization = 200;
initialAngleKrukX = 0.809091366467325; % [rad]
initialAngleKrukZ = 0.025113778764355; % [rad]  

t = 0:Ts:Tsim;
phiX = zeros(1,length(t)) + initialAngleKrukX + stepX;
phiZ = zeros(1,length(t)) + initialAngleKrukZ + stepZ;
phiR = zeros(1,length(t)) + stepR;
solenoid =  zeros(1,length(t));
%}

ref_X = timeseries(phiX',t);
ref_Z = timeseries(phiZ',t);
ref_R = timeseries(phiR',t);
ref_solenoid = timeseries(solenoid',t);

