clear all;
close all
 
directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);
 fHand = figure;
 iptsetpref('ImshowBorder','tight');
% 
% for i = 1:length(ims)
%        h(i) = subplot (10,10,i);
%        %  axis('square'); 
%        axis off;
%        set(gcf,'units','pix')
%       %set(gcf,'position',[0 0 2000 2000])
%        ax=get(h(i),'Position');
%        ax(4)=ax(4)+0.05; %or wathever 
%        %ax(2)=ax(2)-0.1; %or wathever 
%       set(h(i),'Position',ax);
% end;

%pos = get(h, 'Position');  

 for r= 1:length(ims), % for each video    
       
         p= char(ims(r,1));
         [pathstr, name, ext] = fileparts(p);
         
         if(~strcmp( '.mat',ext)) 
             continue; 
        end;

   mp = load (p);
   h = subplot (10,10,r);
  
   ax=get(h,'Position');
   ax(1)=ax(1)-0.01; %or wathever 
   ax(2)=ax(2)+0.01; %or wathever 
 %  ax(4)=ax(4)+0.01; %or wathever 
   ax(3)=ax(3)+0.02; %or wathever 
   set(h,'Position',ax);
   axis off;

  % hFigFile =bar(mp.sputnik(:,1));
  f = [1,2,3,4,5,6,7,8,9,10,11];
   colors = hsv(f (:));
   hold on; 
    for i = 1:numel(mp.sputnik(:,1))
    bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
    end
  %  T = title(mp.name);
   % P = get(T,'position'); 
  % set(T,'rotation',-90,'position',[P(2) P(1) P(3)])
   hold off  
   % set(gca, 'XTick', 1:mp.sputnik(:,1), 'XTickLabel', {'R0', 'R1', 'R2'})
   % errorbar(y,s,'r'); 
    
    % clearvars -except ims r 
    %# move/copy axis from old fig to new fig
    %  hAx = get(hFigFile, 'Child');           %# hAx = gca;
    %set(hAx, 'Parent',h(i))
    %copyobj(hAx,h(i));
    %copyobj(allchild(get(hFigFile,'CurrentAxes')),h(i));
    %# resize it to match subplot position
    %set(hAx, 'Position', pos{i});
   
    %set(gca,'position',[0 0 1 1],'units','normalized')
  % set(h(i),'position',[0 0 30 30]);
  %  set(gca,'xtick',[1 2 3 4 5], 'xticklabel',{})
    %# delete old fig
    %delete(hFigFile)  
 end;
 figure 
 hold on;
   for i = 1:numel(mp.sputnik(:,1))
    bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
   end
   set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
   set(gca,'XTickLabel',mp.sputnik_labels(:));
   hold off;
 
 