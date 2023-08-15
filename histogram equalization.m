clc
Image=imread('project1.png');
Red=Image;
Green=Image;
Blue=Image;
I1=double(Image);
Red(:,:,2:3)=0;
Green(:,:,[1 3])=0;
Blue(:,:,1:2)=0;
orginalGrey=uint8((I1(:,:,1)+I1(:,:,2)+I1(:,:,3))/3);
[rows,columns,~] = size(orginalGrey);
finalResult = uint8(zeros(rows,columns));
totalpixels = rows*columns;
frequency = zeros(256,1);
pdf = zeros(256,1);
cdf = zeros(256,1);
cummlative = zeros(256,1);
outpic = zeros(256,1);
for i = 1:1:rows
    for j = 1:1:columns
        sum = orginalGrey(i,j);
        frequency(sum+1) = frequency(sum+1)+1;
        pdf(sum+1) = frequency(sum+1)/totalpixels;
    end
end
total =0 ;
intensity = 255;
for i = 1:1:size(pdf)
    total =total +frequency(i);
    cummlative(i) = total;
    cdf(i) = cummlative(i)/ totalpixels;
    outpic(i) = round(cdf(i) * intensity);
end
for i = 1:1:rows
    for j = 1:1:columns
        finalResult(i,j) = outpic(orginalGrey(i,j) + 1);
    end
end
subplot(1,3,1),imshow(orginalGrey),title('Original Grey Image');
subplot(1,3,2),imshow(finalResult),title('After Manual Histogram Equlization');
subplot(1,3,3),imshow(histeq(orginalGrey)),title('using histeq');