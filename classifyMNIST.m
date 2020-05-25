function [val,idx]=classifyMNIST(net, image)
        image=single(reshape(image(:,:,1),[784,1]));
        image=255-image;
        arr=net(image);
        [val, idx] = max(arr);
        idx=idx-1;
        clear('arr');
end