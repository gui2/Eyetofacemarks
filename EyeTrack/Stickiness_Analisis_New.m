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
framesX = struct('a',zeros(0),'b',zeros(0),'c',zeros(0));
Age = struct('a',zeros(0),'b',zeros(0),'c',zeros(0));
IQ = struct('a',zeros(0),'b',zeros(0),'c',zeros(0));
LookingAT = struct('a',zeros(0),'b',zeros(0),'c',zeros(0));
VIDEO = struct('a',[],'b',[],'c',[]);
NNAME = struct('a',[],'b',[],'c',[]);


  for o =1:3
               
    sortoff =1;
    dos = figure; 
    hold on;
    jota =1;
                      for r= 1:length(ims), % for each video    
                                           p= char(ims(r,1));
                                           [pathstr, name, ext] = fileparts(p);
                                           [pathstrB, nameB, extB] = fileparts(name);
                                           if(~strcmp( '.mat',ext) && ~strcmp( '.faceparts',extB)) 
                                                 continue; 
                                           end;
                                           [pathstr, name, ext] = fileparts(name);
                                           double = [name];
                                           
                                           % Split By Groups 
                                           for ( j=1:length(wwd(:,5)))
                                                        % the type of participant
                                                         ID =wwd{j,4};
                                                        if (~strcmp(double,wwd{j,2}) || ~strcmp('FXS_Males',wwd{j,5})&& o ==3)
                                                            continue;
                                                        end;
                                                           % the type of participant
                                                        if (~strcmp(double,wwd{j,2}) || ~strcmp('FXS_Females',wwd{j,5})&& o ==2)
                                                             continue;
                                                        end;
                                                           % the type of participant
                                                         if ((~strcmp(double,wwd{j,2}) || ~strcmp('DD_Participants',wwd{j,5})) && o ==1)
                                                             continue;
                                                        end;

                                                       mp = load (p);
                                                       mp.video = wwd{j,2};
                                                       mp.name = wwd{j,4};
                                                       mp.age = wwd{j,7};
                                                       mp.IQ = wwd{j,6};

                                                                        for i = 1:numel(mp.sputnik(:,1))
                                                                          end
                                                                           lf =length (mp.ret(:,1));
                                                                          switch o
                                                                           
                                                                            case 1
                                                                            s.a = [s.a, mp.sputnik(:,1)];
                                                                            Age.a= [ Age.a,  mp.age];
                                                                            IQ.a = [IQ.a,  mp.IQ];
                                                                               %append(mp.name,NNAME.a)
                                                                           NNAME.a =[NNAME.a, str2num(mp.name)];
                                                                           % VIDEO.a =[VIDEO.a, mp.video];
                                                                          count.a =count.a+1 ;
                                                                          frames.a = frames.a + lf ;
                                                                          framesX.a = [framesX.a , lf];
                                                                           Trans =mp.ret(:,211);
                                                                 
                                                                          case 2
                                                                            s.b =  [s.b,mp.sputnik(:,1)];
                                                                           Age.b= [ Age.b,  mp.age];
                                                                           IQ.b= [IQ.b,  mp.IQ];
                                                                           NNAME.b =[NNAME.b,str2num(mp.name)];
                                                                           %  VIDEO.b =[VIDEO.b, mp.video];
                                                                           count.b=count.b+1 ;
                                                                           frames.b = frames.b + length (mp.ret(:,1));
                                                                           framesX.b = [framesX.b , lf];
                                                                           
                                                                           Trans =mp.ret(:,211);
%                                                                           fid=fopen(['/Users/Gui/Eyetofacemarks/Results/BruteMapping/FXS_F.' mp.name  '.csv'],'wt');
%                                                                           fprintf(fid,'%s\n ',mp.age{1,1} ); 
%                                                                           fprintf(fid,'%s\n ',mp.IQ{1,1} ); 
%                                                                            Trans=[ num2cell(mp.ret(:,211))];
%                                                                           Trans =mp.ret(:,211);
%                                                                           fprintf(fid,'%i\n ',Trans(:));
%                                                        
                                                                           %LookingAT.b = [LookingAT.b , mp.ret(:,211)];
                                                                            otherwise
                                                                           s.c = [s.c,mp.sputnik(:,1)];   
                                                                           Age.c= [ Age.c,  mp.age];
                                                                            IQ.c= [IQ.c,  mp.IQ];
                                                                            NNAME.c =[NNAME.c, str2num(mp.name)];
                                                                           % VIDEO.c =[VIDEO.c, mp.video];
                                                                           count.c=count.c+1 ;
                                                                           frames.c= frames.c + length (mp.ret(:,1));
                                                                           framesX.c = [framesX.c , lf];
                                                                           Trans =mp.ret(:,211);
%                                                                           fid=fopen(['/Users/Gui/Eyetofacemarks/Results/BruteMapping/FXS_M.' mp.name  '.csv'],'wt');
%                                                                            fprintf(fid,'%s\n ',mp.age{1,1} ); 
%                                                                            fprintf(fid,'%s\n ',mp.IQ{1,1} ); 
%                                                                            Trans=[ num2cell(mp.ret(:,211))];
%                                                                            Trans =mp.ret(:,211);
%                                                                            fprintf(fid,'%i\n ',Trans(:));
%                                                                          end
                                                                             end; 
                                      
                                                                             prev = 0;
                                                                             sum = 0;
                                                                             it =1;
                                                                             
                                                                             for q=1:length (Trans(:));  % this guy itearates over the whole file 
                                                                               % if the eyetracking point is valid
                                                                               if   (Trans(q,1)~=0 )
                                                                                     plot( q , jota , 'o', 'MarkerSize',6,'MarkerFaceColor', [0 0 0],'Color', [0 0 0]);
                                                                                      valueadded =q-prev+1;
                                                                                     
                                                                                   if (q < prev+5)
                                                                                        sum = sum + valueadded;
                                                                                   else
                                                                                       accum(it,1) = sum;
                                                                                       accum_inter_bout(it,1) = (q - prev) ;
                                                                                       it=it+1;
                                                                                       sum = 1;
                                                                                      end
                                                                                      
                                                                                     prev = q;
                                                                               else
                                                                               end
                                                                               
                                                                             end
                                                                             
                                                                             
                                                                
                                                                          StddevInter(sortoff,o) =  std(accum_inter_bout);
                                                                          Stddev(sortoff,o) =  std(accum);
                                                                        
                                                                          sumatoriaInter (sortoff,o)  =   mean(accum_inter_bout);;
                                                                          sumatoria (sortoff,o)  =   mean(accum);;
                                                                         
                                                                          IDS(sortoff,o) = str2num(ID); 
                                                                           sortoff = sortoff +1; 
                                                                           jota = jota +5;
                                      
                      end; 
     end;
                  
     hold off;
     ylabel( 'PARTICIPANT' , 'FontName' , 'courier' );
     set(get(gca, 'YLabel' ), 'Rotation' ,90 );
     xlabel( 'VIDEO - FRAME NUMBER ' , 'FontName' , 'courier' );
     
    gg=gcf;
    
    Fullmean(o)= mean (sumatoria (:,o));
    FullDev(o)= std (sumatoria (:,o));
    
  end;
  
  sumatoria=sumatoria/5;
  sumatoriaInter=sumatoriaInter/5;
  
  StddevInter=StddevInter/5;
  Stddev=Stddev/5;
  
  
 sumatoria= num2cell(sumatoria);
 sumatoriaInter= num2cell(sumatoriaInter);
 
 
 IDS = num2cell(IDS);
 Stddev = num2cell(Stddev);
 StddevInter= num2cell(StddevInter);

C =  horzcat( IDS(:,1) , sumatoria(:,1),Stddev(:,1),sumatoriaInter(:,1),StddevInter(:,1),IDS(:,2),sumatoria(:,2),Stddev(:,2),sumatoriaInter(:,2),StddevInter(:,2),IDS(:,3),sumatoria(:,3),Stddev(:,3),sumatoriaInter(:,3),StddevInter(:,3));
 Q = {'DD- ID' ,'MeanEngaged','StdEngaged','MeanNOTEngaged','StdNOTEngaged' ,'FXS-Female-ID' ,'MeanEngaged','StdEngaged','MeanNOTEngaged','StdNOTEngaged','FXS-Male-ID' ,'MeanEngaged','StdEngaged','MeanNOTEngaged','StdNOTEngaged'}
 C =[Q;C];


      fid=fopen(['/Users/Gui/Eyetofacemarks/Results/5frames-20pixel-CSV-Stickiness-smooth.csv'],'wt');
         [rows,cols]=size(C)
         fprintf(fid,'%s,',C{1,1:end-1})
         fprintf(fid,'%s\n',C{1,end}) 
         for i=2:rows
              fprintf(fid,'%f,',C{i,1:end-1})
              fprintf(fid,'%f\n',C{i,end})
         end



 %csvwrite('/Users/Gui/Eyetofacemarks/Results/5frames-20pixel-CSV-Individual-MeanValues.csv',sumatoria);
 %csvwrite('/Users/Gui/Eyetofacemarks/Results/5frames-20pixel-CSV-Individual-Deviation.csv',Stddev);
 %csvwrite('/Users/Gui/Eyetofacemarks/Results/5frames-20pixel-CSV-Group-FullMean.csv',Fullmean);
 %csvwrite('/Users/Gui/Eyetofacemarks/Results/5frames-20pixel-CSV-Group-FullDev.csv',FullDev);
  
  
keyboard;

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