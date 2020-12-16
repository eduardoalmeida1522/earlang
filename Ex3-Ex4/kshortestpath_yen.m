function [A] = kshortestpath_yen(S, D, adjmat, k_max)
nnodes = length(adjmat);
%Determine the shortest path from the source to the sink.
[A(1).path, A(1).cost] = Dijkstra(S,D,adjmat);
%Initialize the set to store the potential kth shortest path.
B = [];
Bcount = 0;
for k = 2:k_max
    %The spur node ranges from the first node to the next to last node in the previous k-shortest path.
    for i = 1: (length(A(k-1).path)-1) 
        aux_adjmat = adjmat;
        % Spur node is retrieved from the previous k-shortest path, k ? 1.
        spurNode = A(k-1).path(i);
        % The sequence of nodes from the source to the spur node of the previous k-shortest path.
        rootPath = A(k-1).path(1:i);
           
        for j=1:length(A)
           p = A(j).path;
           if isequal(rootPath,p(1:min(i,j)))
               % Remove the links that are part of the previous shortest paths which share the same root path.
               aux_adjmat(p(i),p(i+1))=Inf;
               %aux_adjmat(p(i+1),p(i))=Inf;
           end
        end
        rootPath_aux = rootPath(rootPath~=spurNode);
        for j = 1:length(rootPath_aux)
           %each node rootPathNode in rootPath except spurNode:
           rootPathNode = rootPath_aux(j);
           %remove rootPathNode from Graph;
           for r=1:nnodes
            aux_adjmat(rootPathNode,r)=Inf;
            aux_adjmat(r,rootPathNode)=Inf;
           end
        end
        % Calculate the spur path from the spur node to the sink.
        %pause
        [spurPath, cost]= Dijkstra(spurNode, D, aux_adjmat);
        % Entire path is made up of the root path and spur path.
        if(cost < Inf)
            for r=1:(length(rootPath)-1)
                cost = cost+ adjmat(rootPath(r),rootPath(r+1));
            end
            totalPath = [rootPath  spurPath(spurPath~=spurNode)];
            % Add the potential k-shortest path to the heap.
            Bcount=Bcount+1;
            B(Bcount).path = totalPath;
            B(Bcount).cost = cost;       
        end
        % Add back the edges and nodes that were removed from the graph.
        %restore edges to Graph;
        %restore nodes in rootPath to Graph;
    end       
    if isempty(B)
       % This handles the case of there being no spur paths, or no spur paths left.
       % This could happen if the spur paths have already been exhausted (added to A), 
       % or there are no spur paths at all - such as when both the source and sink vertices 
       % lie along a "dead end".
       break;
    end
    % Sort the potential k-shortest paths by cost.
    %B.sort();
    B = nestedSortStruct(B, {'cost'});
    %Add the lowest cost path becomes the k-shortest path.
    A(k) = B(1);
    B(1)=[];
    Bcount=Bcount-1;
end
end

