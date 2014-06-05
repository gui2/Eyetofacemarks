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
VIDEO = struct('a',[],'b',[],'c',[]);
NNAME = struct('a',[],'b',[],'c',[]);





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
                                                        % the type of participant
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
                                                                          case 2
                                                                          s.b =  [s.b,mp.sputnik(:,1)];
                                                                         Age.b= [ Age.b,  mp.age];
                                                                         IQ.b= [IQ.b,  mp.IQ];
                                                                        NNAME.b =[NNAME.b,str2num(mp.name)];
                                                                       %  VIDEO.b =[VIDEO.b, mp.video];
                                                                         count.b=count.b+1 ;
                                                                         frames.b = frames.b + length (mp.ret(:,1));
                                                                         framesX.b = [framesX.b , lf];
                                                                           otherwise
                                                                         s.c = [s.c,mp.sputnik(:,1)];   
                                                                         Age.c= [ Age.c,  mp.age];
                                                                         IQ.c= [IQ.c,  mp.IQ];
                                                                         NNAME.c =[NNAME.c, str2num(mp.name)];
                                                                      %  VIDEO.c =[VIDEO.c, mp.video];
                                                                         
                                                                         count.c=count.c+1 ;
                                                                         frames.c= frames.c + length (mp.ret(:,1));
                                                                         framesX.c = [framesX.c , lf];
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



% Statistics By COARSE  IQ .
for o =1:3 % for each group 
    m=figure; 
    mari =[];
    clearvars sortedValues sortIndex lab
    switch o
        case 1
                   NN = NNAME.a(:);
                   T=IQ.a;
                   T = str2double(T)
                      [sortedValues,sortIndex] = sort(T); % sort in ascendent order 
                      for mark =1:numel(mp.sputnik(:,1)) % iterate over the 11 face marks
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.a(mark,sortIndex(p))/framesX.a(sortIndex(p))]; % normalize to  the percentage of frames attending to the mark 
                             nops = cc;
                              end;
                           aa = transpose(sortedValues); 
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline; % linear regression  single variable least square line 
                     end;
                     % the rest is all about  graphics and display 
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels ];
                        legend(ls(:),lab,'location','eastoutside');
                       % case 2 and 3 should be all put in the same function. This
                       % was copied and pasted  because of deadline. 
               
        case 2
                  T=IQ.b;
                  T = str2double(T)
                  NN = NNAME.b(:);
                   [sortedValues,sortIndex] = sort(T);
                    for mark =1:numel(mp.sputnik(:,1))
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.b(mark,sortIndex(p))/framesX.b(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels];
                        legend(ls(:),lab,'location','eastoutside');
                    
        otherwise
                   T=IQ.c;
                   T = str2double(T)
                    NN = NNAME.c(:);
                   [sortedValues,sortIndex] = sort(T);
                     for mark =1:numel(mp.sputnik(:,1))
                     hold on; 
                             cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.c(mark,sortIndex(p))/framesX.c(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels  'Not Engaged'];
                        legend(ls(:),lab,'location','eastoutside');
                      
    end
                    % this is to capture the ID of te people"
                    FN =[];     
                    for p=1:length(NN)
                    FN  = [FN, NN(sortIndex(p))];
                    end
               
     R= [];        
    % Setting the title
    F =num2cell(transpose(mari));
    G =[F(:,1) F(:, 2)];
    R  = horzcat(R, sum(cell2mat(G),2) );
    % adding the left eye and eyebrowl 
    G =[F(:, 3) F(:, 4) ];
    R  = horzcat(R, sum(cell2mat(G),2) );
    % adding the right eye and eyebrowl 
    G =[F(:, 5) F(:, 6) ];
    R  = horzcat(R, sum (cell2mat(G),2));
    % adding the mouth
    R (:,4) =cell2mat(F(:,7)) ;
    % adding left chin jaw side
    G =[F(:, 9) F(:, 10) ];
    R = horzcat(R, sum (cell2mat(G),2));
    
   % adding the right chin jaw side
    G =[F(:, 8) F(:, 11) ];
    R = horzcat(R, sum (cell2mat(G),2));
    Q = {'nose' ,'L eye' ,'R eye' ,'mouth' ,'L chin jaw ' ,'R chin jaw ' }
    

    
    S=  mp.sputnik_labels
    KK= ['IQ',num2cell(sortedValues)]
    C = [Q ; num2cell(R)];
    C=  horzcat(C,transpose(KK));
    C=  horzcat(C,transpose(['ID' ,num2cell(FN)]));
    

             ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
             set(get(gca, 'YLabel' ), 'Rotation' ,90 )
             xlabel( 'IQ' , 'FontName' , 'courier' );
            set(gcf,'NextPlot','add');
            axes;
            switch o
                    case 1
                    h = title('DD  Participants BY IQ');
                    case 2
                    h = title('FXS Females BY IQ');
                    otherwise
                    h = title('FXS  Males BY IQ');
                    end
            set(gca,'Visible','off');
            set(h,'Visible','on');     
            gg=gcf;
          
            saveas(gg,['/Users/Gui/Eyetofacemarks/Results/COARSE-IQ-LS-' num2str(o) '.eps'] ,'epsc');
        
         % save the data in a file 
         clearvars mari 
         fid=fopen(['/Users/Gui/Eyetofacemarks/Results/COARSE-ENGAGEMENT-IQ-' num2str(o) '.csv'],'wt');
         [rows,cols]=size(C)
         fprintf(fid,'%s,',C{1,1:end-1})
         fprintf(fid,'%s\n',C{1,end}) 
         for i=2:rows
              fprintf(fid,'%f,',C{i,1:end-1})
              fprintf(fid,'%f\n',C{i,end})
         end
   
end;

% Statistics By COARSE  AGE .
for o =1:3 % for each group 
    m=figure; 
    mari =[];
    clearvars sortedValues sortIndex lab
    switch o
        case 1
                     T=Age.a;
                     T = str2double(T)
                     NN = NNAME.a(:);
                      [sortedValues,sortIndex] = sort(T); % sort in ascendent order 
                      for mark =1:numel(mp.sputnik(:,1)) % iterate over the 11 face marks
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.a(mark,sortIndex(p))/framesX.a(sortIndex(p))]; % normalize to  the percentage of frames attending to the mark 
                              end;
                           aa = transpose(sortedValues); 
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline; % linear regression  single variable least square line 
                     end;
                     % the rest is all about  graphics and display 
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels ];
                        legend(ls(:),lab,'location','eastoutside');
               % case 2 and 3 should be all put in the same function. This
               % was copied and pasted  because of deadline. 
        case 2
                  T=Age.b;
                  T = str2double(T)
                           NN = NNAME.b(:);
                   [sortedValues,sortIndex] = sort(T);
                    for mark =1:numel(mp.sputnik(:,1))
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.b(mark,sortIndex(p))/framesX.b(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels];
                        legend(ls(:),lab,'location','eastoutside');
        otherwise
                    T=Age.c;
                    T = str2double(T)
                     NN = NNAME.c(:);
                   [sortedValues,sortIndex] = sort(T);
                     for mark =1:numel(mp.sputnik(:,1))
                     hold on; 
                             cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.c(mark,sortIndex(p))/framesX.c(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels  'Not Engaged'];
                        legend(ls(:),lab,'location','eastoutside');
                      
    end
             
                        % this is to capture the ID of te people"
                    FN =[];     
                    for p=1:length(NN)
                    FN  = [FN, NN(sortIndex(p))];
                    end
     R= [];           
    % Setting the title
    F =num2cell(transpose(mari));
    G =[ F(:, 1)  F(:, 2)];
    R  = horzcat(R, sum(cell2mat(G),2) );
    % adding the left eye and eyebrowl 
    G =[F(:, 3) F(:, 4) ];
    R  = horzcat(R, sum(cell2mat(G),2) );
    % adding the right eye and eyebrowl 
    G =[F(:, 5) F(:, 6) ];
    R  = horzcat(R, sum (cell2mat(G),2));
    % adding the mouth
    R (:,4) =cell2mat(F(:,7)) ;
    % adding left chin jaw side
    G =[F(:, 9) F(:, 10) ];
    R = horzcat(R, sum (cell2mat(G),2));
    
   % adding the right chin jaw side
    G =[F(:, 8) F(:, 11) ];
    R = horzcat(R, sum (cell2mat(G),2));
    Q = {'nose' ,'L eye' ,'R eye' ,'mouth' ,'L chin jaw ' ,'R chin jaw ' }
    
    
    S=  mp.sputnik_labels
    KK= ['AGE',num2cell(sortedValues)]
    C = [Q ; num2cell(R)];
    C=  horzcat(C,transpose(KK));
    C=  horzcat(C,transpose(['ID' ,num2cell(FN)]));
             ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
             set(get(gca, 'YLabel' ), 'Rotation' ,90 )
             xlabel( 'IQ' , 'FontName' , 'courier' );
            set(gcf,'NextPlot','add');
            axes;
            switch o
                    case 1
                    h = title('DD  Participants BY IQ');
                    case 2
                    h = title('FXS Females BY IQ');
                    otherwise
                    h = title('FXS  Males BY IQ');
                    end
            set(gca,'Visible','off');
            set(h,'Visible','on');     
            gg=gcf;
          
         % saveas(gg,['/Users/Gui/Eyetofacemarks/Results/COARSE-IQ-LS-' num2str(o) '.eps'] ,'epsc');
        
         % save the data in a file 
         clearvars mari 
         fid=fopen(['/Users/Gui/Eyetofacemarks/Results/COARSE-ENGAGEMENT-AGE-' num2str(o) '.csv'],'wt');
         [rows,cols]=size(C)
         fprintf(fid,'%s,',C{1,1:end-1})
         fprintf(fid,'%s\n',C{1,end}) 
         for i=2:rows
              fprintf(fid,'%f,',C{i,1:end-1})
              fprintf(fid,'%f\n',C{i,end})
         end
   
end;

% Statistics By IQ .
for o =1:3 % for each group 
    m=figure; 
    mari =[];
    clearvars sortedValues sortIndex lab
    switch o
        case 1
                     T=IQ.a;
                     T = str2double(T)
                     NN = NNAME.a(:);
                      [sortedValues,sortIndex] = sort(T); % sort in ascendent order 
                      for mark =1:numel(mp.sputnik(:,1)) % iterate over the 11 face marks
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.a(mark,sortIndex(p))/framesX.a(sortIndex(p))]; % normalize to  the percentage of frames attending to the mark 
                              end;
                           aa = transpose(sortedValues); 
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline; % linear regression  single variable least square line 
                     end;
                     % the rest is all about  graphics and display 
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels ];
                        legend(ls(:),lab,'location','eastoutside');
               % case 2 and 3 should be all put in the same function. This
               % was copied and pasted  because of deadline. 
        case 2
                   NN = NNAME.b(:);
                  T=IQ.b;
                  T = str2double(T)
                   [sortedValues,sortIndex] = sort(T);
                    for mark =1:numel(mp.sputnik(:,1))
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.b(mark,sortIndex(p))/framesX.b(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels];
                        legend(ls(:),lab,'location','eastoutside');
        otherwise
                    NN = NNAME.c(:);
                    T=IQ.c;
                    T = str2double(T)
                   [sortedValues,sortIndex] = sort(T);
                     for mark =1:numel(mp.sputnik(:,1))
                     hold on; 
                             cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.c(mark,sortIndex(p))/framesX.c(sortIndex(p))];
                             end;
                          aa = transpose(sortedValues);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                           mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels  'Not Engaged'];
                        legend(ls(:),lab,'location','eastoutside');
                      
    end
                     FN =[];     
                    for p=1:length(NN)
                    FN  = [FN, NN(sortIndex(p))];
                    end
                    
    % Setting the title
    F =num2cell(transpose(mari));
    S=  mp.sputnik_labels
    KK= ['IQ',num2cell(sortedValues)]
    C = [S;F];
    C=horzcat(C,transpose(KK));
    C=  horzcat(C,transpose(['ID' ,num2cell(FN)]));
   
            ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
             set(get(gca, 'YLabel' ), 'Rotation' ,90 )
             xlabel( 'IQ' , 'FontName' , 'courier' );
            set(gcf,'NextPlot','add');
            axes;
            switch o
                    case 1
                    h = title('DD  Participants BY IQ');
                    case 2
                    h = title('FXS Females BY IQ');
                    otherwise
                    h = title('FXS  Males BY IQ');
                    end
            set(gca,'Visible','off');
            set(h,'Visible','on');     
            gg=gcf;
          
            saveas(gg,['/Users/Gui/Eyetofacemarks/Results/IQ-LS-' num2str(o) '.eps'] ,'epsc');
        
         % save the data in a file 
         clearvars mari 
         fid=fopen(['/Users/Gui/Eyetofacemarks/Results/ENGAGEMENT-IQ-' num2str(o) '.csv'],'wt');
         [rows,cols]=size(C)
         fprintf(fid,'%s,',C{1,1:end-1})
         fprintf(fid,'%s\n',C{1,end}) 
         for i=2:rows
              fprintf(fid,'%f,',C{i,1:end-1})
              fprintf(fid,'%f\n',C{i,end})
         end
   
end;

% Statistics by Age 
for o =1:3
    mari =[]
    m=figure; 
    clearvars sortedValues sortIndex lab
    
    switch o
        case 1
            T=Age.a;
            T = str2double(T)
                        NN = NNAME.a(:);
            [sortedValues,sortIndex] = sort(T);
         
                      for mark =1:numel(mp.sputnik(:,1))
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.a(mark,sortIndex(p))/framesX.a(sortIndex(p))];
                              end;
                           aa = transpose(sortedValues);
                
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                            mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels ];
                        legend(ls(:),lab,'location','eastoutside');
              
        case 2
             T=Age.b;
            T = str2double(T)
                        NN = NNAME.b(:);
            [sortedValues,sortIndex] = sort(T);
                %   [sortedValues,sortIndex] = sort(Age.b(:));
                    for mark =1:numel(mp.sputnik(:,1))
                       hold on; 
                       cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.b(mark,sortIndex(p))/framesX.b(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                           %aa = cellfun(@str2double,b);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                            mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels];
                        legend(ls(:),lab,'location','eastoutside');
        otherwise
                        T=Age.c;
            T = str2double(T)
                        NN = NNAME.c(:);
            [sortedValues,sortIndex] = sort(T);
            %        [sortedValues,sortIndex] = sort(Age.c(:));
                     for mark =1:numel(mp.sputnik(:,1))
                       hold on; 
                             cc =[];
                              for (p = 1: length(sortIndex))
                              cc = [cc, s.c(mark,sortIndex(p))/framesX.c(sortIndex(p))];
                             end;
                           aa = transpose(sortedValues);
                          %aa = cellfun(@str2double,b);
                           plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
                            mari = [mari ; cc(1,:)];
                           ls = lsline;
                     end;
                    for mark =1:numel(mp.sputnik(:,1))
                             set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
                    end;
                        hold off;
                        lab=[mp.sputnik_labels  'Not Engaged'];
                        legend(ls(:),lab,'location','eastoutside');
        
    end
    
             FN =[];     
                    for p=1:length(NN)
                    FN  = [FN, NN(sortIndex(p))];
                    end
                    
    clearvars F S KK C
    % Setting the title
    F =num2cell(transpose(mari));
    S=  mp.sputnik_labels
    KK= ['AGE',num2cell(sortedValues)]
    C = [S;F];
    C=horzcat(C,transpose(KK));
        C=  horzcat(C,transpose(['ID' ,num2cell(FN)]));
    
    % Setting the title
            ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
             set(get(gca, 'YLabel' ), 'Rotation' ,90 )
             xlabel( 'AGE' , 'FontName' , 'courier' );
            set(gcf,'NextPlot','add');
            axes;
            switch o
                    case 1
                    h = title('DD  Participants BY AGE');
                    case 2
                    h = title('FXS Females BY AGE');
                    otherwise
                    h = title('FXS  Males BY AGE');
                    end
            set(gca,'Visible','off');
            set(h,'Visible','on');
    
          gg=gcf;
          saveas(gg,['/Users/Gui/Eyetofacemarks/Results/AGE-LS-' num2str(o) '.eps'] ,'epsc');
        
         % save the data in a file 
         clearvars mari 
         fid=fopen(['/Users/Gui/Eyetofacemarks/Results/ENGAGEMENT-AGE-' num2str(o) '.csv'],'wt');
         [rows,cols]=size(C)
         fprintf(fid,'%s,',C{1,1:end-1})
         fprintf(fid,'%s\n',C{1,end}) 
         for i=2:rows
              fprintf(fid,'%f,',C{i,1:end-1})
              fprintf(fid,'%f\n',C{i,end})
         end
end;



% Graphic the accumulation
for o =1:3
m=figure;
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
a=get(gca,'XTickLabel');
set(gca,'XTickLabel',[]);
%get tick label positions
b=get(gca,'XTick');
c=get(gca,'YTick');
rot=90;
%make new tick labels
text(b,repmat(c(1)-0.1*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','right','rotation',rot,'FontSize', 8, 'FontWeight', 'normal');
ylabel( 'FRAMES' , 'FontName' , 'courier' );
set(get(gca, 'YLabel' ), 'Rotation' ,90 )

    switch o
        case 1
        h = title('DD  Participants -- Raw Accumulation');
        case 2
        h = title('FXS Females --Raw Accumulation');
        otherwise
        h = title('FXS  Males -- Raw Accumulation ');
    end
    
    gg=gcf;
    saveas(gg,['/Users/Gui/Eyetofacemarks/Results/' num2str(o) 'ACCUM.eps'] ,'epsc');
hold off; 
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
     gg=gcf;

  saveas(gg,['/Users/Gui/Eyetofacemarks/Results/' num2str(o) '.PIE.eps'] ,'epsc');     
    hold off; 
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
set(gca,'XTickLabel',[]);
%get tick label positions
b=get(gca,'XTick');
c=get(gca,'YTick');
rot=90;
%make new tick labels
text(b,repmat(c(1)-0.2*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','right','rotation',rot,'FontSize', 9, 'FontWeight', 'normal');
ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
set(get(gca, 'YLabel' ), 'Rotation' ,90 )

  switch o
        case 1
        h = title(['DD  Participants, Children:'   num2str(count.a(1))   ', Marks:  '   num2str(frames.a(1)*99) ],'FontSize',7);
        case 2
        h = title(['FXS Females, Children:'  num2str(count.b(1))   ', Marks: '    num2str(frames.b(1)*99)],'FontSize', 7);
        otherwise
        h = title(['FXS  Males, Children:'  num2str(count.c(1))  ',  Marks:  '  num2str(frames.c(1)*99)],'FontSize', 7);
    end
     gg=gcf;
    saveas(gg,['/Users/Gui/Eyetofacemarks/Results/' num2str(o) '.Percentage.eps'] ,'epsc');     

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
               e(1,1:length(s.a(i,:))) =i;
               scatter(e(1,:),s.a(i,:),'marker','+','markerfacecolor',[1  1  1]) ;
               end
        case 2
            for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.b(i,3), 'facecolor', colors(i,:));
               e(1:length(s.b(i,:))) =i;
               scatter(e(1,:),s.b(i,:),'marker','+','markerfacecolor',[1  1  1]) ;
            end
        otherwise
             for i = 1:numel(mp.sputnik(:,1))
               bar(i,minmax.c(i,3), 'facecolor', colors(i,:));
                e(1:length(s.c(i,:))) =i;
               scatter(e(1,:),s.c(i,:),'marker','+','markerfacecolor',[1  1 1]) ;
               end
    end
 
set(gca,'XTick',[1:length(mp.sputnik_labels(:))]);
set(gca,'XTickLabel',mp.sputnik_labels(:));
a=get(gca,'XTickLabel');
set(gca,'XTickLabel',[]);
%get tick label positions
b=get(gca,'XTick');
c=get(gca,'YTick');
rot=90;
%make new tick labels
text(b,repmat(c(1)-0.1*(c(2)-c(1)),length(b),1),a,'HorizontalAlignment','right','rotation',rot,'FontSize',8, 'FontWeight', 'normal');

ylabel( 'FRAMES' , 'FontName' , 'courier' );
set(get(gca, 'YLabel' ), 'Rotation' ,90 )
grid on


%set(gcf,'NextPlot','add');
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
  gg=gcf;
  saveas(gg,['/Users/Gui/Eyetofacemarks/Results/' num2str(o) '.AVERAGE.eps'] ,'epsc');     


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


 