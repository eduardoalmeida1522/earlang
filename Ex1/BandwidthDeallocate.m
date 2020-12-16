%Release corresponding wavelength/channel/frequency slot in the Bandwidth Matrix
function [bwmat, err] = BandwidthDeallocate( bwmat, path, lambda, ID )
err=0;
for k = 2:size(path,2)
    i = path(k-1);
    j = path(k);
    if(bwmat(i,j,lambda)==ID)
       bwmat(i,j,lambda)=0;
    else
        err=-1;
        return;
    end
end
end