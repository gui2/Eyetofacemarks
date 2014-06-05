clear all;
close all;
 load mapping.mat;
directoryin ='PartialDistances/'; 
 ims = getAllFiles(directoryin);
 iptsetpref('ImshowBorder','tight'); 

 %set(gcf,'visible','off')
dsd =9;
num2str(dsd,'%06d'); 

meanframes = 0;

  
for o=1:3
    sortoff =1;
    dos = figure; 
    jota =1;
  %  keyboard;
    for i = 1:length(ims),
    hold on; 
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
                                                        ID =wwd{j,4};
                                                        if (~strcmp(doubles,wwd{j,2}) || ~strcmp('FXS_Males',wwd{j,5})&& o ==3)
                                                            continue;
                                                        end;
                                                        if (~strcmp(doubles,wwd{j,2}) || ~strcmp('FXS_Females',wwd{j,5})&& o ==2)
                                                             continue;
                                                        end;
                                                         if ((~strcmp(doubles,wwd{j,2}) || ~strcmp('DD_Participants',wwd{j,5})) && o ==1);
                                                              continue;
                                                        end;
  
               % Extraction of the average  --- 
               for j=1:199;
                    massa(1,j) =mean(ret(:,j));
                    s(1,j)  =  std(ret(:,j));
                    c(1,j) =  cov(ret(:,j));
                   if( s(1,j)  ==0)
                         s(1,j)  =1;
                    end;
               end;

    prev = 0;
    sum = 0;
   it =1;
     for q=1:length (ret(:,1));  % this guy itearates over the whole file 
     % if the eyetracking point is valid 
            if   (ret(q,202)>0) && 576-ret(q,203)>0 && ret(q,202)<600 &&  576-ret(q,203)>0
               plot( q , jota , 'o', 'MarkerSize',6,'MarkerFaceColor', [0 0 0],'Color', [0 0 0]);
               if (q < prev+5)
                   sum = sum +1;
                   prev = q;
               else
                    accum(it,1) = sum;
                    it=it+1;
                    sum = 1;
                    prev = q;
               end
            else 
        end
     end
     meanD= mean(accum);
     meanD = meanD / 5;
     Stddev(sortoff,o) =  std(accum);
     sumatoria (sortoff,o)  =  meanD;
     IDS(sortoff,o) = str2num(ID); 
     sortoff = sortoff +1; 
     jota = jota +5;
    
     hold off;
     ylabel( 'PARTICIPANT' , 'FontName' , 'courier' );
     set(get(gca, 'YLabel' ), 'Rotation' ,90 );
     xlabel( 'VIDEO - FRAME NUMBER ' , 'FontName' , 'courier' );

 %saveas(gg,['/Users/Gui/Eyetofacemarks/Results/ResultsMapping/'  name '-maps-'  num2str(q) '.jpg'] ,'jpg');
     break;

     end;
     end;
    gg=gcf;
   Fullmean(o)= mean (sumatoria (:,o));
   FullDev(o)= std (sumatoria (:,o));
 %saveas(gg,['/Users/Gui/Eyetofacemarks/Results/stickiness-' num2str(o) '.eps'] ,'epsc');
end; 
sumatoria= num2cell(sumatoria);
 IDS = num2cell(IDS);
 Stddev = num2cell(Stddev);
 
 C =  horzcat( IDS(:,1) , sumatoria(:,1),Stddev(:,1),IDS(:,2),sumatoria(:,2),Stddev(:,2),IDS(:,3),sumatoria(:,3),Stddev(:,3));
 Q = {'DD- ID' ,'Mean','Std' ,'FXS-Female-ID' ,'Mean','Std','FXS-Male-ID' ,'Mean','Std' }
 C =[Q;C];


      fid=fopen(['/Users/Gui/Eyetofacemarks/Results/CSV-Stickiness.csv'],'wt');
         [rows,cols]=size(C)
         fprintf(fid,'%s,',C{1,1:end-1})
         fprintf(fid,'%s\n',C{1,end}) 
         for i=2:rows
              fprintf(fid,'%f,',C{i,1:end-1})
              fprintf(fid,'%f\n',C{i,end})
         end



 csvwrite('/Users/Gui/Eyetofacemarks/Results/CSV-Individual-MeanValues.csv',sumatoria);
 csvwrite('/Users/Gui/Eyetofacemarks/Results/CSV-Individual-Deviation.csv',Stddev);
 csvwrite('/Users/Gui/Eyetofacemarks/Results/CSV-Group-FullMean.csv',Fullmean);
 csvwrite('/Users/Gui/Eyetofacemarks/Results/CSV-Group-FullDev.csv',FullDev);
