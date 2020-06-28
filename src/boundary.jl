function set_boundary(Qbase,cellxmax,cellymax,vecAx,vecAy,bdcon)
    """bdcon[i][j]
        i : 境界番号(x-,x+ ,y-,y+)
        j=1-6 : "bd1_con":"2",
                "bd1_rho":"1.0",
                "bd1_u":"300.0",
                "bd1_v":"0.0",
                "bd1_p":"1.0",
                "bd1_T":"300.0",
    """
    
    # bd1 = x-
    if Int(bdcon[1][1]) == 0
        for j in 1:cellymax
            Qbase[1,j] = bdcon[1][2]
        end
    elseif Int(bdcon[1][1]) == 1
        for j in 1:cellymax
            Qbase[1,j] = Qbase[2,j]
        end
    else
        println("boundary error")
        println("Please check boundary condition")
        throw(UndefVarError(:x))
    end

    # bd2 = x+
    if Int(bdcon[2][1]) == 0
        for j in 1:cellymax
            Qbase[cellxmax,j] = bdcon[2][2]
        end
    elseif Int(bdcon[2][1]) == 1
        for j in 1:cellymax
            Qbase[cellxmax,j] = Qbase[cellxmax-1,j]
        end
    else
        println("boundary error")
        println("Please check boundary condition")
        throw(UndefVarError(:x))
    end

    # bd3 = y-
    if Int(bdcon[3][1]) == 0
        for i in 1:cellxmax
            Qbase[i,1] = bdcon[3][2]
        end
    elseif Int(bdcon[3][1]) == 1
        for i in 1:cellxmax
            Qbase[i,1] = Qbase[i,2]
        end
    else
        println("boundary error")
        println("Please check boundary condition")
        throw(UndefVarError(:x))
    end

    # bd4 = y+
    if Int(bdcon[4][1]) == 0
        for i in 1:cellxmax
            Qbase[i,cellymax] = bdcon[4][2]
        end
    elseif Int(bdcon[4][1]) == 1
        for i in 1:cellxmax
            Qbase[i,cellymax] = Qbase[i,cellymax-1]
        end
    else
        println("boundary error")
        println("Please check boundary condition")
        throw(UndefVarError(:x))
    end

    return Qbase
end