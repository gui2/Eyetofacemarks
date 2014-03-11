clear all;
close all;
directoryin ='Partial/'; 
addpath sc;
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
        %set(h,'Color','Red');
         axis off;
        whitebg('w');
       
        hold on;
        %%%%%%%%%%%%%
        % CREATE THE AVERAGE  KEYPOINTS FACES
        %plot( 0,0,'o', 'MarkerEdgeColor','k','MarkerSize', 0.1);
        %plot( 720,576,'o', 'MarkerEdgeColor','k','MarkerSize', 0.1);

               for j=1:199;
                    massa(1,j) =mean(ret(:,j));
                    s(1,j)  =  std(ret(:,j));
                    c(1,j) =  cov(ret(:,j));
                    
                    if( s(1,j)  ==0)
                         s(1,j)  =1;
                    end;
                   % d = Norm2pdf(X,Y,massa(1,j),576-massa(1,j+1),s(1,j),s(1,j+1));
                     end;
          
           % figure;
          %  hold on;
           for j=1:2:198;
                 mu = [massa(1,j) 576-massa(1,j+1)];
                Sigma = [s(1,j)*4  0; 0  s(1,j+1)*4];
                %V1=eye(2);
                %Sigma = [ s(1,j) 10 ;s(1,j+1)  10];
              % x1 = 1:720; x2 = 1:576;
                
                x1 = 100:600; x2 = 10:450;
                [X1,X2] = meshgrid(x1,x2);
                F = mvnpdf([X1(:) X2(:)],mu,Sigma);
               %  pcolor(X1,X2,reshape(F ,length(X1),length(X1)));
                F = reshape(F,length(x2),length(x1));
               %  imagesc(F);
               % %mvncdf([0 0],[800 800] , mu, Sigma);
                contour(X1,X2,F,6);
               % xlabel('x'); ylabel('y');
               % line([0 0 1 1 0],[1 0 0 1 1],'linestyle','--','color','k');
                end;
  
       hold off;
       clearvars -except  ims part
 end;

      