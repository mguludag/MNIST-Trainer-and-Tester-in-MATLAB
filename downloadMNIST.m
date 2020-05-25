function result=downloadMNIST
url = 'http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz';
gunzip(url, 'download');

url = 'http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz';
gunzip(url, 'download');
result=true;
end