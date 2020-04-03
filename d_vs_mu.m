figure(3)

color = ['r';'g';'b';'m'];
A_avg = [1,2,3,4];
R = [];

for d =1:4
    
    A_test = A_d{1,d};
    [m,n] = size(A_test);
    
    for i=1:m
        comp = A_test(i,6);
        A_avg(end+1,comp) = A_test(i,1);
        
        hold on
        figure(3)
        scatter(A_test(i,1),A_test(i,4),50,'filled',color(comp))
        
        %here
        title 'Depth vs Mu'
        xlabel('Mu (um)')
        ylabel('Depth')
        
        ylim([0.5 4.5])
    end
    for i = 1:4
        test = A_avg(2:end,i);
        mnz = mean(nonzeros(test));
       stdz = std(nonzeros(test));
        A_average(1,i) = mnz;
        A_average(2,i) = stdz;
        A_average(3,i) = d;
        A_average(4,i) = i;
    end
A_average = A_average.';

R_temp = rmmissing(A_average);
R = [R;R_temp];
end

R;
x = R(:,1);
y = R(:,3);
err = R(:,2);

figure(3)
errorbar(x,y,err,'horizontal','o')
   
clearvars -except R A_d