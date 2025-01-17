function[ratio,lag,lags,var_lag]=extreme_dete_and_match(X1,X2,N1,N2,n1,n2,n3,n4)
X=[X1 X2];
X=X(all(~isnan(X),2),:);
X1=X(:,1);
X2=X(:,2);
[maxi1,mini1]=extreme_detection(movmean(X1,12),N1);
[maxi2,mini2]=extreme_detection(movmean(X2,12),N1);
[maxi1,mini1]=extreme_filter(maxi1,mini1,n1,n2);
[maxi2,mini2]=extreme_filter(maxi2,mini2,n1,n2);
[maxi1,mini1]=extreme_adjust(X1,maxi1,mini1,N2);
[maxi2,mini2]=extreme_adjust(X2,maxi2,mini2,N2);
match_max=extreme_match(maxi1,maxi2,n3,n4);
match_min=extreme_match(mini1,mini2,n3,n4);
match=[match_max;match_min];
lag=mean(match(:,1)-match(:,2));
lags=match(:,1)-match(:,2);
ratio=size(match,1)/size([maxi1;mini1],1);
var_lag=std(lags);
end




function[maxi,mini]=extreme_detection(x,N)%步骤一，拐点识别
%x为处理数据，N表示极值筛选窗口，n为数据长度
n=size(x,1);
maxi=[];
mini=[];
for i=N+1:n-N
    if x(i)==max(x(i-N:i+N))
        maxi=[maxi; [i x(i)]];%峰点
    elseif x(i)==min(x(i-N:i+N))
        mini=[mini; [i x(i)]];%谷点
    end  
end
end

%步骤二，拐点筛选
function[maxi2,mini2]=extreme_filter(maxi,mini,n1,n2)
%maxi为极大值点，mini为极小值点，n1为峰谷（谷峰）最小间隔，n2为峰峰（谷谷）最小间隔
maxi(:,3)=1;
mini(:,3)=-1;
maxi2=extreme_filter1(maxi,n2);%去除峰点中间隔小于n2的点中小的点
mini2=extreme_filter1(mini,n2);%去除谷点中间隔小于n2的点中大的点
[maxi2,mini2]=extreme_filter2(maxi2,mini2,n1);%去除峰谷（谷峰）间隔过小和峰峰（谷谷）相邻的点
end

function[maxi]=extreme_filter1(maxi,n2)
i=1;
while i<size(maxi,1)
    if (maxi(i+1,1)-maxi(i,1))<n2
        [~,index]=min(maxi(i,3)*[maxi(i,2) maxi(i+1,2)]);
        maxi(index+i-1,:)=[];
    else
        i=i+1;
    end
end
end

function[maxi2,mini2]=extreme_filter2(maxi,mini,n1)
infle=table2array(sortrows(array2table([maxi;mini]),1));%峰谷点合并为拐点列
i=1;
while i<size(infle,1)
    if infle(i,3)*infle(i+1,3)==1%峰峰（谷谷）相邻
        [~,index]=min(infle(i,3)*[infle(i,2) infle(i+1,2)]);
        infle(index+i-1,:)=[];
    elseif infle(i,3)*infle(i+1,3)==-1%峰谷相邻
        if (infle(i+1,1)-infle(i,1))<n1
            infle(i,:)=[];%删除前一个点
            i=i-1;
        else
            i=i+1;
        end
    end
end
maxi2=infle(infle(:,3)==1,:);%拐点列还原为峰谷点列
mini2=infle(infle(:,3)==-1,:);
end

%步骤三，拐点调整
function[maxi,mini]=extreme_adjust(x,maxi,mini,N)
for i=1:size(maxi,1)
    [value,index]=max(x(maxi(i)-N:maxi(i)+N));
    maxi(i,:)=[index+maxi(i)-N-1 value 1];
end
for i=1:size(mini,1)
    [value,index]=min(x(mini(i)-N:mini(i)+N));
    mini(i,:)=[index+mini(i)-N-1 value -1];
end
end


%步骤四，拐点匹配
function[match]=extreme_match(infle1,infle2,n1,n2)
%infle1为基准指标的拐点,infle2为候选指标的拐点，n1为向前候选区间长度，n2为向后候选区间长度。
match=[];
for i=1:size(infle1,1)
    match_cand=[];
    for j=1:size(infle2,1)     
        if ((infle1(i,1)-infle2(j,1))<=n1)&&((infle2(j,1)-infle1(i,1))<=n2)
            match_cand=[match_cand infle2(j,1)];%储存候选拐点
        end
    end
    if isempty(match_cand)==0
    [~,index]=min(abs(match_cand-infle1(i,1)));
    match=[match;[infle1(i,1) match_cand(index)]];%有多个拐点在匹配范围内时选择最近拐点
    end
end

end