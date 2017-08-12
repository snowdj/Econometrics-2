# computes the errors as outlined in the notes. Use these to generate
# moment conditions for estimation
function GetErrors(thetas, realdata)
        errors = zeros(size(realdata,1)-2,5)
        # break out variables
        y = realdata[:,1]
        c = realdata[:,2]
        n = realdata[:,3]
        r = realdata[:,4]
        w = realdata[:,5]
        # break out params    
        alpha = thetas[1]
        beta = thetas[2]
        delta = thetas[3]
        gam = thetas[4]
        rho_z = thetas[5]
        sig_z = thetas[6]
        rho_eta = thetas[7]
        sig_eta = thetas[8]
        nss = thetas[9]
        # recover psi
        c1 = ((1.0/beta + delta - 1.0)/alpha)^(1.0/(1.0-alpha))
        kss = nss/c1
        iss = delta*kss
        yss = kss^alpha * nss^(1-alpha)
        css = yss - iss
        psi =  (css^(-gam)) * (1-alpha) * (kss^alpha) * (nss^(-alpha))
        # use MUL-MRS
        lneta = log.(w) - gam*log.(c) -log.(psi)
        e = lneta - rho_eta*lag(lneta,1)
        e = e/sig_eta
        e = e[3:end]
        errors[:,1] = e
        # now the Euler eqn
        #cc = c ./lag(c,1)
        e = (beta*c.^(-gam).*(1 + r -delta))-lag(c,1).^(-gam)
        e = e[3:end]
        errors[:,2] = e
        # production function
        k = alpha*lag(n,1).*lag(w,1)./lag(r,1)/(1.0-alpha)
        lnz = log.(y) - alpha*log.(k) - (1.0-alpha)*log.(n)
        e = lnz - rho_z*lag(lnz,1)
        e = e[3:end]
        e = e/sig_z
        errors[:,3] = e
        # MPL
        lnz = log.(w) + alpha*(log.(n)-log.(k)) - log.(1.0-alpha)
        e = lnz - rho_z*lag(lnz,1)
        e = e[3:end]
        e = e/sig_z
        errors[:,4] = e
        # law of motion k: good for delta
        invest = y - c
        e = lag(invest,1) + (1 - delta)*lag(k,1) - k
        e = e[3:end]
        errors[:,5] = e
        return errors
end

