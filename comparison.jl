f(x) = sin(x[1] + x[2]) + cos(x[1])^2
f(x1,x2) = f([x1;x2])
g(x) = [cos(x[1] + x[2]) - 2*cos(x[1])*sin(x[1]); cos(x[1] + x[2])]

xlims = (0.5, 7.5)
ylims = (-4, 3)

sala = gd_sala(g, 10^-1, chute=[3.;-0.5])
momentum = classical_momentum_gd(g, 10^-2, 0.9, chute=[3.;-0.5])
nesterov = Nesterov_gd(g, 10^-2, 0.9, chute=[3.;-0.5])
adagrad = AdaGrad(g, 10^-1, chute=[3.;-0.5])
rmsprop = RMSprop(g, 10^-1, 0.9, chute=[3.;-0.5])
adamGD = ADAM(g, 0.5, 0.999, chute=[3.;-0.5])

create_multi_anim(
    f, 
    [sala,momentum,nesterov,adagrad,rmsprop,adamGD], 
    labels = ["sala", "momentum", "nesterov", "adagrad", "rmsprop", "adam"], 
    xlims, 
    ylims, 
    "comparison.gif")
# ------------------------------------------------ X ----------------------------------------- #


#Three-hump camel function
thc(x) = 2*x[1]^2 - 1.05*x[1]^4 + x[1]^6/6 + x[1]*x[2] + x[2]^2 
thc(x1,x2) = thc([x1;x2])
thc_gradient(x) = [4*x[1] - 4.2*x[1]^3 + x[1]^5 + x[2] ; x[1] + 2*x[2]]


xlimsTHC = (-1.5, 1.5)
ylimsTHC = (-1.5,1.5)


salaTHC = gd_sala(thc_gradient, 10^-1, chute=[0.7;1.5])
momentumTHC = classical_momentum_gd(thc_gradient, 10^-2, 0.9, chute=[0.7;1.5])
nesterovTHC = Nesterov_gd(thc_gradient, 10^-2, 0.9, chute=[0.7;1.5])
adagradTHC = AdaGrad(thc_gradient, 10^-1, chute=[0.7;1.5])
rmspropTHC = RMSprop(thc_gradient, 10^-1, 0.9, chute=[0.7;1.5])
adamTHC = ADAM(thc_gradient, 0.5, 0.999, chute=[0.7;1.5])
create_multi_anim(
    f, 
    [salaTHC,momentumTHC,nesterovTHC,adagradTHC,rmspropTHC,adamTHC],
    labels = ["sala", "momentum", "nesterov", "adagrad", "rmsprop", "adam"], 
    xlimsTHC, 
    ylimsTHC, 
    "comparison2.gif"
)


# ------------------------------------------------ X ----------------------------------------- #

function ackley2d(x)
    return -20*exp(-0.2* sqrt(0.5*(x[1]^2 + x[2]^2))) - exp(0.5*(cos(2*π*x[1]) + cos(2*π*x[2]))) + ℯ + 20
end
ackley2d(x1,x2) = ackley2d([x1;x2])


function derivative_ackley2d(x)
    squared = sqrt(0.5*(x[1]^2 + x[2]^2))
    exp1 = exp(-0.2*squared)
    
    exp2 = exp(0.5(cos(2*π*x[1]) + cos(2*π*x[2])))

    return [2*x[1]*exp1/squared + exp2*π*sin(2*π*x[1])   ;   2*x[2]*exp1/squared + exp2*π*sin(2*π*x[2])]                                                            
end

salaAckley = gd_sala(derivative_ackley2d, 2.5*10^-2, chute=[0.5;1.2])
momentumAckley = classical_momentum_gd(derivative_ackley2d, 10^-2, 0.9, chute=[0.5;1.2])
nesterovAckley = Nesterov_gd(derivative_ackley2d, 10^-2, 0.9, chute=[0.5;1.5])
adagradAckley = AdaGrad(derivative_ackley2d, 5*10^-2, chute=[0.5;1.2])
rmspropAckley = RMSprop(derivative_ackley2d, 10^-1, 0.9, chute=[0.5;1.2])
adamAckley = ADAM(derivative_ackley2d, 5*10^-2, 0.999, chute=[0.5;1.2])



xlimsAckley = (-2.5, 2.5)
ylimsAckley = (-2.5,2.5)

create_multi_anim(
    ackley2d, 
    [salaAckley,momentumAckley,nesterovAckley,adagradAckley,rmspropAckley,adamAckley],
    labels = ["sala", "momentum", "nesterov", "adagrad", "rmsprop", "adam"], 
    xlimsAckley, 
    ylimsAckley, 
    "comparison3.gif"
)