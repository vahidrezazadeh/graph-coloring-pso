function z=Costfcn(x,ProblemData)
    
    z=0;
    N=ProblemData.N;
    Graph=ProblemData.Graph;
    for i=1:N-1
        for j=i+1:N
            if Graph(i,j)==1
                if x(i)==x(j)
                    z=z+1;
                end
            end
        end
    end

end