clear all;
close all;
 load mapping.mat;
directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);

 iptsetpref('ImshowBorder','tight'); 

 %set(gcf,'visible','off')
dsd =9;
num2str(dsd,'%06d'); 




% here I should get the max value of all guys and put that as the
% normalizer. 

for o=1:3
    dos = figure; 
    jota =1;
for i = 1:length(ims),
    
  %keyboard; 
         p= char(ims(i,1));
          [pathstr, name, ext] = fileparts(p);
          load part.mat
         if(~strcmp( '.mat',ext))  % if its not the right file continue
             continue; 
        end;
        load (p); 
         [pathstr, name, ext] = fileparts(name);
                                           doubles = [name ext];

             
            for ( j=1:length(wwd(:,5)))
                                                        if (~strcmp(doubles,wwd{j,2}) || ~strcmp('FXS_Males',wwd{j,5})&& o ==3)
                                                            continue;
                                                        end;
                                                        if (~strcmp(doubles,wwd{j,2}) || ~strcmp('FXS_Females',wwd{j,5})&& o ==2)
                                                             continue;
                                                        end;
                                                         if ((~strcmp(doubles,wwd{j,2}) || ~strcmp('DD_Participants',wwd{j,5})) && o ==1);
                                                              continue;
                                                        end;
                
        
        
        
        
        
        
        
       %Extraction of the average   
               for j=1:199;
                    massa(1,j) =mean(ret(:,j));
                    s(1,j)  =  std(ret(:,j));
                    c(1,j) =  cov(ret(:,j));
                   if( s(1,j)  ==0)
                         s(1,j)  =1;
                    end;
               end;
          
%             figure;
%             hold on;
%            for j=1:2:198;
%                 mu = [massa(1,j) 576-massa(1,j+1)];
%                 Sigma = [s(1,j)*4  0; 0  s(1,j+1)*4];
%              
%                 x1 = 100:600; x2 = 10:450;
%                 [X1,X2] = meshgrid(x1,x2);
%                 F = mvnpdf([X1(:) X2(:)],mu,Sigma);
%                 F = reshape(F,length(x2),length(x1));
%                 contour(X1,X2,F,1);
%   end;

  mask = zeros (600,700);
  for q=1:length (ret(:,1)); % this guy itearates over the whole file 
 % if the eyetracking point is valid
   if   (ret(q,202)>0) && 576-ret(q,203)>0 && ret(q,202)<600 &&  576-ret(q,203)>0
       % first: find the closest facepoint 
       dist = 100000;
       offset = [0 , 0]
        for j=1:2:198
        offset = offset + [ret(q,j) 576-ret(q,j)] -  [massa(1,j) 576-massa(1,j+1)];
        end
        offset = offset / 99;
       if   (ceil(ret(q,202)+offset(1))>0) &&  ceil(576-ret(q,203)+offset(2))>0 && ceil(ret(q,202)+offset(1))<600  && ceil(576-ret(q,203)+offset(2)) < 450
      % mask(ret(q,202)+ceil(offset(1)),ceil(576-ret(q,203)+offset(2))) =1;
      mask(ret(q,202),ceil(576-ret(q,203))) = mask(ret(q,202),ceil(576-ret(q,203)))+1;
     %plot(ret(q,202)+ceil(offset(1)),576-ret(q,203)+ceil(offset(2)), 'o', 'MarkerSize',2,'MarkerFaceColor', [0 0 0]);
       end;
      end;
 end;
%hold off;

if ~exist('mask')
    continue;
end;



       [c,r] = ind2sub([6 6], jota);
       jota = jota +1;
        h=subplot('Position', [(c-1)/6, 1-(r)/6, 1/6, 1/6]);
        %set(h,'Color','Red');
         axis off;
        whitebg('w');

%set(gcf,'visible','off')
hold on;
% text(250,730,...
%     [jota,1],...
% 	'HorizontalAlignment','center',... 
% 	'BackgroundColor',[1 1 1], 'FontSize',15);
 % set up gaussian kernel, parameters here matter
mask(1,700)=700;
 r = normpdf(-3:1/25:3);
 kernel = repmat(r,length(r),1) .* repmat(r',1,length(r));
  % heatmap mask: convolve gaussian kernel, resize, and clip
  m = conv2(mask,kernel,'same');

 m = rot90(m);
  m = flipdim(m,1); 
  

 m = (m) ./ (max(max(m)));
  %m_zero = double(m>.2);
  %m_zero(m_zero==1) = .4;  
  h2 = imagesc(m*(255/3));

  %h2=imcrop(h2,[10,10,10,10]);
  %h2(1:600,600:700) = imagesc(0*(255/3));
 % imshow (h2);
  %use this as another image, set its alpha so only the good parts show up
  %alpha(h2,m_zero);
rectangle('Position',[0,500,600,200],...
          'FaceColor',[ 1 1 1], 'edgecolor', [0 0 0])
     rectangle('Position',[0,0,600,700],...
           'edgecolor', [0 0 0]) 
      
    for j=1:2:198;
                     plot(ceil(massa(1,j)),ceil( 576 - massa(1, j+1)), 'o', 'MarkerSize',1.5,'Color', [1 1 1],'MarkerFaceColor', [1 1 1]);
   end;
   %gg=gcf;
   %gg = imcrop(gg,[0 0 600 600]);
   %imshow(gg)
   
   %drawnow;
   hold off; 
  %% Setting the title
            set(gcf,'NextPlot','add');
            axes;
            switch o
                    case 1
                    h = title('DD  Participants');
                    case 2
                    h = title('FXS Females');
                    otherwise
                    h = title('FXS  Males');
           end
            set(gca,'Visible','off');
            set(h,'Visible','on');
  %saveas(gg,['/Users/Gui/Eyetofacemarks/Results/ResultsMapping/'  name '-maps-'  num2str(q) '.jpg'] ,'jpg');
  clearvars -except ims directoryin wwd jota o
  break;

 end;
 end;
 gg=gcf;
 saveas(gg,['/Users/Gui/Eyetofacemarks/Results/heatmap' num2str(o) '-fine30-normalized.eps'] ,'epsc');
end;
 
 
 
