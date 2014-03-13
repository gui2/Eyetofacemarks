clear all;
close all
 load mapping.mat;
directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);

 iptsetpref('ImshowBorder','tight'); 

 
  %% PLOT XF_MALE
Accum_sputnik(1:11,1:3) =0;
Min_Accum_sputnik(1:11,1:3) =0;
Max_Accum_sputnik(1:11,1:3) =0;

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
 %  ax(4)=ax(4)+0.01; %or wathever 
   ax(3)=ax(3)+0.02; %or wathever 
   set(h,'Position',ax);
   axis off;
   colors =hsv(12);
   hold on; 
    for i = 1:numel(mp.sputnik(:,1))
    bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
    end
end;
   
   figure 
   hold on;
   for i = 1:numel(mp.sputnik(:,1))
    bar(i,mp.sputnik(i,1), 'facecolor', colors(i,:));
   end
   set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
   set(gca,'XTickLabel',mp.sputnik_labels(:));
   hold off;
 
 