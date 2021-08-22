% 11-level Machine Learning Based Modulation

% Firing Angles

s=[]; %Segment size
s(1)=2;
s(2)=0.1;
s(3)=0.1;
s(4)=0.1;
s(5)=0.1;
D=[]; %Duty Cycle
d=[]; %delay time
val=29;

for i=1:5
    d(i)=0.01*s(i)/sum(s)/2*1000;
    D(i)=(sum(s)-s(i))/sum(s)*100;
end

% Gradient Descent
 sim('Modified11levelHbridgeALGO',0.02);
% Obtaining THD from simulation
FFTDATA = power_fftscope(ans.Vout);
FFTDATA = power_fftscope(FFTDATA);
prev = FFTDATA.THD;
count=0;
for i=1:5
    prevS(i)=s(i);
end

for i=1:5
    while(1)
        %count=count+1;

        sim('Modified11levelHbridgeALGO',0.02);
        % Obtaining THD from simulation

        FFTDATA = power_fftscope(ans.Vout);
        FFTDATA = power_fftscope(FFTDATA);

        thd = FFTDATA.THD
        diff = (thd-val)*0.005;
        %if(diff<0.001)
        %   break
        %end
        %i=1;
        %for i=1:5
        
        s(i)=s(i)-diff;
        for j=i+1:4
            s(j)=s(j)+diff/(5-i);
        end
        
        if thd>prev
            s(i)=prevS(i);
            val=val-5;
            break
        end
        prev=thd;
        prevS(i)=s(i);
        d(i)=0.01*s(i)/sum(s)/2*1000;
        D(i)=(sum(s)-s(i))/sum(s)*100;
       % end

        % A2=A2+d2*diff;
        % A3=A3+d3*diff;
        % A4=A4+d4*diff;
        % A5=A5+d5*diff;

    end
end


