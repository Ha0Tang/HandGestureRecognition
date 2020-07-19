#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mex.h"

#ifdef MX_API_VER
#if MX_API_VER < 0x07030000
typedef int mwIndex;
#endif
#endif

void exit_with_help()
{
	mexPrintf(
	"Usage: libsvmwrite('filename', label_vector, instance_matrix);\n"
	);
}

void libsvmwrite(const char *filename, const mxArray *label_vec, const mxArray *instance_mat)
{
	FILE *fp = fopen(filename,"w");
	int i, k, low, high, l;
	mwIndex *ir, *jc;
	int label_vector_row_num;
	double *samples, *labels;
	mxArray *instance_mat_col; // instance sparse matrix in column format

	if(fp ==NULL)
	{
		mexPrintf("can't open output file %s\n",filename);			
		return;
	}

	// transpose instance matrix
	{
		mxArray *prhs[1], *plhs[1];
		prhs[0] = mxDuplicateArray(instance_mat);
		if(mexCallMATLAB(1, plhs, 1, prhs, "transpose"))
		{
			mexPrintf("Error: cannot transpose instance matrix\n");
			return;
		}
		instance_mat_col = plhs[0];
		mxDestroyArray(prhs[0]);
	}

	// the number of instance
	l = (int) mxGetN(instance_mat_col);
	label_vector_row_num = (int) mxGetM(label_vec);

	if(label_vector_row_num!=l)
	{
		mexPrintf("Length of label vector does not match # of instances.\n");
		return;
	}

	// each column is one instance
	labels = mxGetPr(label_vec);
	samples = mxGetPr(instance_mat_col);
	ir = mxGetIr(instance_mat_col);
	jc = mxGetJc(instance_mat_col);

	for(i=0;i<l;i++)
	{
		fprintf(fp,"%g", labels[i]);

		low = (int) jc[i], high = (int) jc[i+1];
		for(k=low;k<high;k++)
			fprintf(fp," %ld:%g", ir[k]+1, samples[k]);		

		fprintf(fp,"\n");
	}

	fclose(fp);
	return;
}

void mexFunction( int nlhs, mxArray *plhs[],
		int nrhs, const mxArray *prhs[] )
{	
	// Transform the input Matrix to libsvm format
	if(nrhs == 3)
	{
		char filename[256];
		if(!mxIsDouble(prhs[1]) || !mxIsDouble(prhs[2]))
		{
			mexPrintf("Error: label vector and instance matrix must be double\n");			
			return;
		}
		
		mxGetString(prhs[0], filename, mxGetN(prhs[0])+1);		

		if(mxIsSparse(prhs[2]))
			libsvmwrite(filename, prhs[1], prhs[2]);
		else
		{
			mexPrintf("Instance_matrix must be sparse\n");			
			return;
		}
	}
	else
	{
		exit_with_help();		
		return;
	}
}
