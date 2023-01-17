function clipped_layer = clipnan(layer,ub,lb)
    layer(layer>ub) = NaN;
    layer(layer<lb) = NaN;
    clipped_layer=layer;
end