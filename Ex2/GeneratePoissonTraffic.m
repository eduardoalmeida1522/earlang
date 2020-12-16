function [ traffic, interarrival_times, holding_times ] = GeneratePoissonTraffic( arrival_rate, service_rate, num_connections, num_nodes)

%Shuffle the random seed  (Embaralhamento)
rng shuffle
%Rename the service rate and arrival rate to the corresponding mathematical variables
mi = service_rate;
lambda = arrival_rate;
node_list_s = 1:num_nodes;
%Corresponding mean times  
%mean_holding_time = 1/mi;
%mean_arrival_time = 1/lambda;

%Initialization
time = 0;                               %Sets current time to 0
interarrival_times = zeros(1,num_connections-1);      %Initialize array of interarrival times (Poisson distribution)
holding_times = zeros(1,num_connections);      %%Initialize array of holding times (Exponential distribution)
event_num = 1;

%Poisson Traffic Events Generation
for ID = 1:num_connections 
    %Calculate holdting time
    holding_times(ID) = -(log(1-rand))/mi;
    
    %Generate Arrival Event
    traffic(event_num).ID = ID;
    traffic(event_num).type = 'arrival';
    traffic(event_num).time = time;
        
    traffic(event_num).source = randi(num_nodes);                       %Select random integer between 1 and num_nodes
    node_list_d = node_list_s(node_list_s~=traffic(event_num).source);  %Create destination node list by copying source node list and excluding the current selected node
    traffic(event_num).destination = node_list_d(randi(num_nodes-1));   %Selecte random integer between 1 and num_nodes-1 from the destination array
    traffic(event_num).bandwidth = randi(3);
    
    event_num = event_num+1;
    %Generate Departure Event
    traffic(event_num).ID = ID;
    traffic(event_num).type = 'departure';
    traffic(event_num).time = time+holding_times(ID);
    
    traffic(event_num).source = traffic(event_num-1).source;            %Copy field (keep consistency) 
    traffic(event_num).destination = traffic(event_num-1).destination;  %Copy field (keep consistency) 
    traffic(event_num).bandwidth = traffic(event_num-1).bandwidth;      %Copy field (keep consistency) 
    
    %Calculate interarrival time
    interarrival_times(ID) = -(log(1-rand))/lambda;
    time = time+interarrival_times(ID);     %Current time is added to the interarrival time
    event_num = event_num+1;    
end
%Sort traffic events in time
traffic = nestedSortStruct(traffic, {'time'});
end

