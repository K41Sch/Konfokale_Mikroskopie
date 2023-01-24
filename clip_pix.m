function clipped_image = clip_pix(image,threshold)
%CLIP_PIX clips the intensity value at threshold of the max intensity value
[layers, height, width]=size(image);
clipped_image=zeros(layers,width,height);

for h=1:height
    for w=1:width
        max_int = max(image,[],1);
        image(image(:,h,w)<threshold*max_int)=nan;
        clipped_image(:,h,w)=fillmissing(image(:,h,w),'linear');
    end
end

end