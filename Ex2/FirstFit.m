function lambda = FirstFit( path, bwmat, bw)
lambda = 0;
len = size(bwmat,3);
for w = 1:(len-bw+1)
    not_found = false;
    for bw_curr = w:(w+bw-1)
        for k = 2:size(path,2)
            i = path(k-1);
            j = path(k);
            if(bwmat(i,j,bw_curr)~=0)
               not_found=true;
               break;
            else
                if (k==size(path,2) && bw_curr==(w+bw-1))
                    lambda = w;
                    return;
                end
            end
        end
         if(not_found==true)
            break;   
        end
    end
end
end

