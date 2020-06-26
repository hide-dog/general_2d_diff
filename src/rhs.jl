function central_diff(Qbase,cellxmax,cellymax,D,vecAx,vecAy,volume)
    E_hat = zeros(cellxmax+1,cellymax)
    
    for i in 2:cellxmax+1 -1
        for j in 2:cellymax -1
            T_av = 0.5*(Qbase[i,j]+Qbase[i-1,j])
            dTdxi = (Qbase[i,j]-Qbase[i-1,j])
            dTdeta = 0.25*((Qbase[i,j+1]-Qbase[i,j-1]) + (Qbase[i-1,j+1]-Qbase[i-1,j-1]))
            
            vecAy_xav    = 0.25*( vecAy[i,j,1] + vecAy[i,j-1,1] + vecAy[i+1,j,1] + vecAy[i+1,j-1,1] )
            vecAy_yav    = 0.25*( vecAy[i,j,2] + vecAy[i,j-1,2] + vecAy[i+1,j,2] + vecAy[i+1,j-1,2] )
            
            dTdx = vecAx[i,j,1]*dTdxi + vecAy_xav*dTdeta
            dTdy = vecAx[i,j,2]*dTdxi + vecAy_yav*dTdeta

            volume_temp = 0.5*(volume[i,j]+volume[i-1,j])
            E_hat[i,j] = D*(vecAx[i,j,1]*dTdx + vecAx[i,j,2]*dTdy)/volume_temp
        end
    end

    F_hat = zeros(cellxmax,cellymax+1) 
    
    for i in 2:cellxmax -1
        for j in 2:cellymax+1 -1
			T_av = 0.5*(Qbase[i,j]+Qbase[i,j-1])
			dTdxi = 0.25*((Qbase[i+1,j]-Qbase[i-1,j]) + (Qbase[i+1,j-1]-Qbase[i-1,j-1]))
			dTdeta = (Qbase[i,j]-Qbase[i,j-1])
			
            vecAx_xav    = 0.25d0*( vecAx[i,j,1] + vecAx[i,j-1,1] + vecAx[i+1,j,1] + vecAx[i+1,j-1,1] )
            vecAx_yav    = 0.25d0*( vecAx[i,j,2] + vecAx[i,j-1,2] + vecAx[i+1,j,2] + vecAx[i+1,j-1,2] )
                    
            dTdx = vecAx_xav*dTdxi + vecAy[i,j,1]*dTdeta
            dTdy = vecAx_yav*dTdxi + vecAy[i,j,2]*dTdeta    

            volume_temp = 0.5*(volume[i,j]+volume[i,j-1])
            F_hat[i,j] = D*(vecAy[i,j,1]*dTdx + vecAy[i,j,2]*dTdy)/volume_temp
        end
    end

    return E_hat,F_hat
end

function setup_RHS(cellxmax,cellymax,E_hat, F_hat)
	RHS = zeros(cellxmax,cellymax)

	for i in 2:cellxmax-1
		for i in 2:cellymax-1
			RHS[i,j] = (E_hat[i,j]-E_hat[i+1,j]) + (F_hat[i,j]-F_hat[i,j-1])
		end
	end
	
	return RHS
end