%% Reads the data from the .plu-files from the Leica DCM8
% The function needs the filename to be evaluated:
% e.g.: fullfile('Example.plux.plu')
% and returns the information of the header and the data
% 17.04.2017
% 07.11.2017 (revised)
% dut 

% Adapted after https://de.mathworks.com/matlabcentral/answers/17522-reading-binary-files-in-matlab
% Details about the header is information from LEICA

%% Read header of plu file
function [pluData, pluHeader] = ReadPLU(fullFilename)

% (If used without function:)
% fullFilename = fullfile(cd, 'P0010_ConfocalStar2.plu'); 
% fullFilename = fullfile(cd, '/plu/plu/P0016_20160930-Bert.plux.plu'); 

% Area 1 -> reads the header
pluHeader = readHeaderPLU(fullFilename);

% Area 2 -> reads the data
pluData = readDataPLU(fullFilename);

% Additional Information about file
fileInfo = dir(fullFilename);

fileSizeInBytes = fileInfo.bytes;
dataSizeInBytes = double(fileSizeInBytes)-pluHeader.Size;

end