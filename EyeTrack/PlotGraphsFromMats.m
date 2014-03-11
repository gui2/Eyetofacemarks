clear all;
close all
 
directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);
 fHand = figure;
 iptsetpref('ImshowBorder','tight'); 

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
  f = [1,2,3,4,5,6,7,8,9,10,11];
   colors = hsv(f (:));
   
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
 
 