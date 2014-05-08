clear all;
close all;

directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);

 iptsetpref('ImshowBorder','tight'); 
 dos = figure; 
 set(gcf,'visible','off')

 
% for each video  
 for i = 1:length(ims), 
  %keyboard; 
         p= char(ims(i,1));
          [pathstr, name, ext] = fileparts(p);
         load part.mat
         if(~strcmp( '.mat',ext))  % if its not the right file continue
             continue; 
        end;
        load (p); 
        

     
  for q=1:length (ret(:,1)); % this guy itearates over the whole file 
     
 if exist (['/Volumes/FAT/Fixation/'  name '-'  num2str(q) '.jpg'] )
    continue;
end; 
      hold on;
           plot(576,720, 'o', 'MarkerSize',0.1,'MarkerFaceColor', [1 0 0]);
           plot(-50,-50, 'o', 'MarkerSize',0.1,'MarkerFaceColor', [1 0 0]);
  
 text(200,700,...
    [name,1],...
	'HorizontalAlignment','center',... 
	'BackgroundColor',[1 1 1], 'FontSize',15);

  for m=1:2: 198
      %massa(1,j) 576-massa(1,j+1)
    plot(ret(q,m),576-ret(q,m+1),  'o', 'MarkerSize',5,'MarkerFaceColor', 'k');
  end;
       text(ret(q,1),576-ret(q,1+1) +200,...
	['Interviewer Facemarks',1],...
	'HorizontalAlignment','center',... 
	 'FontSize',15);
     
  if   (ret(q,202)>0) && 576-ret(q,203)>0 && ret(q,202)<600 &&  576-ret(q,203)>0
     plot(ret(q,202),576-ret(q,203), 'o', 'MarkerSize',10,'MarkerFaceColor', [1 0 0]);
    text(ret(q,202)+40,576-ret(q,203)-60,...
	['Children Eye tracking',1],...
	'HorizontalAlignment','center',... 
	 'FontSize',15);
     else
     text(0,576-ret(q,203),...
 	['Mapping outside of video scope',1],...
	'HorizontalAlignment','center',... 
	 'FontSize',15);
    end;
  
   %pause(0.001)
   %%% Save to file 
  %  gg=gcf;
  try 
   saveas(dos,['/Volumes/FAT/Fixation/'  name '-'  num2str(q) '.jpg'] ,'jpg');
  catch
  disp (name);    
  end
   
   clf
   hold off;    
  end;
 clearvars -except ims directoryin dos
 end;
