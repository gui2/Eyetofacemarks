clear all;
directoryin ='Partial/'; 
 ims = getAllFiles(directoryin);
 load part.mat

 figure;

 for i = 1:length(ims), % for each video    
      
         p= char(ims(i,1));
         [pathstr, name, ext] = fileparts(p);
         
         if(~strcmp( '.mat',ext)) 
             continue; 
        end;
        load (p); 
       %subplot (9,9,i);
        [c,r] = ind2sub([9 9], i);
        h=subplot('Position', [(c-1)/9, 1-(r)/9, 1/9, 1/9])
        axis off;
         hold on;
        %%%%%%%%%%%%%
        % CREATE THE AVERAGE  KEYPOINTS FACES
        plot( 0,0,'o', 'MarkerEdgeColor','k','MarkerSize', 0.1);
        plot( 720,576,'o', 'MarkerEdgeColor','k','MarkerSize', 0.1);
       % ax=get(h,'Position');
        % ax(1)=ax(1)+0.1; %or wathever 
        % ax(2)=ax(2)+0.1; %or wathever 
        %ax(4)=ax(4)+0.1; %or wathever 
        %ax(3)=ax(3)+0.01; %or wathever 
     %   set(h,'Position',ax);
      
               for j=1:199;
                    massa(1,j) =mean(ret(:,j));
                    s(1,j) = std(ret(:,j));
              end;
       
          for j=1:2:198;
                    plot( massa(1,j),576-massa(1,j+1),'o', 'MarkerEdgeColor','k','MarkerSize', 3);
            end;
       hold off;
 clearvars -except  ims part
 end;

      