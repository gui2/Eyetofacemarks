clear all;
close all;
addpath  mmread

directoryin='/Users/Gui/Images/FXS_TRACK/';

ims = getAllFiles(directoryin);
q=1;
firstrun = true  ;  


for i = 1:length(ims), % for each video 
          p= char(ims(i,1));
          [pathstr, name, ext] = fileparts(p);
          full=[name ext];
       
        if  firstrun == true
          prevpath = pathstr;
          firstrun = false;
          m=1;
       end; 
         
       if  (~strcmp(pathstr, prevpath))
         prevpath =pathstr ;
         q =q+1;
         m =1;
      end; 
      
      %Remove the files that I dont want%%%%%%%%%%%%%%
          if(strcmp( '.DS_Store',ext))
             continue;
         end;
         
         %Remove the files that I dont want%%%%%%%%%%%%%%
          if(strcmp( '.mp3',ext))
             continue;
         end;
         
         if(strcmp( '.tsv',ext))
            disp(full);
            wwd{q,1} = full ;
         end;

           if(strcmp( '.avi',ext))
           wwd{q,2} = full ;
         end;
         
          if(strcmp( '.avi',ext))
           wwd{q,3} =  pathstr ;
    
          idx = strfind(pathstr,'/'); % or idx = find(str=='.');
          dd= pathstr(idx(5)+1:length(pathstr));
          wwd{q,4} =  dd ;
          end;
         m =m+1;
end;
save ('mapping.map');


