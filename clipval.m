function clipped_layer = clipval(layer,ub,lb)
    layer(layer>ub) = ub;
    layer(layer<lb) = lb;
    clipped_layer=layer;
end