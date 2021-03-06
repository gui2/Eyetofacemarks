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
                     figure;
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
                                                                          %LookingAT.a = [LookingAT.a , mp.ret(:,211)];
                                                                      
                                                                          fid=fopen(['/Users/Gui/Eyetofacemarks/Results/BruteMapping/DD.' mp.name  '.csv'],'wt');
                                                                         % Trans=[str2num(mp.name) ; str2num(mp.IQ); str2num(mp.age) ;  num2cell(mp.ret(:,211))];
                                                                          fprintf(fid,'%s\n ',mp.age{1,1} ); 
                                                                          fprintf(fid,'%s\n ',mp.IQ{1,1} ); 
                                                                         Trans=[ num2cell(mp.ret(:,211))];
                                                                         Trans =mp.ret(:,211);
                                                                          fprintf(fid,'%i\n ',Trans(:));
                                                       
                                                                          case 2
                                                                            s.b =  [s.b,mp.sputnik(:,1)];
                                                                           Age.b= [ Age.b,  mp.age];
                                                                           IQ.b= [IQ.b,  mp.IQ];
                                                                           NNAME.b =[NNAME.b,str2num(mp.name)];
                                                                           %  VIDEO.b =[VIDEO.b, mp.video];
                                                                           count.b=count.b+1 ;
                                                                           frames.b = frames.b + length (mp.ret(:,1));
                                                                           framesX.b = [framesX.b , lf];
                                                                          fid=fopen(['/Users/Gui/Eyetofacemarks/Results/BruteMapping/FXS_F.' mp.name  '.csv'],'wt');
                                                                          fprintf(fid,'%s\n ',mp.age{1,1} ); 
                                                                          fprintf(fid,'%s\n ',mp.IQ{1,1} ); 
                                                                           Trans=[ num2cell(mp.ret(:,211))];
                                                                          Trans =mp.ret(:,211);
                                                                          fprintf(fid,'%i\n ',Trans(:));
                                                       
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
                                                                          fid=fopen(['/Users/Gui/Eyetofacemarks/Results/BruteMapping/FXS_M.' mp.name  '.csv'],'wt');
                                                                           fprintf(fid,'%s\n ',mp.age{1,1} ); 
                                                                           fprintf(fid,'%s\n ',mp.IQ{1,1} ); 
                                                                           Trans=[ num2cell(mp.ret(:,211))];
                                                                           Trans =mp.ret(:,211);
                                                                           fprintf(fid,'%i\n ',Trans(:));
                                                                           %LookingAT.c= [LookingAT.c , mp.ret(:,211)];
                                                                         end
                                      end; 
                        end; 
    
end;


% 
%  
% % Statistics By COARSE  IQ .
% for o =1:3 % for each group 
%          mari =[];
%            clearvars sortedValues sortIndex lab
%     switch o
%         case 1
%                    NN = NNAME.a(:);
%                    T=IQ.a;
%                    T = str2double(T)
%                    
%                      [sortedValues,sortIndex] = sort(T); % sort in ascendent order 
%                       for mark =1:numel(mp.sputnik(:,1)) % iterate over the 11 face marks
%                        hold on; 
%                        cc =[];
%                               for (p = 1: length(sortIndex))
%                               cc = [cc, s.a(mark,sortIndex(p))/framesX.a(sortIndex(p))]; % normalize to  the percentage of frames attending to the mark 
%                              nops = cc;
%                               end;
%                            aa = transpose(sortedValues); 
%                            plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
%                            mari = [mari ; cc(1,:)];
%                            ls = lsline; % linear regression  single variable least square line 
%                      end;
%                      % the rest is all about  graphics and display 
%                     for mark =1:numel(mp.sputnik(:,1))
%                              set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
%                     end;
%                         hold off;
%                         lab=[mp.sputnik_labels ];
%                         legend(ls(:),lab,'location','eastoutside');
%                        % case 2 and 3 should be all put in the same function. This
%                        % was copied and pasted  because of deadline. 
%                
%         case 2
%                   T=IQ.b;
%                   T = str2double(T)
%                   NN = NNAME.b(:);
%                    [sortedValues,sortIndex] = sort(T);
%                     for mark =1:numel(mp.sputnik(:,1))
%                        hold on; 
%                        cc =[];
%                               for (p = 1: length(sortIndex))
%                               cc = [cc, s.b(mark,sortIndex(p))/framesX.b(sortIndex(p))];
%                              end;
%                            aa = transpose(sortedValues);
%                            plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
%                            mari = [mari ; cc(1,:)];
%                            ls = lsline;
%                      end;
%                     for mark =1:numel(mp.sputnik(:,1))
%                              set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
%                     end;
%                         hold off;
%                         lab=[mp.sputnik_labels];
%                         legend(ls(:),lab,'location','eastoutside');
%                     
%         otherwise
%                    T=IQ.c;
%                    T = str2double(T)
%                     NN = NNAME.c(:);
%                    [sortedValues,sortIndex] = sort(T);
%                      for mark =1:numel(mp.sputnik(:,1))
%                      hold on; 
%                              cc =[];
%                               for (p = 1: length(sortIndex))
%                               cc = [cc, s.c(mark,sortIndex(p))/framesX.c(sortIndex(p))];
%                              end;
%                            aa = transpose(sortedValues);
%                            plot(aa, cc(1,:) ,'o', 'MarkerSize',5,'MarkerFaceColor', colors(mark,:)) ;
%                            mari = [mari ; cc(1,:)];
%                            ls = lsline;
%                      end;
%                     for mark =1:numel(mp.sputnik(:,1))
%                              set(ls(mark), 'color', colors(mark,:), 'LineWidth', 2 ); 
%                     end;
%                         hold off;
%                         lab=[mp.sputnik_labels  'Not Engaged'];
%                         legend(ls(:),lab,'location','eastoutside');
%                       
%     end
%                     % this is to capture the ID of te people"
%                     FN =[];     
%                     for p=1:length(NN)
%                     FN  = [FN, NN(sortIndex(p))];
%                     end
%                
%      R= [];        
%     % Setting the title
%     F =num2cell(transpose(mari));
%     G =[F(:,1) F(:, 2)];
%     R  = horzcat(R, sum(cell2mat(G),2) );
%     % adding the left eye and eyebrowl 
%     G =[F(:, 3) F(:, 4) ];
%     R  = horzcat(R, sum(cell2mat(G),2) );
%     % adding the right eye and eyebrowl 
%     G =[F(:, 5) F(:, 6) ];
%     R  = horzcat(R, sum (cell2mat(G),2));
%     % adding the mouth
%     R (:,4) =cell2mat(F(:,7)) ;
%     % adding left chin jaw side
%     G =[F(:, 9) F(:, 10) ];
%     R = horzcat(R, sum (cell2mat(G),2));
%     
%    % adding the right chin jaw side
%     G =[F(:, 8) F(:, 11) ];
%     R = horzcat(R, sum (cell2mat(G),2));
%     Q = {'nose' ,'L eye' ,'R eye' ,'mouth' ,'L chin jaw ' ,'R chin jaw ' }
%     
% 
%     
%     S=  mp.sputnik_labels
%     KK= ['IQ',num2cell(sortedValues)]
%     C = [Q ; num2cell(R)];
%     C=  horzcat(C,transpose(KK));
%     C=  horzcat(C,transpose(['ID' ,num2cell(FN)]));
%     
% 
%              ylabel( 'PERCENTAGE OF ENGAGEMENT' , 'FontName' , 'courier' );
%              set(get(gca, 'YLabel' ), 'Rotation' ,90 )
%              xlabel( 'IQ' , 'FontName' , 'courier' );
%             set(gcf,'NextPlot','add');
%             axes;
%             switch o
%                     case 1
%                     h = title('DD  Participants BY IQ');
%                     case 2
%                     h = title('FXS Females BY IQ');
%                     otherwise
%                     h = title('FXS  Males BY IQ');
%                     end
%             set(gca,'Visible','off');
%             set(h,'Visible','on');     
%             gg=gcf;
%           
%       %      saveas(gg,['/Users/Gui/Eyetofacemarks/Results/COARSE-IQ-LS-' num2str(o) '.eps'] ,'epsc');
%         
%          % save the data in a file 
%          clearvars mari 
%          fid=fopen(['/Users/Gui/Eyetofacemarks/Results/COARSE-ENGAGEMENT-IQ-' num2str(o) '.csv'],'wt');
%          [rows,cols]=size(C)
%          fprintf(fid,'%s,',C{1,1:end-1})
%          fprintf(fid,'%s\n',C{1,end}) 
%          for i=2:rows
%               fprintf(fid,'%f,',C{i,1:end-1})
%               fprintf(fid,'%f\n',C{i,end})
%          end
%    
% end;


