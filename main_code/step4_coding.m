clc; clear all; tic
numFeatures = 5000 ;
dimension = 2 ;
data = rand(dimension,numFeatures) ;

numClusters = 30 ;
[means, covariances, priors] = vl_gmm(data, numClusters);
% Next, we create another random set of vectors, which should be encoded using the Fisher Vector representation and the GMM just obtained:
numDataToBeEncoded = 1000;
dataToBeEncoded = rand(dimension,numDataToBeEncoded);
% The Fisher vector encoding enc of these vectors is obtained by calling the vl_fisher function using the output of the vl_gmm function:
encoding = vl_fisher(dataToBeEncoded, means, covariances, priors);
% The encoding vector is the Fisher vector representation of the data dataToBeEncoded.
% Note that Fisher Vectors support several normalization options that can affect substantially the performance of the representation.

%% VLAD encoding
% The Vector of Linearly Agregated Descriptors is similar to Fisher vectors but 
% (i) it does not store second-order information about the features and 
% (ii) it typically use KMeans instead of GMMs to generate the feature vocabulary (although the latter is also an option).

% Consider the same 2D data matrix data used in the previous section to train the Fisher vector representation. 
% To compute VLAD, we first need to obtain a visual word dictionary. This time, we use K-means:

numClusters = 30 ;
centers = vl_kmeans(dataLearn, numClusters);
% Now consider the data dataToBeEncoded and use the vl_vlad function to compute the encoding. 
% Differently from vl_fisher, vl_vlad requires the data-to-cluster assignments to be passed in. 
% This allows using a fast vector quantization technique (e.g. kd-tree) as well as switching from soft to hard assignment.

% In this example, we use a kd-tree for quantization:

kdtree = vl_kdtreebuild(centers) ;
nn = vl_kdtreequery(kdtree, centers, dataEncode) ;
% Now we have in the nn the indexes of the nearest center to each vector in the matrix dataToBeEncoded. 
% The next step is to create an assignment matrix:

assignments = zeros(numClusters,numDataToBeEncoded);
assignments(sub2ind(size(assignments), nn, 1:length(nn))) = 1;
% It is now possible to encode the data using the vl_vlad function:

enc = vl_vlad(dataToBeEncoded,centers,assignments);
% Note that, similarly to Fisher vectors, VLAD supports several normalization options that can affect substantially 
% the performance of the representation.

toc
