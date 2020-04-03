%Form folder of radius results at 4 depths
RadiusValues = {[AllRadiusValues1d],[AllRadiusValues2d],[AllRadiusValues3d],[AllRadiusValues4d]};
d = size(RadiusValues,2);

depth_name = [1,2,3,4];

%Coefficient fit parameters across 4 depths
A_d = cell(1,4);

%Plotting stuff
color = ['r';'b';'g';'m'];

mult = 1000; %this problem

%loop over depths
for depth=1:d
    
    %Select radius spreadsheet of specific depth
    Data = RadiusValues{1,depth};
    n = size(Data,2);
    
    %Subplot counter
    sub = (depth-1)*5+1;
    A = [];
    
    %Loop over 5 images in indexed subfolder
    for l=2:6
        
        %Seperate columns/Reshape to X
        r = Data{1,1};
        f = Data{1,l};
        
        prev = [];
        for i = 1:length(r)
            radius = [ones(f(i),1)]*r(i);
            prev = [prev;radius];
        end
        
        X = prev;
        
        %Fit Using GMM with 1-5 components;
        no = 5;
        GMModels = cell(1,no);
        
        %Fitting parameters
        options = statset('MaxIter',750);
        
        %Loop over components. Fitting GMM. Determine AIC
        AIC = zeros(1,no);
        
        for co = 1:no
            
            GMMTest = fitgmdist(X,co,'Options',options);
            
            %Stop iterating if GMM does not converge
            if GMMTest.Converged == 0
                GMModels(co:end) = [];
                AIC(co:end) = [];
                
                no = co-1;
                break
            end
            
            GMModels{co} = GMMTest;
            AIC(co)= GMModels{co}.AIC;
        end
        
        %Pick ideal number of components/minimize difference of AIC
        d_AIC = zeros(1,no-1);
        for co = 1:no-1
            d_AIC(co) = AIC(co) - AIC(co+1);
        end
        
        [minAIC,numComponents] = min(d_AIC);
        ideal = numComponents;
        
        if numComponents == 1
            ideal = 2;
        end
        
        %Creat GMM Model/Save fit parameters (mu,sigma,a) across
        %k-components
        gmm = GMModels{ideal};
        
        A_k = [];
        A_comp = [];
        
        for co=1:ideal
          
            A_k(co,1) = gmm.mu(co);
            A_k(co,2) = gmm.Sigma(co);
            A_k(co,3) = gmm.ComponentProportion(co);
            A_k(co,4) = depth;
            A_k(co,5) = l-1;
            
            A_comp(co,1) = co;
          
        end
        
        A_k = sortrows(A_k,1);
        A_k = [A_k,A_comp];
        
        A = [A;A_k];
      
        %Form pdf from gmmfit
        [j,idk] = size(prev);
        x = linspace(0,2,j);
        y = mult*pdf(gmm,x');
        
        %PLOT 1: Histo and GMM subplots
        figure(1)
        xlim([0 2])
        subplot(4,5,sub)
        hold on
        %Histogram /
        histogram(X)
        %GMM fit /
        plot(x,y)
        
        for g = 1:size(A_k,1)
            xline(A_k(g,1));
        end
        
        xlabel('Fiber Radius (um)')
        ylabel('Number of Pixels')
        title(['',num2str(ideal),' Components'])
        legend('Data','Fit')
        hold off
        
        sgtitle('Fiber Radius Data and GMM Fit')
        
        %PLOT 2: AIC subplots
        figure(2)
        subplot(4,5,sub)
        plot(AIC)
        title([num2str(numComponents)])
        xlabel('Number of Components')
        ylabel('BIC')
        
        sgtitle('GMM component optimization')
        
        %subplot indexing
        sub = sub+1;
    end
    A_d{1,depth} = A;
end

clearvars -except A_d