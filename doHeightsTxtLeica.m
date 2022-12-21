%% File to create a txt-file for setting up coordinates for a confocal measurement with LeicaSCAN6.3
% coordinates are set up from which confocal measurements are taken
% !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%
% Please do check the values in the txt-file before starting a measurement, 
% to prevent the objective to get damaged!

function [x_coordinate, y_coordinate,z_coordinate_max, z_coordinate_min, sizeplanes] = doHeightsTxtLeica (filename_heights)

%% Initializing coordinates
x_coordinate = input('Please enter the value for the x_coordinate in [mm]:');
% x_coordinate = 5.6009;                                                      %x-Koordinate/ Größe ist in [mm]
y_coordinate = input('Please enter the value for the y_coordinate in [mm]:');
% y_coordinate = -4.9158;                                                     %y-Koordinate/ Größe ist in [mm]
z_coordinate_max = input('Please enter the maximum value for the z_coordinate in [mm]:');
% z_coordinate_max = -23.5918;                                                %größte z-Koordinate/ Größe ist in [mm]
z_coordinate_min = input('Please enter the minimum value for the z_coordinate in [mm]:');
% z_coordinate_min = -24.3236;                                                %kleinste z-Koordinate/ Größe ist in [mm}
sizeplanes = input('Please enter number of z-planes:');
% sizeplanes = 61;
positions = zeros (3, sizeplanes);
                                                                        
%% Positionen hinterlegen

planesdifference = (sizeplanes-1)\(z_coordinate_max-z_coordinate_min);      %Höhenunterschied zwischen den einzelnen Ebenen
                                                                            %numerische Division um Fehler durchNullstellen zu vermeiden
for current_plane=1:sizeplanes  
    
    z_coordinate_current=z_coordinate_max-(current_plane-1)*planesdifference;% aktuelle z-Koordinate bestimmen
    
    positions(1,current_plane) = x_coordinate;                              % x-Koordinate einlesen
    positions(2,current_plane) = y_coordinate;                              % y-Koordinate einlesen
    positions(3,current_plane) = z_coordinate_current;                      % z-Koordinate einlesen
    
end

%% in Textfile einlesen und Textfile erzeugen

FileID = fopen(strcat(filename_heights, '.txt'),'w');                         % gewünschte Textdatei öffnen
fprintf (FileID,'%1s\r\n','[References]');                                    % gewünschte Textdatei schreiben
fprintf (FileID,'%1s\r\n','[Measures]');                                      
fprintf(FileID,'%7.4f %7.4f %7.4f\r\n',positions);                            % Erstellt die gewünschten Koordinaten

fclose(FileID);

