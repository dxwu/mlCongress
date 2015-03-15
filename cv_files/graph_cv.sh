#!/bin/bash

cd ./k5
rm *.fig
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k8
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k10
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k15
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k20
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
