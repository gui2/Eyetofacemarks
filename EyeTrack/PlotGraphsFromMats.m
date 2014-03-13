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
count = struct('a',zeros(1),'b',zeros(1),'c',zeros(1));
frames = struct('a',zeros(1),'b',zeros(1),'c',zeros(1));

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
                                                                        hold off; 
                                                                        switch o
                                                                         case 1
                                                                          s.a = [s.a,mp.sputnik(:,1)];
                                                                          count.a =count.a+1 ;
                                                                          frames.a = frames.a + length (mp.ret(:,1));
                                                                          case 2
                                                                          s.b =  [s.b,mp.sputnik(:,1)];
                                                                         count.b=count.b+1 ;
                                                                         frames.b = frames.b + length (mp.ret(:,1));
                                                                         otherwise
                                                                          s.c = [s.c,mp.sputnik(:,1)];   
                                                                         count.c=count.c+1 ;
                                                                         frames.c= frames.c + length (mp.ret(:,1));
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
 switch o
        case 1
              for i = 1:numel(mp.sputnik(:,1))
               bar(i,frames.a(1), 'facecolor', [0.8 0.8 0.8]);
               bar(i,sum(s.a(i,:)), 'facecolor', colors(i,:));
                end
        case 2
            for i = 1:numel(mp.sputnik(:,1))
               bar(i,frames.b(1), 'facecolor',  [0.8 0.8 0.8]);
               bar(i,sum(s.b(i,:)), 'facecolor', colors(i,:));
               end
        otherwise
             for i = 1:numel(mp.sputnik(:,1))
               bar(i,frames.c(1), 'facecolor',  [0.8 0.8 0.8]);
               bar(i,sum(s.c(i,:)), 'facecolor', colors(i,:));
         end
    end
 
set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
set(gca,'XTickLabel',mp.sputnik_labels(:));
ylabel( 'FRAMES' , 'FontName' , 'courier' );
set(get(gca, 'YLabel' ), 'Rotation' ,90 )
hold off; 

set(gcf,'NextPlot','add');
axes;
    switch o
        case 1
        h = title('DD  Participants -- Raw Accumulation');
        case 2
        h = title('FXS Females --Raw Accumulation');
        otherwise
        h = title('FXS  Males -- Raw Accumulation ');
    end
set(gca,'Visible','off');
set(h,'Visible','on'); 
end;
  


% Graphic the percentages piecharts

for o =1:3

figure;
hold on; 
X =[];
axis off;
 switch o
        case 1
              for i = 1:numel(mp.sputnik(:,1))
              X = [X, sum(s.a(i,:))/frames.a(1)];
             end
        case 2
            for i = 1:numel(mp.sputnik(:,1))
            X = [X, sum(s.b(i,:))/frames.b(1)];         
            end
        otherwise
             for i = 1:numel(mp.sputnik(:,1))
               X = [X, sum(s.c(i,:))/frames.c(1)];
             end
 end
    X = [X  1-sum(X)];
    explode(1:length(X)) =2;
    lab=[mp.sputnik_labels  'Not Engaged'];
    %haa = pie(X,explode,lab);
    haa = pie(X,explode);
                                     % pie color handling
                                      v=1;
                                      for f= 1:2:2*numel(mp.sputnik(:,1))
                                      set(haa(f), 'FaceColor', colors(v,:));
                                      v=v+1;
                                      end
                                      set(haa(23), 'FaceColor', [0.8 0.8 0.8]);
hold off; 

%set(gcf,'NextPlot','add');
legend( lab(:),'location','eastoutside');
%axes;
    switch o
        case 1
        h = title(['DD  Participants -- %  of engagement,  # Children: '  num2str(count.a(1)) '# Frames: ' num2str(frames.a(1))]);
        case 2
        h = title(['FXS Females -- %  of engagement ,  # Children: '  num2str(count.b(1)) '# Frames: ' num2str(frames.b(1))]);
        otherwise
        h = title(['FXS  Males -- %  of engagement,  # Children: '  num2str(count.c(1)) '# Frames: ' num2str(frames.c(1))]);
      end
set(gca,'Visible','off');
set(h,'Visible','on'); 
end;
  






% Graphic the percentages
figure;
 iptsetpref('ImshowBorder','tight'); 

for o =1:3
subplot (2,3,o);
%subplot (9,9,i);
      %  [c,r] = ind2sub([1 3], o);
      %   h=subplot('Position', [(c-1)/5, 1-(r)/5, 1/5, 1/5])
                                              
hold on; 
 switch o
        case 1
              for i = 1:numel(mp.sputnik(:,1))
               bar(i,sum(s.a(i,:))/frames.a(1), 'facecolor', colors(i,:));
                end
        case 2
            for i = 1:numel(mp.sputnik(:,1))
                   bar(i,sum(s.b(i,:))/frames.b(1), 'facecolor', colors(i,:));
               end
        otherwise
             for i = 1:numel(mp.sputnik(:,1))
               bar(i,sum(s.c(i,:))/frames.c(1), 'facecolor', colors(i,:));
         end
    end
 
set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
set(gca,'YTick',[0:0.01:0.12]);
ylim([0 0.12])
set(gca,'XTickLabel',mp.sputnik_labels(:));
a=get(gca,'XTickLabel');
%erase current tick labels from figure
set(gca,'XTickLabel',[]);
%get tick label positions
b=get(gca,'XTick');
c=get(gca,'YTick');
rot=90;
%make new tick labels
text(b,repmat(c(1)-0.2*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','right','rotation',rot,'FontSize', 12, 'FontWeight', 'normal');
ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
set(get(gca, 'YLabel' ), 'Rotation' ,90 )

  switch o
        case 1
        h = title(['DD  Participants --   Children: '   num2str(count.a(1))  '-- Frames: '  num2str(frames.a(1)) ]);
        case 2
        h = title(['FXS Females -- Children: '  num2str(count.b(1))   '--  Frames: ' num2str(frames.b(1))] );
        otherwise
        h = title(['FXS  Males -- Children: '  num2str(count.c(1))  '--  Frames: ' num2str(frames.c(1))] ) ;
    end

hold off; 
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
           %  errorbar(i,minmax.a(i,3),minmax.a(i,1),minmax.a(i,2));
               e(1,1:length(s.a(i,:))) =i;
               scatter(e(1,:),s.a(i,:),'marker','+','markerfacecolor',[1  1  1]) ;
               end
        case 2
            for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.b(i,3), 'facecolor', colors(i,:));
              % errorbar(i,minmax.b(i,3),minmax.b(i,1),minmax.b(i,2));
              e(1:length(s.b(i,:))) =i;
               scatter(e(1,:),s.b(i,:),'marker','+','markerfacecolor',[1  1  1]) ;
            end
        otherwise
             for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.c(i,3), 'facecolor', colors(i,:));
             %  errorbar(i,minmax.c(i,3),minmax.c(i,1),minmax.c(i,2));
               e(1:length(s.c(i,:))) =i;
               scatter(e(1,:),s.c(i,:),'marker','+','markerfacecolor',[1  1 1]) ;
               end
    end
 
set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
set(gca,'XTickLabel',mp.sputnik_labels(:));
ylabel( 'FRAMES' , 'FontName' , 'courier' );
set(get(gca, 'YLabel' ), 'Rotation' ,90 )
grid on


set(gcf,'NextPlot','add');
axes;
    switch o
        case 1
        h = title('DD  Participants -- Mean and confidence values');
        case 2
        h = title('FXS Females -- Mean and confidence values');
        otherwise
        h = title('FXS  Males -- Mean and OBSERVATIONS');
    end
set(gca,'Visible','off');
set(h,'Visible','on'); 
ylabel('frames')
hold off; 
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
 