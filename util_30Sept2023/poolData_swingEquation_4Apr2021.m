function yout = poolData_swingEquation_4Apr2021(yin, ...
        nVars,polyorder,usesine, possibleFreq, flag_bias, flag_xpower3MinsX,...
        flag_randomNoiseVect, flag_randomBias)
% Copyright 2015, All Rights Reserved
% Code by Steven L. Brunton
% For Paper, "Discovering Governing Equations from Data: 
%        Sparse Identification of Nonlinear Dynamical Systems"
% by S. L. Brunton, J. L. Proctor, and J. N. Kutz

n = size(yin,1);


ind = 1;
% poly order 0
yout(:,ind) = ones(n,1);
for reg_randomBias = 1:1
    if flag_randomBias && flag_bias
        yout(:,ind) = rand(size(yout));
    end
end

ind = ind+1;

for reg_getRidOfBias = 1:1
    if ~flag_bias
        yout = [];
        ind = 1;
    end
end

% poly order 1
if(polyorder>=1)
    for i=1:nVars
        yout(:,ind) = yin(:,i);
        ind = ind+1;
    end
end

if(polyorder>=2)
    % poly order 2
    for i=1:nVars
        for j=i:nVars
            yout(:,ind) = yin(:,i).*yin(:,j);
            ind = ind+1;
        end
    end
end

if(polyorder>=3)
    % poly order 3
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                yout(:,ind) = yin(:,i).*yin(:,j).*yin(:,k);
                ind = ind+1;
            end
        end
    end
end

if(polyorder>=4)
    % poly order 4
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                for l=k:nVars
                    yout(:,ind) = yin(:,i).*yin(:,j).*yin(:,k).*yin(:,l);
                    ind = ind+1;
                end
            end
        end
    end
end

if(polyorder>=5)
    % poly order 5
    for i=1:nVars
        for j=i:nVars
            for k=j:nVars
                for l=k:nVars
                    for m=l:nVars
                        yout(:,ind) = yin(:,i).*yin(:,j).*yin(:,k).*yin(:,l).*yin(:,m);
                        ind = ind+1;
                    end
                end
            end
        end
    end
end

%%
freq = 2.*pi.*possibleFreq;
if(usesine)
    for i = 1:size(possibleFreq,2)
        yout = [yout sin(freq(i)*yin(:,end)) cos(freq(i)*yin(:,end))];
        ind = ind+2;
    end
end

%%
if flag_randomNoiseVect
    tmp_rand = rand(1,size(yout,1));
    startingEnd = floor(size(yout,1)/2);
    endEnd = startingEnd + size(yout,1) -1 ;
    for i = 1:size(possibleFreq,2)


        tmp_sinWave =  sin(freq(i)*yin(:,end));
        tmp_cosWave = cos(freq(i)*yin(:,end));

        tmp_convSine = conv(tmp_rand,tmp_sinWave);
        convSine = tmp_convSine(startingEnd:endEnd,:);

        tmp_convCos = conv(tmp_rand,tmp_cosWave);
        convCos = tmp_convCos(startingEnd:endEnd,:);

        yout = [yout convSine ...
            convCos];
        ind = ind+2;

    end

end

for reg_flag_xpower3MinsX = 1:1
    if flag_xpower3MinsX
        for i=1:nVars
            % yout(:,ind) = -yin(:,i);
            yout(:,ind) = yin(:,i).^3;
            
            ind = ind+1;
        end     
    end
end


for reg_checkConvPlot = 1:-1
    figure();
    subplot(4,1,1);
    plot(yin(:,end),tmp_sinWave);
    title("Sine Wave");


    subplot(4,1,2);
    plot(yin(:,end),tmp_rand);
    title("Random Valuable");

    subplot(4,1,3);
    plot(yin(:,end),convSine);
    title("Rand sinusoid (sin)");
    xlabel("time sec");

    subplot(4,1,4);
    plot(yin(:,end),convCos);
    title("Rand sinusoid (cos)");
    xlabel("time sec");


end

end