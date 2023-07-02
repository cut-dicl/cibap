# cibap
Computational intelligence approaches for solving the berth allocation problem.

This is the code written for the article titled "Berth Allocation Considering Multiple Quays: A Practical Approach using Cuckoo Search Optimization", by authors "Sheraz Aslam, Michalis P. Michaelides and Herodotos Herodotou" (sheraz.aslam@cut.ac.cy).

This package contains two main folders.

1. MATLAB_CODE:
it further contains 5 subfolders <br />
a) CSA--> it stores the function and codes used for cukoo search algorithm---> you just need to run the file name starting with "Main_" <br />
If you want to generate your own data with different number of vessels and quays, you can use the function "Instances_generator" to generate new data. You
can find this function in CSA folder <br />
b) GA--> it stores the function and codes used for genetic algorithm---> you just need to run the file name starting with "Main_" <br />
c) PSO--> it stores the function and codes used for particle swarm optimization algorithm---> you just need to run the file name starting with "Main_" <br />
d) MILP--> it stores the function and codes used for exact method---> you just need to run the file named"Journal_MultiQuay_MILP_randomData" <br />
e) Plots--> it stores the function and codes used for ploting the results---> you just need to run the file name starting with "MainResultsFile" <br />

2. Data_and_Results: <br />
It contains data instances, results for all algorithms and all instances. <br />
Naming convention for data file names: "10v1d1q" --> It shows the data instances considering 10 vessels, 1 day planning horizon, and 1 quay. <br />
Naming convention for result file names: "BP_CSA_10v1d1q" --> BP (berthing position) results of CSA considering 10 vessels, 1 day, and 1 quay. (BT -> berthing time / BQ -> berthing quay) <br />

References:
-----------
You can also read our other papers that relate to this study: <br />

1. Aslam, Sheraz, M. P. Michaelides and H. Herodotou, "Enhanced Berth Allocation Using the Cuckoo Search Algorithm." in Springer Nature Computer Science, doi: 10.1007/s42979-022-01211-z
2. Aslam, S.; Michaelides, M. and Herodotou, H. (2022). Optimizing Multi-Quay Berth Allocation using the Cuckoo Search Algorithm.  In Proceedings of the 8th International Conference on Vehicle Technology and Intelligent Transport Systems, ISBN 978-989-758-573-9, ISSN 2184-495X, pages 124-133. 
3. Aslam, Sheraz; Michaelides, M. and Herodotou, H. (2021). Dynamic and Continuous Berth Allocation using Cuckoo Search Optimization.  In Proceedings of the 7th International Conference on Vehicle Technology and Intelligent Transport Systems, ISBN 978-989-758-513-5, ISSN 2184-495X, pages 72-81.  DOI: 10.5220/0010436600720081

Authors:
--------
Sheraz Aslam (PhD., Member IEEE) <br />
Cyprus University of Technology, Cyprus <br />
https://sites.google.com/view/sherazaslam/home <br />
Email: sheraz.aslam@cut.ac.cy <br />

Michalis Michaelides <br />
Cyprus University of Technology, Cyprus <br />

Herodotos Herodotou <br />
Cyprus University of Technology, Cyprus <br />
https://dicl.cut.ac.cy/

