using ProgressMeter

function main()
    out_dir="result"
    PARAMDAT="themal_para_D.json"

    xmax,ymax,nodes,vecAx,vecAy=read_allgrid()
    nt,dt,init_T,lam1,rho1,c1,bdcon,every_outnum,out_file_front,out_ext,restart_file,restart_num=input_para(PARAMDAT)

    Qbase,cellxmax,cellymax = set_initQbase(xmax,ymax,restart_file,init_Tout_file_front,out_ext,out_dir)

    #throw(UndefVarError(:x))

    # main loop
    prog = Progress(nt,1)
    for k in 1:nt
        next!(prog)

        Qbase = set_boundary(Qbase,cellxmax,cellymax,vecAx,vecAy,bdcon)
        Qbase_hat = setup_Qbase_hat(Qbase,volume)

        # initial_setup
        volume = set_volume(nodes,cellxmax,cellymax)
        D = lam1/(c1*rho1)

        # RHS
        E_hat, F_hat = central_diff(Qbase,cellxmax,cellymax,D,vecAx,vecAy,volume)
        RHS = setup_RHS(cellxmax,cellymax,E_hat, F_hat)
        
        # Time step
        Qbase_hat = time_integration_explicit(dt,Qbase_hat,RHS,cellxmax,cellymax)

        Qbase = Qhat_to_Q(Qbase_hat,volume)

        evalnum=k+restart_num
        println("nt : "*string(round(evalnum)))
        println("density res:"*string(norm2[1]) * "  energy res:"*string(norm2[4]))

        if round(evalnum) % every_outnum == 0
            output_result(evalnum,Qbase,specific_heat_ratio,out_file_front,out_ext,out_dir)
        end
        
        if Qbase[size(Qbase)[1],size(Qbase)[2]] < 0
            println("pressure are minus !!")
            break
        end
    end
end

# -- main --
main()