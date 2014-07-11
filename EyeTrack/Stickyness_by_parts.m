clear all;
directoryin ='Partial/'; 
 ims = getAllFiles(directoryin);
 
%Compute the parts average

 for i = 1:length(ims), % for each video    
      
         p= char(ims(i,1));
         [pathstr, name, ext] = fileparts(p);
          load part.mat
         if(~strcmp( '.mat',ext)) 
             continue; 
        end;
        
         %check if the matrix does not already exists 
         if(exist(['PartialDistances/' name '.faceparts.mat']))
         continue;
        end;
       
        load (p); 
         %REMOVE EVERYTHING I DONT WANT 
       

        for  i=1:length (ret(:,1)) 
              clf
              % valX and valY are the values of the eye tracker for the
              % frame i
               valX = ret (i,202);
               valY= 576-ret (i,203);
               close = 100000;
           % iteration over the  landmars each iteration compares with the
           % landmar at coordinates (j,j+1), computing the L2 norm
           % storing the value in the close variable. 
            for j=1:2:198;
                       diff = norm( [ret(i,j) (576-ret(i,j+1))] - [valX valY] );
                        if (close>diff) 
                        close = diff;
                        X = ret(i,j);
                        Y = 576-ret(i,j+1);
                        pos = ((j-1)/2)+1;  % this is the closest key part. 
                        end;
            end;
          
            if  (close < 20 &&  close ~=0)
                 part{pos,3}=part{pos,3}+1;
                 ret(i,211)=pos;
             end;
              
        end; 

gmms (1:100) =100;
clearvars sputnik;
elements=1;
previous = part(1,2);
u =1;

% unificacion de las partes
for  (w = 1: length(part(:,2)))
       if ( ~isequal(part (w,2) , previous))
        elements = elements+1;
        previous = part (w,2) ;
        u= u+1;
        end;
   sputnik_labels (u) = part (w,2);
end;


sputnik (1:elements,1)=0;
previous = part(1,2);
prev_index =1;

for  (w = 1: length(part(:,2)))
     if ( isequal(part (w,2) , previous))
                 sputnik(prev_index,1)=sputnik(prev_index,1)+ cell2num(part (w,3)); 
    else
        previous = part (w,2) ;
        prev_index =prev_index+1;
        sputnik(prev_index,1)=sputnik(prev_index,1)+cell2num(part (w,3)); 
     end;
end;

save (['PartialDistances/' name '.faceparts.mat']); 
clearvars -except  ims 
% simplify the histogram to a narrow set of face keypoints 
end