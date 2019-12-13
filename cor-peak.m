
more off; %To make the lines display when they appear in the script, not at the end of it.

clear; %Just in case there is some data in memory.

tic; %Total time of the script.

peak_vector = [];
valley_vector = [];
time_frames = 0;
round = 2;


um = 60; #µm/px (Cordin calibration for this MALENA experiment only)

mm = um*1e-3; #mm/px

main_folder = pwd;

addpath(main_folder);#to add the path to some functions stored in the main folder.

carpetas_disp = readdir('./'); #Read all files and folders on the main folder.



idx =   strncmpi(carpetas_disp,'ALEX',4); %Find the strings in the cell array that have ALEX in the first 4 positions. ALEX shots folders

ALEX_carpetas = char(carpetas_disp{idx,1}); %Transform the strings into adequate char strings. Or whatever. Here is a list with the ALEX shots folders.



for i=1:rows(ALEX_carpetas) %In every folder with CORDIN data
	 disp(ALEX_carpetas(i,:))
	 files = readdir(ALEX_carpetas(i,:)); %List all files and folders, incuding "." and ".."
	 idx = strncmpi(files,'Fram',4); %Index of files that start with "Fram"
	 frames = char(files{idx,1}); %List of data files (They all start with "Fram").
	 
	 for j=1:rows(frames) %For each frame file:
		  id_num = regexp(frames(j,:),'\d'); %The frame number and position (up/down) indexes.
		  frame = frames(j,id_num(1:3)); %Frame number in the shot
		  %posi = frames(j, id_num(4:5)); %Position of the data (01, up; 02 , down)
		  if  isempty(regexp(frames(j,:),'peaks')) %peaks 1 when there are peaks, and 0 if valleys
			peaks = 0;
		  else
			peaks = 1;
		  endif;
		  data_file = horzcat(ALEX_carpetas(i,:),'/',strtrim(frames(j,:))); %transform the frame file with the addition of the folder to open it as a fiel to read.
		  [data, foo] = textread(data_file, "%f %f"); %Use the first column, the horizontal positions of peaks and valleys.
		  length = diff(sort(data))'; %Distance between consecutive features(peak or valley)
		  length = length(~isnan(length)); %Removing NaN values, that could appear in files with more than one final line...
		  
		  switch(frame) %Selecting the diverse frames to store the data
			case '014' %Frame 014...
				if (peaks==1)
				  peak_vector = [peak_vector, length];
				  time_frames = time_frames + 1;
				  if (time_frames == 2) %Saving file time!
				    file_peak = horzcat(ALEX_carpetas(i,5:7),'_',frame,'_','peaks.txt');
				    fdisp(fopen(file_peak,'w'),peak_vector');
				    fclose(file_peak);
				    time_frames = 0;
				    peak_vector = [];
				  endif;
				else
				  valley_vector = [valley_vector, length];
				  time_frames = time_frames + 1;
				  if (time_frames == 2) %Saving file time!
				    file_valley = horzcat(ALEX_carpetas(i,5:7),'_',frame,'_','valleys.txt');
				    fdisp(fopen(file_valley,'w'),valley_vector');
				    fclose(file_valley);
				    time_frames = 0;
				    valley_vector = [];
				  endif;
				endif;
			case '015' %Frame 015
				if (peaks==1)
				  peak_vector = [peak_vector, length];
				  time_frames = time_frames + 1;
				  if (time_frames == 2) %Saving file time!
				    file_peak = horzcat(ALEX_carpetas(i,5:7),'_',frame,'_','peaks.txt');
				    fdisp(fopen(file_peak,'w'),peak_vector');
				    fclose(file_peak);
				    time_frames = 0;
				    peak_vector = [];
				  endif;
				else
				  valley_vector = [valley_vector, length];
				  time_frames = time_frames + 1;
				  if (time_frames == 2) %Saving file time!
				    file_valley = horzcat(ALEX_carpetas(i,5:7),'_',frame,'_','valleys.txt');
				    fdisp(fopen(file_valley,'w'),valley_vector');
				    fclose(file_valley);
				    time_frames = 0;
				    valley_vector = [];
				  endif;
				endif;
			case '016' %Frame 016
				if (peaks==1)
				  peak_vector = [peak_vector, length];
				  time_frames = time_frames + 1;
				  if (time_frames == 2) %Saving file time!
				    file_peak = horzcat(ALEX_carpetas(i,5:7),'_',frame,'_','peaks.txt');
				    fdisp(fopen(file_peak,'w'),peak_vector');
				    fclose(file_peak);
				    time_frames = 0;
				    peak_vector = [];
				  endif;
				else
				  valley_vector = [valley_vector, length];
				  time_frames = time_frames + 1;
				  if (time_frames == 2) %Saving file time!
				    file_valley = horzcat(ALEX_carpetas(i,5:7),'_',frame,'_','valleys.txt');
				    fdisp(fopen(file_valley,'w'),valley_vector');
				    fclose(file_valley);
				    time_frames = 0;
				    valley_vector = [];
				  endif;
				endif;
			otherwise
				printf('No frame 14 to 16 case...')
		  endswitch;
			
		  
	 endfor;
	 
endfor;

toc;
