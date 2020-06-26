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
    if bdcon[1,1] == 0
        for j in 1:cellymax
            Qbase[1,j] = bdcon[1,2]
        end
    elseif bdcon[1,1] == 1
        for j in 1:cellymax
            Qbase[1,j] = Qbase[2,j]
        end
    end

    # bd2 = x+
    if bdcon[2,1] == 0
        for j in 1:cellymax
            Qbase[cellxmax,j] = bdcon[2,2]
        end
    elseif bdcon[2,1] == 1
        for j in 1:cellymax
            Qbase[cellxmax,j] = Qbase[cellxmax-1,j]
        end
    end

    # bd3 = y-
    if bdcon[3,1] == 0
        for i in 1:cellxmax
            Qbase[i,1] = bdcon[3,2]
        end
    elseif bdcon[3,1] == 1
        for i in 1:cellxmax
            Qbase[i,1] = Qbase[i,2]
        end
    end

    # bd4 = y+
    if bdcon[4,1] == 0
        for i in 1:cellxmax
            Qbase[i,cellymax] = bdcon[4,2]
        end
    elseif bdcon[4,1] == 1
        for i in 1:cellxmax
            Qbase[i,cellymax] = Qbase[i,cellxmax-1]
        end
    end

    return Qbase
end