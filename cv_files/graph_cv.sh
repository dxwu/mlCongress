#!/bin/bash

cd ./k5
rm *.fig
rm graph_cv.m
cp ../graph_cv.m .
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k8
rm *.fig
rm graph_cv.m
cp ../graph_cv.m .
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k10
rm *.fig
rm graph_cv.m
cp ../graph_cv.m .
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k15
rm *.fig
rm graph_cv.m
cp ../graph_cv.m .
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
cd ./k20
rm *.fig
rm graph_cv.m
cp ../graph_cv.m .
/Applications/MATLAB_R2014a.app/bin/matlab -nosplash -nodisplay -r "graph_cv(true);graph_cv(false);quit()"
cd ..
