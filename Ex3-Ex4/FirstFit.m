function lambda = FirstFit( path, bwmat )
lambda = 0;
for w = 1: size(bwmat,3)
    for k = 2:size(path,2)
        i = path(k-1);
        j = path(k);
        if(bwmat(i,j,w)~=0)
           break;
        else
            if (k==size(path,2))
                lambda = w;
            end
        end
    end
end
end

