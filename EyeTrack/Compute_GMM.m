clear all;
directoryin ='Partial/'; 
 ims = getAllFiles(directoryin);
 load part.mat
%Compute the parts average
 addpath sc;
 addpath gkde2;

 
 for i = 1:length(ims), % for each video    
      
         p= char(ims(i,1));
         [pathstr, name, ext] = fileparts(p);
         
         if(~strcmp( '.mat',ext)) 
             continue; 
        end;
        
                             %check if the matrix does not already exists 
         if(exist(['PartialDistances/' name '.mat']))
         continue;
         end;
         
        load (p); 
         %REMOVE EVERYTHING I DONT WANT 
       

        for  i=1:length (ret(:,1)) 
              clf
               valX = ret (i,202);
               valY= 576-ret (i,203);
               close = 100000;
           
            for j=1:2:198;
                       diff = norm( [ret(i,j) (576-ret(i,j+1))] - [valX valY] );
                       plot(ret(i,j),(576-ret(i,j+1)),'o', 'MarkerEdgeColor','r','MarkerSize', 4);
                        if (close>diff) 
                        close = diff;
                        X = ret(i,j);
                        Y = 576-ret(i,j+1);
                        pos = ((j-1)/2)+1; 
                        fprintf('   %d ', j ) ;
                        end;
            end;
             if  (close < 10 &&  close ~=0)
                 plot(valX,valY,'X','MarkerEdgeColor','k','MarkerSize', 13);
                 plot(X,Y,'o', 'MarkerEdgeColor','b','MarkerSize', 7);
                 part{pos,3}=part{pos,3}+1;
                 fprintf('\n', j ) ;
              end;
        end; 
        
 gmms (1:100) =100;
clearvars sputnik;
elements=1;
previous = part(1,2);
u =1;
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

set(gca,'XTick',[1:length(sputnik_labels(:))]);
set(gca,'XTickLabel',sputnik_labels(:));
% a=get(gca,'XTickLabel');
% %erase current tick labels from figure
% %set(gca,'XTickLabel',[]);
% %get tick label positions
% b=get(gca,'XTick');
% c=get(gca,'YTick');
% rot=90;
% %make new tick labels
% text(b,repmat(c(1)+3*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','right','rotation',rot,'FontSize', 13, 'FontWeight', 'normal');
%bar(sputnik(:,1));
%saveas(hf1,['Figures/' name '.fig'],'fig');
save (['PartialDistances/' name '.mat']); 
hold off;
clearvars -except  ims part
% simplify the histogram to a narrow set of face keypoints 
end
