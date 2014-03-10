clear all;
close all;
addpath  mmread
directoryin ='/Users/Gui/Images/FXS_TRACK/INPUT/OUT';
ims = getAllFiles(directoryin);
datam = 1;
previousfile=' ';

for i = 1:length(ims), % for each video 
        
     
         % sPARSE THE  FILES COMMING FROM THE FACE DETECTION 
         % GET THE FILE NAME AND PATH 
          p= char(ims(i,1));
          [pathstr, name, ext] = fileparts(p);
          full=[name ext];

            [one, two, three] = fileparts(full);
            [one, two, three] = fileparts(two);
           
                      %check if the matrix does not already exists 
         if(exist(['Partial/' two '.mat']))
         continue;
         end;
         
          
          
         %REMOVE EVERYTHING I DONT WANT 
         if(~strcmp( '.txt',ext)) 
             continue; 
        end;

         gtfile =  fopen([pathstr '/' full],'r');

          
         %BUILD A STRUCTURE
         data (1:210)= 0; 
         
         %GET THE FIRST LINE OF THE FILE  AND EXTRACT ONLY THE FRAME NUMBER
          InputText=textscan(gtfile,'%s',7,'delimiter','  ');
          m = str2num(InputText{1,1}{1,1});
           
                   
         % KEEP ONLY FACES DETECTED AT 0 DEGREES 
         if (str2num(InputText{1,1}{7,1})~= 0);
             fclose (gtfile);
             continue;
         end;
         
          %LOOP OVER THE REST OF THE FILE AND GET THE FACE PARTS AND
          %POSITION 
          while(~feof(gtfile)); % go into the detections
                            InputText=textscan(gtfile,'%s',6,'delimiter','  ');
                             if ~strcmp(InputText{1, 1},'[]')
                            input =str2num(InputText{1,1}{1,1});
                            data(1,  (2*input)-1) = str2num(InputText{1,1}{3,1});
                            data(1,  (2*input)      )  = str2num(InputText{1,1}{6,1});
                             end;
                   end;
             
          %ADD THE PARSED STRUCTURE TO THE GLOBAL SCRUCTURE OF THE FILE. 
          % HERE EACH ROW REPRESENTS A FRAME, EACH COLUMN IS A FACE PART.
          % THE COLUMN 200 IS THE FRAME NUMBER 
                   data (1,201)=m;         
                   data (1,200) =(m /25) *1000000;     %miliseconds??
                   globalData(datam,:) = data(1,:);
                   datam =datam+1;
                   fclose (gtfile);
                   
           %VERIFY IF A NEW STRUCTURE APPEARS, WHEN IT DOES....
           % IT IS TIME TO PARSE  THE FILE OF THE EYE TRACKING. 
           % AND CLEAR ALL VARIABLES TO START AGAIN WITH A NEW FILE. 
            [pathstr, name, ext] = fileparts(full);
            [pathstr, name, ext] = fileparts(name);
           
            if  (strcmp(previousfile,' ') )
            previousfile=name;
            end;
            
            if  (~strcmp(previousfile,name)  )
                globalData = sortrows(globalData,[200]);
                ret=  parseeyetrack (previousfile, globalData );
                save (['Partial/' previousfile '.mat'],'ret'); 
                %dfs=Compute_GMM(ret,name);
                previousfile = name;
                clearvars globalData;
                datam = 1;
            end;

 end;