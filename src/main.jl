using ProgressMeter


function main()
    out_dir="result"
    PARAMDAT="themal_para_D.json"

    xmax,ymax,nodes,vecAx,vecAy=read_allgrid()
    nt,dt,init_T,lam1,rho1,c1,bdcon,every_outnum,out_file_front,out_ext,restart_file,restart_num=input_para(PARAMDAT)

    Qbase,cellxmax,cellymax,restart_num = set_initQbase(xmax,ymax,nodes,restart_file,init_T,out_file_front,out_ext,out_dir,restart_num)

    #throw(UndefVarError(:x))

    # main loop
    println("threads num ")
    println(Threads.nthreads())
    
    prog = Progress(nt,1)
    for k in 1:nt
        next!(prog)

        # initial_setup
        volume = set_volume(nodes,cellxmax,cellymax)
        D = lam1/(c1*rho1)
        
        Qbase = set_boundary(Qbase,cellxmax,cellymax,vecAx,vecAy,bdcon)
        Qbase_hat = setup_Qbase_hat(Qbase,cellxmax,cellymax,volume)

        #println(Qbase[1,:])
        #println(Qbase_hat[2,:])

        # RHS
        E_hat, F_hat = central_diff(Qbase,cellxmax,cellymax,D,vecAx,vecAy,volume)
        #println(E_hat[2,2])
        #println(F_hat[2,2])
        RHS = setup_RHS(cellxmax,cellymax,E_hat, F_hat)
        #println(RHS[2,:])
        
        # Time step
        Qbase_hat = time_integration_explicit(dt,Qbase_hat,RHS,cellxmax,cellymax)
        #println(Qbase_hat[2,:])

        Qbase = Qhat_to_Q(Qbase_hat,cellxmax,cellymax,volume)

        evalnum=k+restart_num
        #println("nt : "*string(round(evalnum)))

        if round(evalnum) % every_outnum == 0
            output_result(evalnum,nodes,Qbase,cellxmax,cellymax,out_file_front,out_ext,out_dir)
        end
        
        if Qbase[2,2] < 0
            println("temp are minus !!")
            break
        end
    end
end

# -- main --
main()