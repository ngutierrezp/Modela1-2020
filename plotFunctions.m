%################################################
%#                  Primera Parte               #
%################################################



function [] = plotFunctions( func1, func2 , vectorX , typePlot ,titles )
    

    y1 = func1(vectorX);
    y2 = func2(vectorX);
    
    figure(1)
    
    
    plot( vectorX, y1,typePlot(1) ); 
    xlabel("x")
    ylabel("y")
    legend(titles(1))
    title("Plot of function")
    
    
    figure(2)
    
    plot( vectorX, y2, typePlot(2) );
    legend(titles(2))
    xlabel("x")
    ylabel("y")
    title("Plot of function")
    
    figure(3)
    
    plot( vectorX, y1, typePlot(1), vectorX, y2 , typePlot(2) );
    legend(titles(1), titles(2) )
    xlabel("x")
    ylabel("y")
    
    title("Plot of functions")
end


    
    
    
    
    
    
    