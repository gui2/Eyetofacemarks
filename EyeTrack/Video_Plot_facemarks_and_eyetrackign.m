clear all;
close all;

directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);
 load mapping.mat;
 iptsetpref('ImshowBorder','tight'); 
 dos = figure; 
 set(gcf,'visible','off')
tue=0;
 
% for each video  
    rr = figure
 for i = 1:length(ims), 
            %keyboard; 
         p= char(ims(i,1));
         [pathstr, name, ext] = fileparts(p);     
         p = [pathstr '/' wwd{i,2} ext]  ; % fixed

         
  for q=1:length(wwd(:,2))
         if (~strcmp(wwd{q,2},name) )% fixed
                 continue;% fixed
         else
             tue = q;
              disp('found');
         end
  end;
         
         load part.mat
         if(~strcmp( '.mat',ext))  % if its not the right file continue
             continue; 
        end;
   try
       load (p); 
   catch
           disp(p)
   end;
      
   imss = getAllFiles(['/Users/Gui/Images/FXS_TRACK/INPUT/OUT/' name '.mp4/0/']);
   for u=1:1000:  length(imss);
         pa= char(imss(u,1));
         [pathstr, names, ext] = fileparts(pa);    

   
         if(~strcmp( '.jpg',ext))  % if its not the right file continue
             continue; 
        end;
        box_color = {'red','green','yellow'};
        position = [23 373; 35 185; 77 107]; % [x y]
       
        I=imread(pa);
        hold on
       imshow(I);
        text(50,100,...
       [wwd{tue,4},1],...
	  'HorizontalAlignment','center',... 
	  'BackgroundColor',[1 1 1], 'FontSize',15);
       hold off
       
               text(50,200,...
       [name,1],...
	  'HorizontalAlignment','center',... 
	  'BackgroundColor',[1 1 1], 'FontSize',15);
       hold off
       
       
       saveas(rr,['/Volumes/FAT/Group/' name '-' num2str(u) '.jpg']);
    %copyfile(pa,'/Volumes/FAT/Group/');

%   if exist (['/Volumes/FAT/Group/' names '-'  num2str(u) '.jpg'] )
%      continue;
%   end;
%       
%     
    
    try 
       saveas(ddd,['/Volumes/FAT/Group/'  num2str(u) '.jpg']);
      catch
      disp ('dd');    
  end;
   clf;
   clearvars -except ims directoryin dos wwd imss name q tue rr
   end;
   
 end;

% 
%       hold on;
%            plot(576,720, 'o', 'MarkerSize',0.1,'MarkerFaceColor', [1 0 0]);
%            plot(-50,-50, 'o', 'MarkerSize',0.1,'MarkerFaceColor', [1 0 0]);
%   
%  text(200,700,...
%     [name,1],...
% 	'HorizontalAlignment','center',... 
% 	'BackgroundColor',[1 1 1], 'FontSize',15);
% 
%   for m=1:2: 198
%       %massa(1,j) 576-massa(1,j+1)
%     plot(ret(q,m),576-ret(q,m+1),  'o', 'MarkerSize',5,'MarkerFaceColor', 'k');
%   end;
%        text(ret(q,1),576-ret(q,1+1) +200,...
% 	['Interviewer Facemarks',1],...
% 	'HorizontalAlignment','center',... 
% 	 'FontSize',15);
%      
%   if   (ret(q,202)>0) && 576-ret(q,203)>0 && ret(q,202)<600 &&  576-ret(q,203)>0
%      plot(ret(q,202),576-ret(q,203), 'o', 'MarkerSize',10,'MarkerFaceColor', [1 0 0]);
%     text(ret(q,202)+40,576-ret(q,203)-60,...
% 	['Children Eye tracking',1],...
% 	'HorizontalAlignment','center',... 
% 	 'FontSize',15);
%      else
%      text(0,576-ret(q,203),...
%  	['Mapping outside of video scope',1],...
% 	'HorizontalAlignment','center',... 
% 	 'FontSize',15);
%     end;
%   
%    %pause(0.001)
%    %%% Save to file 
%   %  gg=gcf;
%   try 
%    saveas(dos,['/Volumes/FAT/Group/' name '-' num2str(q) '.jpg']);
%   catch
%   disp (name);    
%   end
%    
%    clf
%    hold off;    
%   end;
%  clearvars -except ims directoryin dos wwd
%  end;
