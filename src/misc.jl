function set_initQbase(xmax,ymax,nodes,restart_file,init_T,out_file_front,out_ext,out_dir,restart_num)
    Qbase=[]
    cellxmax = xmax - 1
    cellymax = ymax - 1

    restart_check=0
    try Qbase=setup_restart_value(cellxmax,cellymax,out_dir,restart_file)
        println("Restart "*restart_file)
        restart_check=2
    catch 
        restart_check=1
    end

    if restart_check == 1
        Qbase=setup_init_value(cellxmax,cellymax,init_T)
        println("Start Initial condition")
        restart_num=0
        output_result(0,nodes,Qbase,cellxmax,cellymax,out_file_front,out_ext,out_dir)
    elseif restart_check == 0
        println("restart error")
        println("Please check restart file")
        throw(UndefVarError(:x))
    end

    return Qbase,cellxmax,cellymax,restart_num
end

function setup_init_value(cellxmax,cellymax,init_T)
    Qbase=zeros(cellxmax, cellymax)
    for i in 1:cellxmax
        for j in 1:cellymax
            Qbase[i,j]=init_T
        end
    end
    return Qbase
end

function setup_restart_value(cellxmax,cellymax,out_dir,restart_file)
    Qbase=zeros(cellxmax,cellymax)

    skipnum=1
    fff=[]
    open("result/"*restart_file, "r") do f
        fff=read(f,String)
    end 
    fff=split(fff,"\n",keepempty=false)
    
    for i in 1+skipnum:length(fff)
        fff[i]=replace(fff[i]," \r" => "")
    end
    
    for i in 2:cellxmax-1
        for j in 2:cellymax-1
            temp = split(fff[i+skipnum]," ")
            Qbase[i,j] = parse(Float64,temp[1]) 
        end
    end
    return Qbase
end
