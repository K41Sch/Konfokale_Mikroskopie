% Reads the header of the plu data
function pluHeader = readHeader(fullFilename) 

	% Check syntax.  Must have at least one input argument, the full filename. 
	if (nargin ~= 1)
		error('Usage: stHeader = Read_RAW_Header(fullFilename)');
    end 

	if (ischar(fullFilename)~=1)
		error('Requires a string filename as an argument.');
    end 
    
    % open the file for reading
    fileHandleID = fopen(fullFilename, 'r'); % permission to read
	if (fileHandleID == -1)
		error(['Error opening ', fullFilename, ' for input.']);
    end
   
    % Go to beginning of file
    fseek(fileHandleID, 0, 'bof');
    
    % Actual reading starts
    % tData - date
    pluHeader.Date = char(fread(fileHandleID, 24, 'char*1')');
%     pluHeader.Time = char(fread(fileHandleID, 108, 'char')'); % Has to be checked!
    pluHeader.Time = fread(fileHandleID, 27, 'uint'); % Has to be checked!
    
    % char - user comment
    pluHeader.Comment = char(fread(fileHandleID, 256, 'char*1')');
    % tCalibratEixos_arxiu - X&Y axes config
    pluHeader.XYaxesConf.N = fread(fileHandleID, 1, 'int'); % ? 1 or 4 bytes? since int is 4
    pluHeader.XYaxesConf.M = fread(fileHandleID, 1, 'int'); % ? 1 or 4 bytes? since int is 4
    pluHeader.XYaxesConf.N_tall = fread(fileHandleID, 1, 'int'); % ? 1 or 4 bytes? since int is 4
   
    pluHeader.XYaxesConf.dy_multip = fread(fileHandleID, 1, 'float'); % ? 1 or 4 bytes? since float is 4
    pluHeader.XYaxesConf.mppx = fread(fileHandleID, 1, 'float');
    pluHeader.XYaxesConf.mppy = fread(fileHandleID, 1, 'float');
    pluHeader.XYaxesConf.x0 = fread(fileHandleID, 1, 'float');
    pluHeader.XYaxesConf.y0 = fread(fileHandleID, 1, 'float');
    pluHeader.XYaxesConf.mpp_tall = fread(fileHandleID, 1, 'float');
    pluHeader.XYaxesConf.z0 = fread(fileHandleID, 1, 'float');
    % tConfigMesura
    pluHeader.AcquisitionConfig.tipus = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.algor = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.metode = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.Obj = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.Area = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.N_area = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.M_area = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.N = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.M = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.na = fread(fileHandleID, 1, 'int');
    
    pluHeader.AcquisitionConfig.incr_z = fread(fileHandleID, 1, 'double');
    pluHeader.AcquisitionConfig.rang = fread(fileHandleID, 1, 'float');
    pluHeader.AcquisitionConfig.n_plans = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.tpc_umbral_F = fread(fileHandleID, 1, 'int');
    pluHeader.AcquisitionConfig.restore = fread(fileHandleID, 1, 'int8'); % eigentlich bool
    pluHeader.AcquisitionConfig.num_layers = fread(fileHandleID, 1, 'char');
    pluHeader.AcquisitionConfig.version = fread(fileHandleID, 1, 'char');
    pluHeader.AcquisitionConfig.config_hardware= fread(fileHandleID, 1, 'char');
    pluHeader.AcquisitionConfig.stack_im_num = fread(fileHandleID, 1, 'char');
    pluHeader.AcquisitionConfig.reserve = fread(fileHandleID, 1, 'char');
    pluHeader.AcquisitionConfig.factor_delmacio = fread(fileHandleID, 1, 'int');
    
    % SUM 500 byte
    pluHeader.Size = 500;
    
    % Close the file.
	fclose(fileHandleID);	
    
end
