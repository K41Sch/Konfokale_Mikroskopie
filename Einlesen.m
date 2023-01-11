folder = 'C:/Users/oj9048/Desktop/Vormittag/cent_14_Dec_2022_11_17_51_14_Dec_2022/';
files = dir(fullfile(folder,'*.plux.plu'));
L = length(files);
image_array = zeros(L,1024,1360);
z = zeros(L,1);
for i = 1:L
    [data,header] = ReadPLU(fullfile(files(i).folder,files(i).name));
    
%   image = data.image;
    image_array(i,:,:) = data.image;
    z(i,1) = header.XYaxesConf.z0;
end

%%
%max_int

max_array = max(image_array);

%%
%Center of mass
weighted_image = zeros(L,1024,1360);
for i = 1:L
    weighted_image(i,:,:) = z(i,1)*image_array(i,:,:);
end

COM = sum(weighted_image,1)./sum(image_array,1);

%%
%LSQ
polynom = zeros(size(image_array,2),size(image_array,3),3);
for i=1:size(image_array,2)
    for j=1:size(image_array,3)       
        polynom(i,j,:) = polyfit(z,image_array(:,i,j),2);
    end
end

