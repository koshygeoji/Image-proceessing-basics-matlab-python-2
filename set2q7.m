clc;
clear all
close all
im=imread('lena_RGB.tif');
im=double(im);
R=im(:,:,1);
G=im(:,:,2);
B=im(:,:,3);
ws=11;
avg=(1/(ws*ws))*ones(ws,ws);
[r,c,t]=size(im);
pd=(ws-1)/2;
start=ws-pd;
f1=padarray(R,[pd pd],'replicate');
f2=padarray(G,[pd pd],'replicate');
f3=padarray(B,[pd pd],'replicate');

for i=start:r-pd
    for j=start:c-pd
        window1=f1(i-pd:i+pd,j-pd:j+pd);
        window2=f2(i-pd:i+pd,j-pd:j+pd);
        window3=f3(i-pd:i+pd,j-pd:j+pd);
        su1=0; 
        su2=0;  
        su3=0;  
        for s=1:ws
            for t=1:ws
                su1=su1+avg(s,t)*window1(s,t);
                su2=su2+avg(s,t)*window2(s,t);
                su3=su3+avg(s,t)*window3(s,t);
            end
        end
        YR(i-start+1,j-start+1)=su1;
        YG(i-start+1,j-start+1)=su2;
        YB(i-start+1,j-start+1)=su3;
    end
end
% YR=conv2(R,avg,'same');
% YG=conv2(G,avg,'same');
% YB=conv2(B,avg,'same');
Out(:,:,1)=YR;
Out(:,:,2)=YG;
Out(:,:,3)=YB;
figure,subplot(1,2,1),imshow(uint8(im)),title('Original Image');
subplot(1,2,2),imshow(uint8(Out)),title('Smoothened Image');