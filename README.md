<div align="center">
<h1> Spectroscopy Analysis </h1>
</div>

Data-driven Statistical modeling project on three Spectroscopy datasets, FTIR, NMR, and GPC to develop a quantitative polymer structure-performance relationship -- Juliana Nam and Suhas Cristy Mathey

📌 **1. Project Introduction** 

 The goal of this project is to create a computational workflow that takes in input analytical characterization data, for various materials of interest to Dow Chemical, and generates a quantitative polymer structure-performance relationship. The raw data provided by Dow Chemical included three forms of analytical characterization data obtained from NMR, FTIR, and GPC experiments for 12 material samples. 

🗒️ **2. Contents**
 1. Project Deliverables folders contain all the code written in Jupyter notebook, for three Spectroscopy datasets, FTIR, NMR, and GPC. This folder also contains the documentation for the code and our reasons for choosing a particular method
 2. Each subfolder in Project Deliverables folder contains three subfolders each corresponding to FTIR, NMR, and GPC with its own dataset as .csv file and two jupyter notebooks in each folder one for Naive and the other for Dynamic Binning
 3. Plots folder contains plots obtained from three spectroscopy analyses.
 4. Used find_peaks function from Scipy signal, python signal processing library to identify peaks in the samples. 
 
 📊 **3. Observations** 

<div align="center">
<h5> Peaks identified from FTIR, NMR, and GPC Datasets </h5>
</div>


<div align = "center">
<img src = "Plots/FTIR_Peak%20Finding.png" alt="FTIR Peak Finding">
<img src = "Plots/NMR_Peak%20Finding.png" alt="NMR Peak Finding">
<img src = "Plots/NMR_Peak%20Finding_No%20Water%20Peak.png" alt="NMR Peak Finding on No Water Peak">
<img src = "Plots/GPC_Peak%20Finding.png" alt="GPC Peak Finding">
</div>

<div align="center">
<h5> Prinicpal Component Loadings for FTIR, NMR and GPC Datasets </h5>
</div>

<div align = "center">
<img src = "Plots/PC%20Loadings_NMR.png" alt="PC Loading NMR">
<img src = "Plots/PC%20Loadings_FTIR.png" alt="PC Loading FTIR">
<img src = "Plots/PC%20Loadings_GPC.png" alt="PC Loading GPC">
</div>