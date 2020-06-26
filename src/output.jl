function output_restart(stepnum,cellxmax,cellymax,Qbase,specific_heat_ratio,out_file_front,out_ext,out_dir)
    
    stepnum=string(stepnum)
    while length(stepnum) < 6
        stepnum="0"*stepnum
    end
    
    fff=out_dir*"/"*out_file_front*stepnum*out_ext
    open(fff,"w") do f
        write(f,"result:x,y,rho[kg/m^3], u[m/s], v[m/s], p[Pa], T[K]\n")
        for i in 1:cellxmax
            for j in 1:cellymax
                T=Qbase[i,j,4]*specific_heat_ratio/Qbase[i,j,1]
                write(f,string(i)*" "*string(j)*" "*string(Qbase[i,j,1])*" "*string(Qbase[i,j,2])*" "*string(Qbase[i,j,3])*" "*string(Qbase[i,j,4])*" "*string(T)*"\n")
            end
        end
    end
    println("write "*fff)
end

function output_result(stepnum,cellxmax,cellymax,nodes,Qbase,specific_heat_ratio,out_file_front,out_ext,out_dir)
    
    stepnum=string(stepnum)
    while length(stepnum) < 6
        stepnum="0"*stepnum
    end
    
    fff=out_dir*"/"*out_file_front*stepnum*out_ext
    open(fff,"w") do f
        write(f,"result:x,y,rho[kg/m^3], u[m/s], v[m/s], p[Pa], T[K]\n")
        for i in 2:cellxmax-1
            for j in 2:cellymax-1
                T = Qbase[i,j,4]*specific_heat_ratio/Qbase[i,j,1]
                x = nodes[i+1,j+1,1]+nodes[i+1,j,1]+nodes[i,j+1,1]+nodes[i,j,1]
                y = nodes[i+1,j+1,2]+nodes[i+1,j,2]+nodes[i,j+1,2]+nodes[i,j,2]
                write(f,string(x)*" "*string(y)*" "*string(Qbase[i,j,1])*" "*string(Qbase[i,j,2])*" "*string(Qbase[i,j,3])*" "*string(Qbase[i,j,4])*" "*string(T)*"\n")
            end
        end
    end
    println("write "*fff)
end
