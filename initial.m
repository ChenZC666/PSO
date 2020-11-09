function [sigma,E_real,X,Y] = initial(a)
    %clear;
    %a = 1.5;
    %theta = 0:60;  %视角
    x_num = 16;
    y_num = 16;
    left = (30-(x_num-1)*a)/2;
    right = 30-left;
    top = (30-(y_num-1)*a)/2;
    bottom = 30-top;
    X = left:a:right; %灯平面坐标
    Y = top:a:bottom;
    xt = 1:30;  %目标平面坐标，30*30
    yt = 1:30;
    m = 1;
    I0 = 20000;
    z = 10;
    E_sum = zeros(30,30);
    mse = 0;
    qq = 0;

    for x0 = X
        for y0 = Y
            qq=qq+1;
            E = E0(x0,y0,xt,yt,I0,m,z);
            E_sum = E_sum + E;  
        end
    end
    E_real = real(E_sum);
    E_mean = sum(sum(E_real))/(size(xt,2)*size(yt,2));
    for p = xt
        for q = yt
            mse = (E_real(p,q)-E_mean)^2 + mse;
        end
    end
    sigma = (mse/(size(xt,2)*size(yt,2)))^(1/2);
end

function E = E0(X,Y,xt,yt,I0,m,z) 
    %%单个LED光源的光照模型
    E = zeros(size(xt,2),size(yt,2));
    for x0 = xt
      for y0 = yt
           E(x0,y0) = (z^(m+1)*I0)/(((x0-X)^2+(y0-Y)^2+z^2)^((m+3)/2));
      end
    end
end