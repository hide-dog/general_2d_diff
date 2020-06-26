function set_volume(nodes,cellxmax,cellymax)
    volume = zeros(cellxmax,cellymax)
    for i in 1:cellxmax
        for j in 1:cellymax
            vec_r1x = nodes[i+1,j+1,1] - nodes[i,j,1]
            vec_r1y = nodes[i+1,j+1,2] - nodes[i,j,2]
            vec_r2x = nodes[i,j+1,1] - nodes[i+1,j,1]
            vec_r2y = nodes[i,j+1,2] - nodes[i+1,j,2]

            volume[i,j] = abs(vec_r1x*vec_r2y - vec_r1y*vec_r2x) /2
        end
    end
    return volume
end 
