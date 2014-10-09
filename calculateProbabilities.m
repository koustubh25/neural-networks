function [outputProbs] = calculateProbabilities(parent, child, pdfs)

%Consider this for Matrix A
                                
                               %probability values
     %              240p          0   0   0   0
     %              360p          0   3   6   8
     %              720p          1   4   5   9
     %              1080p         1   4   5   9
     
    for i=1:size(child,2) %e.g for each quality
        for j=1:size(parent,2) %e.g general distribution   
            total = 0;
            for k=1:size(pdfs,1)
                total = total + pdfs(k,j);  %normalization to all the properties
            end
         
            outputProbs(i,j) = (pdfs(i,j)/total)*(parent(j));  
             
        end
      
        
    end

     
end

    

