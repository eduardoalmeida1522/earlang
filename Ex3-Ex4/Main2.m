num_connections = 50000;
n_lambdas = 16;
service_rate = 1/60;
%Adjacency Matrix of geodesic distances. NFSNET Network
            %1  %2   %3  %4  %5  %6  %7  %8  %9  %10  %11  %12 %13 %14
adjmat = [ Inf 1100 1600 Inf Inf Inf Inf 2800 Inf Inf Inf Inf Inf Inf %1
           1100 Inf 600 1000 Inf Inf Inf Inf Inf Inf Inf Inf Inf Inf  %2 
           1600 600 Inf Inf Inf 2000 Inf Inf Inf Inf Inf Inf Inf Inf  %3
           Inf 1000 Inf Inf 600 Inf Inf Inf Inf Inf 2400 Inf Inf Inf  %4
           Inf Inf Inf 600 Inf 1100 800 Inf Inf Inf Inf Inf Inf Inf   %5
           Inf Inf 2000 Inf 1100 Inf Inf Inf Inf 1200 Inf Inf 2000 Inf %6
           Inf Inf Inf Inf 800 Inf Inf 700 Inf Inf Inf Inf Inf Inf     %7
           2800 Inf Inf Inf Inf Inf 700 Inf 700 Inf Inf Inf Inf Inf    %8
           Inf Inf Inf Inf Inf Inf Inf 700 Inf 900 Inf 500 Inf 500     %9
           Inf Inf Inf Inf Inf 1200 Inf Inf 900 Inf Inf Inf Inf Inf    %10
           Inf Inf Inf 2400 Inf Inf Inf Inf Inf Inf Inf 800 Inf 300    %11
           Inf Inf Inf Inf Inf Inf Inf Inf 500 Inf  800 Inf 300 Inf    %12
           Inf Inf Inf Inf Inf 2000 Inf Inf Inf Inf Inf 300 Inf 300    %13
           Inf Inf Inf Inf Inf Inf Inf Inf 500 Inf 300 Inf 300 Inf  ] ;%14
num_nodes = size(adjmat,1);

%Descomente para obter o resultado do Exerc�cio 4
%adjmat(adjmat<Inf)=1;

BP = [];
for erlang = 10:10:400
    %Calculate arrival rate
    arrival_rate = erlang * service_rate;
    %Generate Poisson Traffic 
    [ traffic, interarrival_times, holding_times ] = GeneratePoissonTraffic( arrival_rate, service_rate, num_connections, num_nodes);
    %Execute Events
    blocked = RunTraffic( adjmat, n_lambdas, traffic);
    %Calculate Blocking Probability
    BP = [BP blocked/num_connections];
end
erlang =  10:10:400;
plot(erlang,BP);
