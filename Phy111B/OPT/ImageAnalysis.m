workingDir = '/Users/JoshuaLevy/Desktop/HighSpeed/'
shuttleVideo = VideoReader([workingDir 'HighSpeed.mp4']);
ii = 1
% while hasFrame(shuttleVideo)
%    img = readFrame(shuttleVideo);
%    filename = [sprintf('%03d',ii) '.jpg'];fullname = fullfile(workingDir,'image',filename);
%    imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
%    ii = ii+1;
% end
calibrationImg = '/Users/JoshuaLevy/Desktop/HighSpeed/image/003.jpg'
max = '/Users/JoshuaLevy/Desktop/HighSpeed/image/062.jpg'
ii = 1
positionPump = []
positionRelax = []
while hasFrame(shuttleVideo)
    img = readFrame(shuttleVideo);
    if ii < 62 && mod(ii,5)==0
        imshow(img)
        positionPump = [positionPump;ginput(1)]
    end
    if ii > 62 && mod(ii,5)==0
        imshow(img)
        positionRelax = [positionRelax;ginput(1)]
    end
    ii=ii+1;
%     imshow(imread(calibrationImg))
% positionPump = [ginput(1);positionPump]
% imshow(imread(max))
% positionPump = [positionPump;ginput(1)]
% positionRelax = [ginput(1);positionRelax]
%calibrationpt = ginput(3)
end
