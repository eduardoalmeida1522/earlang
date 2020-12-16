function [path, cost] = Dijkstra(S, D, adjmat)
if ( size(adjmat,1) ~= size(adjmat,2) )
  error( 'Dijkstra', ...
         'adjmat has different width and heights' );
end
% Initialization:
%  num_nodes     : nodes in the graph
%  parent(i)    : record the parent of node i
%  distance(i)  : the shortest distance from i to S
%  queue        : for width-first traveling of the graph
num_nodes = size(adjmat, 1);
for i = 1:num_nodes
  parent(i) = 0;
  distance(i) = Inf;
end
queue = [];
% Start from S
for i=1:num_nodes
  if adjmat(S, i)~=Inf 
    distance(i) = adjmat(S, i);
    parent(i)   = S;
    queue       = [queue i];
  end
end
% Width-first exploring the whole graph
while length(queue) ~= 0
  hopS  = queue(1);
  queue = queue(2:end);
  for hopE = 1:num_nodes
    if distance(hopE) > distance(hopS) + adjmat(hopS,hopE)
      distance(hopE) = distance(hopS) + adjmat(hopS,hopE);
      parent(hopE)   = hopS;
      queue          = [queue hopE];
    end
  end  
end
% Back-trace the shortest-path
path = [D];   
i = parent(D);  
while i~=S && i~=0
  path = [i path];
  i      = parent(i);
end
if i==S
  path = [i path];
else
  path = 0;
end
% Return cost
cost = distance(D);

