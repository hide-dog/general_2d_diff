function set_volume(nodes,cellxmax,cellymax)
    volume = zeros(cellxmax,cellymax)
    Threads.@threads for i in 1:cellxmax
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

function setup_Qbase_hat(Qbase,cellxmax,cellymax,volume)
    Qbase_hat = zeros(cellxmax,cellymax)
    Threads.@threads for i in 1:cellxmax
        for j in 1:cellymax
            Qbase_hat[i,j] = Qbase[i,j] * volume[i,j]
        end
    end
    return Qbase_hat
end

function Qhat_to_Q(Qbase_hat,cellxmax,cellymax,volume)
    Qbase = zeros(cellxmax,cellymax)
    Threads.@threads for i in 1:cellxmax
        for j in 1:cellymax
            Qbase[i,j] = Qbase_hat[i,j] / volume[i,j]
        end
    end
    return Qbase
end