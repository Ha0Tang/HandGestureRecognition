function ResponseLayerData=FastHessian_ResponseLayer(width, height, step, filter)% This function FastHessian_ResponseLayer will ..
%
% [ResponseLayerData] = FastHessian_ResponseLayer( width,height,step,filter )
%  
%  inputs,
%    width : 
%    height : 
%    step : 
%    filter : 
%  
%  outputs,
%    ResponseLayerData : 
%  
% Function is written by D.Kroon University of Twente (July 2010)
width=floor(width);height=floor(height);step=floor(step);filter=floor(filter);ResponseLayerData.width = width;ResponseLayerData.height = height;ResponseLayerData.step = step;ResponseLayerData.filter = filter;ResponseLayerData.responses = zeros(width * height,1);ResponseLayerData.laplacian = zeros(width * height,1);