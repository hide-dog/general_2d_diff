using Printf

function output_restart(stepnum,nodes,Qbase,cellxmax,cellymax,out_file_front,out_ext,out_dir)
    
    stepnum=string(stepnum)
    while length(stepnum) < 6
        stepnum="0"*stepnum
    end
    
    fff=out_dir*"/"*out_file_front*stepnum*out_ext
    open(fff,"w") do f
        write(f,"result:x,y,T[K]\n")
        for i in 2:cellxmax-1
            for j in 2:cellymax-1
                # x = 0.25*(nodes[i+1,j+1,1]+nodes[i+1,j,1]+nodes[i,j+1,1]+nodes[i,j,1])
                # y = 0.25*(nodes[i+1,j+1,2]+nodes[i+1,j,2]+nodes[i,j+1,2]+nodes[i,j,2])
                # write(f,string(x)*" "*string(y)*" "*string(Qbase[i,j])*"\n")
                a = @sprintf("%8.8f", Qbase[i,j])
                write(f, a*"\n")
            end
        end
    end
    println("write "*fff)
end


function output_result(stepnum,nodes,Qbase,cellxmax,cellymax,out_file_front,out_ext,out_dir)
    
    stepnum=string(stepnum)
    while length(stepnum) < 6
        stepnum="0"*stepnum
    end
    
    fff=out_dir*"/"*out_file_front*stepnum*out_ext
    open(fff,"w") do f
        write(f,"result:x,y,T[K]\n")
        for i in 2:cellxmax-1
            for j in 2:cellymax-1
                # x = 0.25*(nodes[i+1,j+1,1]+nodes[i+1,j,1]+nodes[i,j+1,1]+nodes[i,j,1])
                # y = 0.25*(nodes[i+1,j+1,2]+nodes[i+1,j,2]+nodes[i,j+1,2]+nodes[i,j,2])
                # write(f,string(x)*" "*string(y)*" "*string(Qbase[i,j])*"\n")
                a = @sprintf("%8.8f", Qbase[i,j])
                write(f, a*"\n")
            end
        end
    end
    println("\nwrite "*fff)
end
