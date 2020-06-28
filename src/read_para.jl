import JSON

function make_json(PARAMDAT)
    fff=[]
    open(PARAMDAT, "r") do f
        fff=read(f,String)
    end

    fff=replace(fff,r"#(.+)\n" => "\n")
    
    read_PARAMDAT="read_"*PARAMDAT
    open(read_PARAMDAT, "w") do f
        write(f,fff)
    end
    return read_PARAMDAT
end 

function read_json(read_PARAMDAT)
    dict=1
    open(read_PARAMDAT, "r") do f
        dicttxt = read(f,String)  # file information to string
        dict=JSON.parse(dicttxt)  # parse and transform data
    end
    return dict
end

function read_para(dict)
    # 出力情報
    every_outnum=Int(parse(Float64,dict["every_outnum"]))      # 出力毎タイムステップ
    out_file_front=dict["out_file_front"]
    out_ext=dict["out_ext"]

    # リスタート
    restart_file = dict["Restart"]
    restart_num  = dict["restartnum"]
    restart_ext  = dict["in_ext"]
    restart_file = restart_file*restart_num*restart_ext
    restart_num  = Int(parse(Float64,restart_num))

    # -- time step --
    nt=Int(parse(Float64,dict["nt"]))                    # 時間ステップ数
    dt=parse(Float64,dict["dt"])                    # 時間刻み幅

    # 物性値
    lam1 = parse(Float64,dict["lam1"])
    rho1 = parse(Float64,dict["rho1"])
    c1 = parse(Float64,dict["c1"])
    
    # 初期値
    init_T=parse(Float64,dict["init_val"])

    # 境界条件
    #= 
    bdcon[i][j]
    i:境界条件番号(1,2,3..)
    j=1:境界条件番号（0or1）
    j=2:rho
    j=3:u
    j=4:v
    j=5:p
    =#
    bdcon = Any[]
    k=1
    while true
        try
            bd=[parse(Int,dict["bd"*string(k)*"_con"]),parse(Float64,dict["bd"*string(k)*"_val"])]
            push!(bdcon,bd)
        catch
            break
        end
        k+=1
    end
    
    return nt,dt,init_T,lam1,rho1,c1,bdcon,every_outnum,out_file_front,out_ext,restart_file,restart_num
end

function input_para(PARAMDAT)
   read_PARAMDAT=make_json(PARAMDAT)
   dict=read_json(read_PARAMDAT)
   nt,dt,init_T,lam1,rho1,c1,bdcon,every_outnum,out_file_front,out_ext,restart_file,restart_num=read_para(dict)
   println("fin read para")
   return nt,dt,init_T,lam1,rho1,c1,bdcon,every_outnum,out_file_front,out_ext,restart_file,restart_num
end