clear all;

close all

directoryin ='Figures/'; 
 ims = getAllFiles(directoryin);
hFig = figure;

 figure;
set(gca,'position',[0 0 1 1],'units','normalized')
for i = 1:length(ims)
      h(i) = subplot (10,10,i);
   %   axis('square'); 

    axis off;
     % set(gcf,'units','pix')
      %set(gcf,'position',[0 0 2000 2000])
       ax=get(h(i),'Position');
       ax(4)=ax(4)+0.05; %or wathever 
       %ax(2)=ax(2)-0.1; %or wathever 
      set(h(i),'Position',ax);
end;

pos = get(h, 'Position');  
 for i = 1:length(ims), % for each video    
      
         p= char(ims(i,1));
         [pathstr, name, ext] = fileparts(p);
         
         if(~strcmp( '.fig',ext)) 
             continue; 
        end;

            %# load fig
    hFigFile = hgload( p);

    %# move/copy axis from old fig to new fig
    hAx = get(hFigFile, 'Child');           %# hAx = gca;
    %set(hAx, 'Parent',h(i))
    %copyobj(hAx,h(i));
    copyobj(allchild(get(hFigFile,'CurrentAxes')),h(i));
    %# resize it to match subplot position
    %set(hAx, 'Position', pos{i});
    set(gca,'position',[0 0 1 1],'units','normalized')
   set(h(i),'position',[0 0 30 30]);
   set(gca,'xtick',[1 2 3 4 5], 'xticklabel',{})
    %# delete old fig
    delete(hFigFile)
        
 end;
 