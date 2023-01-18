folder = 'C:\Users\Kai\Documents\KIT Dokumente\Praktikum Mechatronische Messsysteme\V1_Konfokale_Mikroskopie\Mikroskopie\cent_14_Dec_2022_11_30_44_14_Dec_2022';
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

imagesc(squeeze(COM))

%%
%LSQ
polynom = zeros(size(image_array,2),size(image_array,3),3);
for i=1:size(image_array,2)
    for j=1:size(image_array,3)       
        polynom(i,j,:) = polyfit(z,image_array(:,i,j),2);
    end
end

%% 
poly_image = zeros(size(image_array,2),size(image_array,3),3);
LSQ_height = zeros(size(image_array,2),size(image_array,3),1);
LSQ_height_vector = zeros(L,1);

for i=1:size(image_array,2)
    for j=1:size(image_array,3) 
        for k=1:L
            LSQ_height_vector(L) = polynom(i,j,3) + polynom(i,j,2)*z(k) ... 
                + polynom(i,j,1)*z(k).^2;
        end
        LSQ_height(i,j) = max(LSQ_height_vector);
    end
end

imagesc(LSQ_height)

