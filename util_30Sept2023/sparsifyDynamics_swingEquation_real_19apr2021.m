function Xi = sparsifyDynamics_swingEquation_real_19apr2021(Theta,dXdt,lambda,n)
    % Copyright 2015, All Rights Reserved
    % Code by Steven L. Brunton
    % For Paper, "Discovering Governing Equations from Data: 
    %        Sparse Identification of Nonlinear Dynamical Systems"
    % by S. L. Brunton, J. L. Proctor, and J. N. Kutz


    Xi = Theta\dXdt; 

    
    for k=1:10
        
        smallinds = (abs(Xi)<lambda);
        Xi(smallinds)=0;


        
        for ind = 1:n 
            biginds = ~smallinds(:,ind);
            Xi(biginds,ind) = Theta(:,biginds)\dXdt(:,ind);
        end
        

    end
    
end

