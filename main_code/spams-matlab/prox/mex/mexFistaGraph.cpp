
/* Software SPAMS v2.1 - Copyright 2009-2011 Julien Mairal 
 *
 * This file is part of SPAMS.
 *
 * SPAMS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * SPAMS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with SPAMS.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <mex.h>
#include <mexutils.h>
#include <fista.h>

// alpha = mexFistaGraph(X,D,alpha0,graph,param)

using namespace FISTA;

template <typename T>
inline void callFunction(mxArray* plhs[], const mxArray*prhs[],
      const int nlhs) {
   if (!mexCheckType<T>(prhs[0])) 
      mexErrMsgTxt("type of argument 1 is not consistent");
   if (mxIsSparse(prhs[0])) 
      mexErrMsgTxt("argument 1 should not be sparse");

   if (!mexCheckType<T>(prhs[1])) 
      mexErrMsgTxt("type of argument 2 is not consistent");

   if (!mexCheckType<T>(prhs[2])) 
      mexErrMsgTxt("type of argument 3 is not consistent");
   if (mxIsSparse(prhs[2])) 
      mexErrMsgTxt("argument 3 should not be sparse");

   if (!mxIsStruct(prhs[3])) 
         mexErrMsgTxt("argument 4 should be struct");
   if (!mxIsStruct(prhs[4])) 
      mexErrMsgTxt("argument 5 should be struct");

   T* prX = reinterpret_cast<T*>(mxGetPr(prhs[0]));
   const mwSize* dimsX=mxGetDimensions(prhs[0]);
   int m=static_cast<int>(dimsX[0]);
   int n=static_cast<int>(dimsX[1]);
   Matrix<T> X(prX,m,n);

   const mwSize* dimsD=mxGetDimensions(prhs[1]);
   int mD=static_cast<int>(dimsD[0]);
   int p=static_cast<int>(dimsD[1]);
   AbstractMatrixB<T>* D;
   double* D_v;
   mwSize* D_r, *D_pB, *D_pE;
   int* D_r2, *D_pB2, *D_pE2;
   T* D_v2;
   if (mxIsSparse(prhs[1])) {
      D_v=static_cast<double*>(mxGetPr(prhs[1]));
      D_r=mxGetIr(prhs[1]);
      D_pB=mxGetJc(prhs[1]);
      D_pE=D_pB+1;
      createCopySparse<T>(D_v2,D_r2,D_pB2,D_pE2,
            D_v,D_r,D_pB,D_pE,p);
      D = new SpMatrix<T>(D_v2,D_r2,D_pB2,D_pE2,mD,p,D_pB2[p]);
   } else {
      T* prD = reinterpret_cast<T*>(mxGetPr(prhs[1]));
      D = new Matrix<T>(prD,m,p);
   }

   T* pr_alpha0 = reinterpret_cast<T*>(mxGetPr(prhs[2]));
   const mwSize* dimsAlpha=mxGetDimensions(prhs[2]);
   int pAlpha=static_cast<int>(dimsAlpha[0]);
   int nAlpha=static_cast<int>(dimsAlpha[1]);
   Matrix<T> alpha0(pr_alpha0,pAlpha,nAlpha);

   mxArray* ppr_GG = mxGetField(prhs[3],0,"groups");
   if (!mxIsSparse(ppr_GG)) 
      mexErrMsgTxt("field groups should be sparse");
   mwSize* GG_r=mxGetIr(ppr_GG);
   mwSize* GG_pB=mxGetJc(ppr_GG);
   const mwSize* dims_GG=mxGetDimensions(ppr_GG);
   int GGm=static_cast<int>(dims_GG[0]);
   int GGn=static_cast<int>(dims_GG[1]);
   if (GGm != GGn)
      mexErrMsgTxt("size of field groups is not consistent");

   mxArray* ppr_GV = mxGetField(prhs[3],0,"groups_var");
   if (!mxIsSparse(ppr_GV)) 
      mexErrMsgTxt("field groups_var should be sparse");
   mwSize* GV_r=mxGetIr(ppr_GV);
   mwSize* GV_pB=mxGetJc(ppr_GV);
   const mwSize* dims_GV=mxGetDimensions(ppr_GV);
   int nV=static_cast<int>(dims_GV[0]);
   int nG=static_cast<int>(dims_GV[1]);
   if (nV <= 0 || nG != GGn)
      mexErrMsgTxt("size of field groups-var is not consistent");

   mxArray* ppr_weights = mxGetField(prhs[3],0,"eta_g");
   if (mxIsSparse(ppr_weights)) 
      mexErrMsgTxt("field eta_g should not be sparse");
   T* pr_weights = reinterpret_cast<T*>(mxGetPr(ppr_weights));
   const mwSize* dims_weights=mxGetDimensions(ppr_weights);
   int mm1=static_cast<int>(dims_weights[0]);
   int nnG=static_cast<int>(dims_weights[1]);
   if (mm1 != 1 || nnG != nG)
      mexErrMsgTxt("size of field eta_g is not consistent");

   plhs[0]=createMatrix<T>(pAlpha,nAlpha);
   T* pr_alpha=reinterpret_cast<T*>(mxGetPr(plhs[0]));
   Matrix<T> alpha(pr_alpha,pAlpha,nAlpha);

   FISTA::ParamFISTA<T> param;
   param.num_threads = getScalarStructDef<int>(prhs[4],"numThreads",-1);
   param.max_it = getScalarStructDef<int>(prhs[4],"max_it",1000);
   param.tol = getScalarStructDef<T>(prhs[4],"tol",0.000001);
   param.it0 = getScalarStructDef<int>(prhs[4],"it0",100);
   param.pos = getScalarStructDef<bool>(prhs[4],"pos",false);
   param.compute_gram = getScalarStructDef<bool>(prhs[4],"compute_gram",false);
   param.max_iter_backtracking = getScalarStructDef<int>(prhs[4],"max_iter_backtracking",1000);
   param.L0 = getScalarStructDef<T>(prhs[4],"L0",1.0);
   param.fixed_step = getScalarStructDef<T>(prhs[4],"fixed_step",false);
   param.gamma = MAX(1.01,getScalarStructDef<T>(prhs[4],"gamma",1.5));
   param.c= getScalarStructDef<T>(prhs[4],"c",1.0);
   param.lambda= getScalarStructDef<T>(prhs[4],"lambda",1.0);
   param.delta = getScalarStructDef<T>(prhs[4],"delta",1.0);
   param.lambda2= getScalarStructDef<T>(prhs[4],"lambda2",0.0);
   param.lambda3= getScalarStructDef<T>(prhs[4],"lambda3",0.0);
   param.size_group= getScalarStructDef<int>(prhs[4],"size_group",1);
   param.admm = getScalarStructDef<bool>(prhs[4],"admm",false);
   param.lin_admm = getScalarStructDef<bool>(prhs[4],"lin_admm",false);
   param.sqrt_step = getScalarStructDef<bool>(prhs[4],"sqrt_step",true);
   param.is_inner_weights = getScalarStructDef<bool>(prhs[4],"is_inner_weights",false);
   param.transpose = getScalarStructDef<bool>(prhs[4],"transpose",false);
   getStringStruct(prhs[4],"regul",param.name_regul,param.length_names);
   if (param.is_inner_weights) {
      mxArray* ppr_inner_weights = mxGetField(prhs[4],0,"inner_weights");
      if (!ppr_inner_weights) mexErrMsgTxt("field inner_weights is not provided");
      if (!mexCheckType<T>(ppr_inner_weights)) 
         mexErrMsgTxt("type of inner_weights is not correct");
      param.inner_weights = reinterpret_cast<T*>(mxGetPr(ppr_inner_weights));
   }

   param.regul = regul_from_string(param.name_regul);
   if (param.regul==INCORRECT_REG)
      mexErrMsgTxt("Unknown regularization");
   getStringStruct(prhs[4],"loss",param.name_loss,param.length_names);
   param.loss = loss_from_string(param.name_loss);
   if (param.loss==INCORRECT_LOSS)
      mexErrMsgTxt("Unknown loss");

   param.intercept = getScalarStructDef<bool>(prhs[4],"intercept",false);
   param.resetflow = getScalarStructDef<bool>(prhs[4],"resetflow",false);
   param.verbose = getScalarStructDef<bool>(prhs[4],"verbose",false);
   param.clever = getScalarStructDef<bool>(prhs[4],"clever",false);
   param.ista= getScalarStructDef<bool>(prhs[4],"ista",false);
   param.subgrad= getScalarStructDef<bool>(prhs[4],"subgrad",false);
   param.log= getScalarStructDef<bool>(prhs[4],"log",false);
   param.a= getScalarStructDef<T>(prhs[4],"a",T(1.0));
   param.b= getScalarStructDef<T>(prhs[4],"b",0);

   if (param.log) {
      mxArray *stringData = mxGetField(prhs[4],0,"logName");
      if (!stringData) 
         mexErrMsgTxt("Missing field logName");
      int stringLength = mxGetN(stringData)+1;
      param.logName= new char[stringLength];
      mxGetString(stringData,param.logName,stringLength);
   }

   if ((param.loss != CUR && param.loss != MULTILOG) && (pAlpha != p || nAlpha != n || mD != m)) { 
      mexErrMsgTxt("Argument sizes are not consistent");
   } else if (param.loss == MULTILOG) {
      Vector<T> Xv;
      X.toVect(Xv);
      int maxval = static_cast<int>(Xv.maxval());
      int minval = static_cast<int>(Xv.minval());
      if (minval != 0)
         mexErrMsgTxt("smallest class should be 0");
      if (maxval*X.n() > nAlpha || mD != m) {
         cerr << "Number of classes: " << maxval << endl;
         //cerr << "Alpha: " << pAlpha << " x " << nAlpha << endl;
         //cerr << "X: " << X.m() << " x " << X.n() << endl;
         mexErrMsgTxt("Argument sizes are not consistent");
      }
   } else if (param.loss == CUR && (pAlpha != D->n() || nAlpha != D->m())) {
      mexErrMsgTxt("Argument sizes are not consistent");
   }

   if (param.regul==GRAPHMULT && abs<T>(param.lambda2 - 0) < 1e-20) {
      mexErrMsgTxt("Error: with multi-task-graph, lambda2 should be > 0");
   }

   if (param.num_threads == -1) {
      param.num_threads=1;
#ifdef _OPENMP
      param.num_threads =  MIN(MAX_THREADS,omp_get_num_procs());
#endif
   } 

   if (param.regul==TREE_L0 || param.regul==TREEMULT || param.regul==TREE_L2 || param.regul==TREE_LINF) 
      mexErrMsgTxt("Error: mexFistaTree should be used instead");

   GraphStruct<T> graph;
   graph.Nv=nV;
   graph.Ng=nG;
   graph.weights=pr_weights;
   graph.gg_ir=GG_r;
   graph.gg_jc=GG_pB;
   graph.gv_ir=GV_r;
   graph.gv_jc=GV_pB;


   Matrix<T> duality_gap;
   FISTA::solver<T>(X,*D,alpha0,alpha,param,duality_gap,&graph);
   if (nlhs==2) {
      plhs[1]=createMatrix<T>(duality_gap.m(),duality_gap.n());
      T* pr_dualitygap=reinterpret_cast<T*>(mxGetPr(plhs[1]));
      for (int i = 0; i<duality_gap.n()*duality_gap.m(); ++i) pr_dualitygap[i]=duality_gap[i];
   }
   if (param.logName) delete[](param.logName);

   if (mxIsSparse(prhs[1])) {
      deleteCopySparse<T>(D_v2,D_r2,D_pB2,D_pE2,
            D_v,D_r);
   }
   delete(D);
}

void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[]) {
   if (nrhs != 5)
      mexErrMsgTxt("Bad number of inputs arguments");

   if (nlhs != 1 && nlhs != 2) 
      mexErrMsgTxt("Bad number of output arguments");

   if (mxGetClassID(prhs[0]) == mxDOUBLE_CLASS) {
      callFunction<double>(plhs,prhs,nlhs);
   } else {
      callFunction<float>(plhs,prhs,nlhs);
   }
}




