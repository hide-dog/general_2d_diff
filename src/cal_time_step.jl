function time_integration_explicit(dt,Qbase_hat,RHS,cellxmax,cellymax)
    Threads.@threads for i in 2:cellxmax-1
        for j in 2:cellymax-1
            Qbase_hat[i,j] = Qbase_hat[i,j] + dt*RHS[i,j]
        end
    end
    return Qbase_hat
end 