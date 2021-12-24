function [update]   = processData(raw,n)


% raw((k+3*theta)<raw)=0;
% raw(raw<(k-3*theta))=0;
raw(raw<0)  = 0;
raw(raw==0) = nan;
% get the data which is in the mean+-3sigma
for MonkeyN=1:n
    k      = nanmean(raw(:,MonkeyN));
    theta  = nanstd(raw(:,MonkeyN));
    for dataN = 1:22
        if  raw(dataN,MonkeyN)>(k+3*theta)||raw(dataN,MonkeyN)<(k-3*theta)
            raw(dataN,MonkeyN)=100;
        end
    end
end

for MonkeyN=1:n
    if 22-numel(find(isnan(raw(:,MonkeyN))))>4
        [u,v]=max(raw(:,MonkeyN));
        [s,t]=min(raw(:,MonkeyN));
        raw(v,MonkeyN)=nan;
        raw(t,MonkeyN)=nan;
    end
end
update=raw;
end
