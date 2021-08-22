% 11-level Machine Learning Based Modulation

% Firing Angles

s=[]; %Segment size
s(1)=0.5;
s(2)=0.6;
s(3)=0.7;
s(4)=0.8;
s(5)=0.9;
D=[]; %Duty Cycle
d=[]; %delay time


for i=1:5
    d(i)=0.01*s(i)/pi/2*1000;
    D(i)=(pi-s(i))/pi*100;
end

% Gradient Descent

count=0;
while(count<100)
    count=count+1;

    sim('Modified11levelHbridgeALGO',0.02);
    % Obtaining THD from simulation

    FFTDATA = power_fftscope(ans.Vout);
    FFTDATA = power_fftscope(FFTDATA);

    thd = FFTDATA.THD
    diff = (thd-29)*0.05;
    if(diff<0.001)
        break
    end
    i=1;
    %for i=1:5
    s(i)=s(i)-diff;
    d(i)=0.01*s(i)/pi/2*1000;
    D(i)=(pi-s(i))/pi*100;
   % end
    
    % A2=A2+diff;
    % A3=A3+diff;
    % A4=A4+diff;
    % A5=A5+diff;
end



