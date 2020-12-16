%Release corresponding wavelength/channel/frequency slot in the Bandwidth Matrix
function [bwmat, err] = BandwidthDeallocate( bwmat, path, lambda0, bw, ID )
err=0;
for k = 2:size(path,2)
    i = path(k-1);
    j = path(k);
    for lambda = lambda0:(lambda0+bw-1)
        if(bwmat(i,j,lambda)==ID)
           bwmat(i,j,lambda)=0;
        else
            err =- 1;
            return;
        end
    end
end
end