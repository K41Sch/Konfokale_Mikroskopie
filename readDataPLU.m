function pluData = readDataPLU(fullFilename) 
  % open the file for reading
    fileHandleID = fopen(fullFilename, 'r'); % permission to read
	if(fileHandleID == -1) %#ok<ALIGN>
		error(['Error opening ', fullFilename, ' for input.']);
    end
    
    
    % Jump to data part of the file (header is 500 bytes)
    bytesToSkip = 500; 
    fseek(fileHandleID, bytesToSkip, 'bof');
    
   % tConfigMesura.tipus = 0 = MES_IMATGE = Confocal Image
   pluData.num_rows_N = fread(fileHandleID, 1, 'int');
   pluData.num_cols_M = fread(fileHandleID, 1, 'int');
   
   % Calculate image size in bytes
   pluData.imagesize = pluData.num_rows_N*pluData.num_cols_M*4;
   
   % Read Data
    pluData.Data_string=fread(fileHandleID,1024*1360*3, 'uint8'); % little endian, 'ieee-le'
    % According to Header Information and Email with supplement information
    % the FOV should be 256x768 -> no, but R=G=B and therefore each value
    % is save 3 times.
%     pluData.Data_string=fread(fileHandleID, pluData.num_cols_M*pluData.num_rows_N, 'float', 'ieee-le'); % little endian
    length = size(pluData.Data_string);
    
    % do imaging with r, g, b as triple value and char*1
    
    %% Version 2 

    for i=1:1024
        pluData.reshaped_charV2(i,:)= pluData.Data_string(((i*3*1360)-((1360*3)-1)):(1360*3*i));
    end
    
    % shorten image
    size_pluData.reshaped_charV2 = size(pluData.reshaped_charV2);
    pluData.image = pluData.reshaped_charV2(:,1:3:size_pluData.reshaped_charV2(1,2));    
    
% % Read the next parameter - Has to be checked!
% pluData.max = fread(fileHandleID, 1 , 'int');
% pluData.min = fread(fileHandleID, 1 , 'int');

    % Close the file.
	fclose(fileHandleID);
    
end