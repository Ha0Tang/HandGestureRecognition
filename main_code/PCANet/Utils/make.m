compstr = computer;
is64bit = strcmp(compstr(end-1:end),'64');

compile_params = cell(0);
if (is64bit)
  compile_params{1} = '-largeArrayDims';
end

% Compile files %
cd Utils
mex('im2colstep.c',compile_params{:});
cd ..