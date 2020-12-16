function [ num_blocked_conn ] = RunTraffic( adjmat, n_lambdas, traffic )

%Generate Bandiwidth/Channel/Frequency Slot Matrix
bwmat = adjmat;
bwmat(bwmat<Inf)=0;
bwmat(bwmat==Inf)=-1;
bwmat = repmat(bwmat,[1 1 n_lambdas]);
num_blocked_conn = 0;

for i = 1:size(traffic,2)
    
   switch traffic(i).type
    case 'arrival'
        %display('Arrival');
        ID = traffic(i).ID;
        s = traffic(i).source;
        d = traffic(i).destination;
        bw = traffic(i).bandwidth;
        
        active_conn(ID).path = [];
        active_conn(ID).lambda = 0;
        active_conn(ID).isactive = false;
        
        %Use s and d to find a path (list of nodes) then assign
        %active_conn(ID).path= path
        %For k-shortest path use Yen's Algorithm
        [path, cost] = Dijkstra(s,d,adjmat);
        active_conn(ID).path = path;
        %Use path and bw to find a lambda then assign
        %active_conn(ID).lambda = lambda
        lambda = FirstFit(path,bwmat);
        active_conn(ID).lambda = lambda;
        
        if(active_conn(ID).lambda>0)
            [bwmat, err] = BandwidthAllocate( bwmat, path, lambda, ID );
            if err==0
                active_conn(ID).isactive = true;
            else
                display('Error allocate');
            end
        else
           num_blocked_conn = num_blocked_conn+1; 
        end 
    case 'departure'
        %display('Departure');
        ID = traffic(i).ID;
        if(active_conn(ID).isactive == true)
            [bwmat, err] = BandwidthDeallocate( bwmat, active_conn(ID).path, active_conn(ID).lambda, ID );
            if err==0
                active_conn(ID).isactive = false;
            else
                display('Error deallocate');
            end
        end    
   end 
end
end

