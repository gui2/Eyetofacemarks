clear all;
close all
 load mapping.mat;
directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);

 iptsetpref('ImshowBorder','tight'); 

 
  %% PLOT XF_MALE
Accum_sputnik(1:11,1:3) =0;
Groups_sputnik(1:11,1:3) =0;
s = struct('a',zeros(11,0),'b',zeros(11,0),'c',zeros(11,0));
minmax= struct('a',zeros(11,3),'b',zeros(11,3),'c',zeros(11,3));
count = struct('a',zeros(11,3),'b',zeros(11,3),'c',zeros(11,3));
  for o =1:3
                     figure;
                      for r= 1:length(ims), % for each video    
                                           p= char(ims(r,1));
                                           [pathstr, name, ext] = fileparts(p);
                                           if(~strcmp( '.mat',ext)) 
                                                 continue; 
                                           end;
                                           [pathstr, name, ext] = fileparts(name);
                                           double = [name ext];
                                           % Split By Groups 
                                           for ( j=1:length(wwd(:,5)))
                                                        if (~strcmp(double,wwd{j,2}) || ~strcmp('FXS_Males',wwd{j,5})&& o ==3)
                                                            continue;
                                                        end;
                                                        if (~strcmp(double,wwd{j,2}) || ~strcmp('FXS_Females',wwd{j,5})&& o ==2)
                                                             continue;
                                                        end;
                                                         if ((~strcmp(double,wwd{j,2}) || ~strcmp('DD_Participants',wwd{j,5})) && o ==1)
                                                             continue;
                                                        end;

                                                       mp = load (p);
                                                       h = subplot (9,9,r);
                                                       ax=get(h,'Position');
                                                       ax(1)=ax(1)-0.01; %or wathever 
                                                       ax(2)=ax(2)+0.01; %or wathever 
                                                       ax(3)=ax(3)+0.02; %or wathever 
                                                       set(h,'Position',ax);
                                                       axis off;
                                                       colors =hsv(12);
                                                       hold on; 
                                                                        for i = 1:numel(mp.sputnik(:,1))
                                                                        bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
                                                                        end
                                                                        Accum_sputnik(:,o) =Accum_sputnik(:,o) + mp.sputnik(:,1);
                                                                        hold off; 
                                                                        switch o
                                                                         case 1
                                                                          s.a = [s.a,mp.sputnik(:,1)];
                                                                          count.a =count.a+1 ;
                                                                          case 2
                                                                         s.b =  [s.b,mp.sputnik(:,1)];
                                                                         count.b=count.b+1 ;
                                                                         otherwise
                                                                          s.c = [s.c,mp.sputnik(:,1)];   
                                                                         count.c=count.c+1 ;
                                                                         end
                                      end; 
                        end;
    
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
end;


% Graphic the accumulation
for o =1:3
figure;
hold on; 
        for i = 1:numel(mp.sputnik(:,1))
        bar(i,Accum_sputnik(i,o), 'facecolor', colors(i,:));
        end
set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
set(gca,'XTickLabel',mp.sputnik_labels(:));
hold off; 

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
end;



  % compute the minimum value. 
  for q =1:11
   minmax.a(q,1)=min(s.a(q,:));
   minmax.b(q,1)=min(s.b(q,:));
   minmax.c(q,1)=min(s.c(q,:));
   
   minmax.a(q,2)=max(s.a(q,:));
   minmax.b(q,2)=max(s.b(q,:));
   minmax.c(q,2)=max(s.c(q,:));
   
   minmax.a(q,3)=mean(s.a(q,:));
   minmax.b(q,3)=mean(s.b(q,:));
   minmax.c(q,3)=mean(s.c(q,:));   
  end;
  
  for o =1:3
figure;
hold on; 
 switch o
        case 1
              for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.a(i,3), 'facecolor', colors(i,:));
               errorbar(i,minmax.a(i,3),minmax.a(i,1),minmax.a(i,2));
               end
        case 2
            for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.b(i,3), 'facecolor', colors(i,:));
               errorbar(i,minmax.b(i,3),minmax.b(i,1),minmax.b(i,2));
               end
        otherwise
             for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.c(i,3), 'facecolor', colors(i,:));
               errorbar(i,minmax.c(i,3),minmax.c(i,1),minmax.c(i,2));
               end
    end
 
set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
set(gca,'XTickLabel',mp.sputnik_labels(:));
hold off; 

set(gcf,'NextPlot','add');
axes;
    switch o
        case 1
        h = title('DD  Participants -- Mean and confidence values');
        case 2
        h = title('FXS Females -- Mean and confidence values');
        otherwise
        h = title('FXS  Males -- Mean and confidence values ');
    end
set(gca,'Visible','off');
set(h,'Visible','on'); 
end;
  
  
% Graphic all graphs independently 
  figure; 
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
   ax(3)=ax(3)+0.02; %or wathever 
   set(h,'Position',ax);
   axis off;
   colors =hsv(12);
   hold on; 
    for i = 1:numel(mp.sputnik(:,1))
    bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
    end
end;



% %    % graphic the labels 
% %    figure 
% %    hold on;
% %    for i = 1:numel(mp.sputnik(:,1))
% %     bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
% %    end
% %    set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
% %    set(gca,'XTickLabel',mp.sputnik_labels(:));
% %    hold off;
% %  
 