answer = questdlg('Do you have MNIST Dataset?', ...
	'Yes', ...
	'No');
% Handle response
switch answer
    case 'Yes'
        % select mnist train images
        [file,path]=uigetfile('train*.idx3-ubyte','Select Train Images');
        trainimages=single(loadMNISTImages(fullfile(path,file)));

        % select mnist train labels
        [file,path]=uigetfile('train*.idx1-ubyte','Select Train Labels');
        trainlabels=single(loadMNISTLabels(fullfile(path,file)));
    case 'No'
        disp('MNIST Database will be download');
        if(downloadMNIST)
            trainlabels=single(loadMNISTLabels('download/train-labels-idx1-ubyte'));
            trainimages=single(loadMNISTImages('download/train-images-idx3-ubyte'));
        end
end


% create output matrix and fill it
y=zeros(10,60000);
for i=1:60000
    y(trainlabels(i)+1,i)=1;
end

clear('i','path','file');

% put hidden layer size and count for test 1 to 6
hiddenlayers={10,5,[5,5],[5,10],[10,10],[10,5]};
[numRows,numCols] = size(hiddenlayers);

% create folders for save net and some images
mkdir 'net';
mkdir 'arch';
mkdir 'confmat';

% automatize the net create and training, testing process 
% for every test 1 to 6
for i=1:numCols
    [net, fig, arch]=createNet(trainimages,y,hiddenlayers{i});
    save(append('net/',num2str(i),'-net(',mat2str(hiddenlayers{i}),').mat'),'net');
    saveas(arch,append('arch/',num2str(i),'-arch(',mat2str(hiddenlayers{i}),').png'));
    saveas(fig,append('confmat/',num2str(i),'-confmat(',mat2str(hiddenlayers{i}),').png'));
    clear('arch','fig','net');
end

clear('numRows','numCols','i','answer');
    