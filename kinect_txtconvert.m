%% Config
subject_ID = 'Pilot3_louis'

% Import .txt generated from Xefextract function 
opts = detectImportOptions(strcat('D:\SmartRehab\Data_Video\', subject_ID, '\KinectV2_Skeleton.txt');
kps = readtable(strcat('D:\SmartRehab\Data_Video\', subject_ID, '\KinectV2_Skeleton.txt'),opts);

clear opts

% Rearrange table and scale to image size (512 * 424 for depth camera)
time = kps.Time *0.0000001;                    % convert back to seconds
head = [kps.PositionX_3 *512, kps.PositionY_3 *424];  
right_shoulder = [kps.PositionX_8 *512, kps.PositionY_8 *424];
left_shoulder = [kps.PositionX_4 *512, kps.PositionY_4 *424];
right_elbow = [kps.PositionX_9 *512, kps.PositionY_9 *424];
left_elbow = [kps.PositionX_5 *512, kps.PositionY_5 *424];
right_wrist = [kps.PositionX_10 *512, kps.PositionY_10 *424];
left_wrist = [kps.PositionX_6 *512, kps.PositionY_6 *424];
right_hip = [kps.PositionX_16 *512, kps.PositionY_16 *424];
left_hip = [kps.PositionX_12 *512, kps.PositionY_12 *424];
right_knee = [kps.PositionX_17 *512, kps.PositionY_17 *424];
left_knee = [kps.PositionX_13 *512, kps.PositionY_13 *424];
right_ankle = [kps.PositionX_18 *512, kps.PositionY_18 *424];
left_ankle = [kps.PositionX_14 *512, kps.PositionY_14 *424];

keypts_M = [time head right_shoulder left_shoulder right_elbow left_elbow ...
    right_wrist left_wrist right_hip left_hip right_knee left_knee ... 
    right_ankle left_ankle];

keypts_cell = num2cell(keypts_M);

keypts_title = {'time' 'head_x'	'head_y' 'right_shoulder_x'...
   'right_shoulder_y' 'left_shoulder_x' 'left_shoulder_y'	'right_elbow_x'...
   'right_elbow_y'	'left_elbow_x'	'left_elbow_y'	'right_wrist_x'...
   'right_wrist_y'	'left_wrist_x'	'left_wrist_y'	'right_hip_x'...
   'right_hip_y'	'left_hip_x'	'left_hip_y'	'right_knee_x'...
   'right_knee_y'	'left_knee_x'	'left_knee_y'	'right_ankle_x'...
   'right_ankle_y'	'left_ankle_x'	'left_ankle_y'};

keypts_final = vertcat(keypts_title, keypts_cell);

filename = 'kinect_kps.xlsx';
writecell(keypts_final,filename)

%  tbl = table([time head right_shoulder left_shoulder right_elbow left_elbow ...
%      right_wrist left_wrist right_hip left_hip right_knee left_knee ... 
%      right_ankle left_ankle]);

%  tbl.Properties.VariableNames = {'time' 'head_x'	'head_y' 'right_shoulder_x'...
%     'right_shoulder_y' 'left_shoulder_x' 'left_shoulder_y'	'right_elbow_x'...
%     'right_elbow_y'	'left_elbow_x'	'left_elbow_y'	'right_wrist_x'...
%     'right_wrist_y'	'left_wrist_x'	'left_wrist_y'	'right_hip_x'...
%     'right_hip_y'	'left_hip_x'	'left_hip_y'	'right_knee_x'...
%     'right_knee_y'	'left_knee_x'	'left_knee_y'	'right_ankle_x'...
%     'right_ankle_y'	'left_ankle_x'	'left_ankle_y'};


%% Visualize skeleton

kps_x = keypts_M(:,2:2:27);  %grab x locations for the 13 keypts
kps_y = keypts_M(:,3:2:27);  %grab y locations for the 13 keypts

figure(1)
scatterplot(kps_x, kps_y)