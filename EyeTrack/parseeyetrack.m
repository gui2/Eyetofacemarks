function [ret] = parseeyetrack(name,globalData);
ret = globalData;
load 'mapping.mat';
found = false; 
for  i=1:length(wwd)
    if( strcmp(name,wwd{i,2}))
    disp (name);
    found = true;
    break;
    end;
end

if found ==false
     fprintf ( 'file %s  not found', name);
     return;
end;

path = [wwd{i,3} '/'  wwd{i,1} ];

fname = path; %'data/Rec 01-All-Data.tsv';

%% constants
video_fps = 25;
detector_fps = 60;
mspf = 1000/video_fps;


 inputs = repmat('%s',1,42);
 [Timestamp	DateTimeStamp	DateTimeStampStartOffset	Number	GazePointXLeft	...
  GazePointYLeft	CamXLeft	CamYLeft	DistanceLeft	PupilLeft	ValidityLeft	...
  GazePointXRight	GazePointYRight	CamXRight	CamYRight	DistanceRight	PupilRight	...
  ValidityRight	FixationIndex	GazePointX	GazePointY	Event	EventKey	Data1	Data2	...
  Descriptor	StimuliName	StimuliID	MediaWidth	MediaHeight	MediaPosX	MediaPosY	...
  MappedFixationPointX	MappedFixationPointY	FixationDuration	AoiIds	AoiNames	...
  WebGroupImage	MappedGazeDataPointX	MappedGazeDataPointY	MicroSecondTimestamp	...
  AbsoluteMicroSecondTimestamp]	= ...     
  textread(fname,inputs,'delimiter','\t','emptyvalue',NaN,'headerlines',23);

%% convert

% % first get rid of empty cells
emptiesX = cellfun(@isempty,GazePointX);
emptiesY = cellfun(@isempty,GazePointY);
GazePointX(emptiesX) = repmat({'0'},sum(emptiesX),1);
GazePointY(emptiesY) = repmat({'0'},sum(emptiesY),1);


% convert from strings to numbers
data = [cellfun(@str2num,GazePointX) cellfun(@str2num,GazePointY)];

% start timestamps at 1
t = cellfun(@str2num,Timestamp);
t = t - t(1) + 1;

% clip to bounding box of screen (from datafile header?)
data(data(:,1) < 1 | data(:,1) > 720,:) = NaN;
data(data(:,2) < 1 | data(:,1) > 576,:) = NaN;

% keep only the useful variables 


position =1;
 for d=1:length(globalData(:,200));
    % lastpos =1;
    bigday = 100000000000000;
    change = false; 
     A =globalData(d,200) ;
 for p=position:length(MicroSecondTimestamp);
     B =str2num(MicroSecondTimestamp{p,1});
     % check that the eyetracker did not skip make a mistake
     if (isempty(B))
              continue;
     end;
    
     % if the new distance is smaller than the previous one => update.
        bignumber = abs(A-B);
     if (bigday >bignumber )
        bigday = bignumber ;
        T =B;
        position =  p ;
        change = true;
    end;

     if( change == false )
        break;
    end;
      change = false;
    end;
    %keyboard
    fprintf( 'Mapped:  %d %d   %d  %d  \n',d,  A ,  T, position);
    ret (d,202) = str2num( GazePointX{position,1});
    ret (d,203) = str2num( GazePointY{position,1});
end;
%keyboard;
 %clear all; 
 %clearvars -except 'GazePointX' 'GazePointY' 'MicroSecondTimestamp' 'globalData'



