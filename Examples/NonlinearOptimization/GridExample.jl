using Econometrics, Plots
pyplot()
function GridExample(points, doprint=false)
    # plot the line
    x = linspace(-pi,pi/2.0,1000)
    obj = theta-> 0.5*theta*sin(theta^2.0)
    y = obj.(x)
    plot(x, y)
    # plot the grid points
    x = linspace(-pi,pi/2.0,points)
    y = obj.(x)
    scatter!(x, y)
    # plot the best point found
    scatter!([x[indmin(y)]], [y[indmin(y)]], markersize=10)
    gui()
    if doprint savefig("gridsearch.svg") end
end
