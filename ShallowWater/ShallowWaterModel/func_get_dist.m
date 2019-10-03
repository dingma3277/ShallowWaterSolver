function dist_map = func_get_dist(grid_id)

global NNN

    resolution = 180/NNN;
    halo = floor(3/resolution);

    dist_map2 = 3/resolution*ones([2*NNN+2*halo NNN+2*halo]);
    y_tmp = ceil(grid_id/2/NNN);
    x_tmp = grid_id - 2*NNN*(ceil(grid_id/2/NNN)-1);
    
    %dist_local = zeros([2*halo+1 2*halo+1]);
    
    
    [dist_local_x,dist_local_y] = meshgrid(1:(2*halo+1),1:(2*halo+1));
    dist_local_x = dist_local_x - dist_local_x(halo+1,halo+1);
    dist_local_y = dist_local_y - dist_local_y(halo+1,halo+1);
    dist_local = (dist_local_x.^2 + dist_local_y.^2).^.5;
    
    dist_local2 = dist_map2(x_tmp:x_tmp+2*halo,y_tmp:y_tmp+2*halo);
    
    dist_local2(find(dist_local<dist_local2)) = ...
        dist_local(find(dist_local<dist_local2));
    
    dist_map2(x_tmp:x_tmp+2*halo,y_tmp:y_tmp+2*halo) = dist_local2;
    
    if x_tmp == 1
        dist_map2(1+2*NNN:halo+2*NNN,1+halo:NNN+halo) = ...
            dist_map2(1:halo,1+halo:NNN+halo);
    end
    if x_tmp == 2*NNN
        dist_map2(1+halo:2*halo,1+halo:NNN+halo) = ...
            dist_map2(1+halo+2*NNN:2*halo+2*NNN,1+halo:NNN+halo);
    end
    if y_tmp == 1
        dist_map2(1+halo:2*NNN+halo,1+NNN:halo+NNN) = ...
            dist_map2(1+halo:2*NNN+halo,1:halo);
    end
    if y_tmp == NNN
        dist_map2(1+halo:2*NNN+halo,1+halo:2*halo) = ...
            dist_map2(1+halo:2*NNN+halo,1+halo+NNN:2*halo+NNN);
    end
    
    dist_map = 3/resolution*ones([2*NNN NNN]);
    dist_map = dist_map2(halo+1:halo+2*NNN,halo+1:halo+NNN);