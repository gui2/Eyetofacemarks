clear all

%% constants
video_fps = 25;
detector_fps = 60;
mspf = 1000/video_fps;


%% read data
load 'mapping.mat'
path = [wwd{i,3} '/'  wwd{i,1}];
fname = path; %'data/Rec 01-All-Data.tsv';

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

% first get rid of empty cells
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

%% read in the face detector data

% change me depending on what detectors you want
detectors = {'face_alt','face_alt2'};%,'face_profile'}; %,'lefteye','righteye'};

clear id fx fy fw fh
for i = 1:length(detectors)
  [detector_timestamp{i} fx{i} fy{i} fw{i} fh{i}] = ...
    textread(['faces/' detectors{i} '.txt'],'%d%d%d%d%d','delimiter',',');
  
  % adjust for frame rate differences
  detector_timestamp{i} = round(detector_timestamp{i} * (detector_fps / video_fps));
end

%% plotting loop - do this for each frame

to_plot = true;
files = dir('frames/*.jpg');
files = {files.name};

cols = {[1 0 0],[0 1 0],[0 0 1],[1 1 0],[1 0 1],[0 1 1]};

for i = 1000:length(files)
  % what frame and datapoint are we at?
  frame_number = 1 + i*mspf;
  this_ts = find(t>=frame_number,1,'first'); % find appropriate timestamp in gaze data
  this_pog = data(this_ts,:);
  
  % for each detector, are we within that detector?
  for j = 1:length(detectors)
    this_dts = find(detector_timestamp{j} == i,1,'first');    
    
    % detector box
    db = [fx{j}(this_dts) fy{j}(this_dts) fw{j}(this_dts) fh{j}(this_dts)];
    ROI(i,j) = inROIsquare(this_pog,db);
    eROI(i,j) = inROIellipse(this_pog,db);
%     else
%       ROI(i,j) = NaN;
    end
    
  end

  
  % plotting loop
  if to_plot
    % basic plotting stuff
    clf
    hold on
    axis([0 720 0 576])
    axis off
    axis ij

    % read and plot image
    im = imread(['frames/' files{i}]);
    imagesc(im);
 
    % for each detector, plot the bounding box
    for j = 1:length(detectors)
     this_dts = find(detector_timestamp{j} == i,1,'first');    
     if ~isempty(this_dts)
       h = rectangle('Position',...
         [fx{j}(this_dts) fy{j}(this_dts) fw{j}(this_dts) fh{j}(this_dts)],...
         'Curvature',[1 1],...
         'EdgeColor',cols{j});
     end
    end

    % plot the eye-gaze data
    plot(this_pog(1),this_pog(2),'r.','MarkerSize',20)
  
%   saveas(gca,['output/frame' num2str(i) '.jpg'],'jpeg');
    drawnow
  end  


%% RANDOM DETECTOR AVERAGING STUFF - FIX THIS LATER
% 
% 
%     
% %     if isempty(fid)
% %       fid = find(id{j}>=i-1,1,'first');
% %     end
% %     
%     if j < 3
%       if ~isempty(fid) && fw{j}(fid) > 200
%         h = rectangle('Position',[fx{j}(fid) fy{j}(fid) fw{j}(fid) fh{j}(fid)],'EdgeColor',cols{j});
%       end
%       
%       if j == 2 & ~isempty(fid) &&  fw{j}(fid) > 200
%         % try rigid boxes
%         x = fx{2}(fid);
%         y = fy{2}(fid);
%         w = fw{2}(fid);
%         h = fh{2}(fid);
%         rectangle('Position',[x+ 30 y + 60 100 70 ],'EdgeColor',[1 1 0]);
%         rectangle('Position',[x + w - 130 y + 60 100 70],'EdgeColor',[1 1 0]);
%         rectangle('Position',[x + (w / 2) - 65 y + 175 130 75 ],'EdgeColor',[1 1 0]);
%       end
%     end
% % 
% %     elseif j >= 3
% % %       if ~isempty(fid) && fx{j}(fid) > fx{1}(fid) && fy{j}(fid) > fy{1}(fid)
% % %         h = rectangle('Position',[fx{j}(fid) fy{j}(fid) fw{j}(fid) fh{j}(fid)],'EdgeColor',[0 0 1]);
% % %       end
% %     end