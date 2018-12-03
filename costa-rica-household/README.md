## Costa Rica Houshold Poverty dataset

Kaggle dataset taken from [here](https://www.kaggle.com/c/costa-rican-household-poverty-prediction/data).

Here's the most recent output of my `sessionInfo()`.

	R version 3.5.0 (2018-04-23)
	Platform: x86_64-apple-darwin15.6.0 (64-bit)
	Running under: macOS High Sierra 10.13.4

	Matrix products: default
	BLAS: /System/Library/Frameworks/Accelerate.framework/Versions/A/Frameworks/vecLib.framework/Versions/A/libBLAS.dylib
	LAPACK: /Library/Frameworks/R.framework/Versions/3.5/Resources/lib/libRlapack.dylib

	locale:
	[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

	attached base packages:
	[1] stats     graphics  grDevices utils     datasets  methods   base     

	other attached packages:
	 [1] xgboost_0.71.2      strapgod_0.0.0.9000 caret_6.0-80        lattice_0.20-35     pROC_1.13.0         randomForest_4.6-14
	 [7] nnet_7.3-12         rpart.plot_3.0.5    rpart_4.1-13        forcats_0.3.0       stringr_1.3.0       dplyr_0.7.99.9000  
	[13] purrr_0.2.5         readr_1.1.1         tidyr_0.8.1         tibble_1.4.2        ggplot2_3.1.0       tidyverse_1.2.1    

	loaded via a namespace (and not attached):
	 [1] nlme_3.1-137       lubridate_1.7.4    dimRed_0.1.0       httr_1.3.1         rprojroot_1.3-2    tools_3.5.0       
	 [7] backports_1.1.2    utf8_1.1.3         R6_2.2.2           lazyeval_0.2.1     colorspace_1.3-2   withr_2.1.2       
	[13] tidyselect_0.2.4   compiler_3.5.0     cli_1.0.0          rvest_0.3.2        xml2_1.2.0         labeling_0.3      
	[19] scales_1.0.0       sfsmisc_1.1-2      DEoptimR_1.0-8     robustbase_0.93-3  digest_0.6.18      rmarkdown_1.9     
	[25] pkgconfig_2.0.2    htmltools_0.3.6    highr_0.6          rlang_0.3.0.9000   readxl_1.1.0       ddalpha_1.3.4     
	[31] rstudioapi_0.7     jsonlite_1.5       ModelMetrics_1.2.2 magrittr_1.5       Matrix_1.2-14      Rcpp_1.0.0        
	[37] munsell_0.5.0      fansi_0.4.0        abind_1.4-5        visdat_0.1.0       stringi_1.2.4      yaml_2.1.19       
	[43] MASS_7.3-49        plyr_1.8.4         recipes_0.1.3      grid_3.5.0         pls_2.7-0          crayon_1.3.4      
	[49] haven_1.1.1        splines_3.5.0      pander_0.6.2       hms_0.4.2          knitr_1.20         pillar_1.3.0      
	[55] reshape2_1.4.3     codetools_0.2-15   stats4_3.5.0       CVST_0.2-2         magic_1.5-9        glue_1.3.0        
	[61] evaluate_0.10.1    data.table_1.11.4  modelr_0.1.1       foreach_1.4.4      cellranger_1.1.0   gtable_0.2.0      
	[67] kernlab_0.9-27     assertthat_0.2.0   DRR_0.0.3          gower_0.1.2        prodlim_2018.04.18 broom_0.5.0       
	[73] e1071_1.7-0        rsconnect_0.8.8    class_7.3-14       survival_2.41-3    geometry_0.3-6     timeDate_3043.102 
	[79] RcppRoll_0.3.0     iterators_1.0.9    lava_1.6.3         ipred_0.9-8 
