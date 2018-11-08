## Medical Costs Personal Datasets

Kaggle dataset taken from [here](https://www.kaggle.com/mirichoi0218/insurance/kernels).

Interesting, related links [here](https://www.healthcare.gov/how-plans-set-your-premiums/).

### Requirements

To knit the analysis in RStudio yourself, make sure you have done this.

	install.packages(c("tidyverse", "knitr", "skimr", "GGally", "visdat", "huxtable"))

The output of my most recent `sessionInfo()`

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
	 [1] visdat_0.1.0      GGally_1.4.0      skimr_1.0.3       knitr_1.20        forcats_0.3.0     stringr_1.3.0     dplyr_0.7.99.9000
	 [8] purrr_0.2.5       readr_1.1.1       tidyr_0.8.1       tibble_1.4.2      ggplot2_3.0.0     tidyverse_1.2.1  

	loaded via a namespace (and not attached):
	 [1] tidyselect_0.2.4   reshape2_1.4.3     haven_1.1.1        lattice_0.20-35    colorspace_1.3-2   viridisLite_0.3.0 
	 [7] htmltools_0.3.6    yaml_2.1.19        utf8_1.1.3         rlang_0.2.2.9001   huxtable_4.0.0     pillar_1.2.2      
	[13] foreign_0.8-70     glue_1.3.0         withr_2.1.2        RColorBrewer_1.1-2 modelr_0.1.1       readxl_1.1.0      
	[19] plyr_1.8.4         munsell_0.5.0      gtable_0.2.0       cellranger_1.1.0   rvest_0.3.2        psych_1.8.4       
	[25] evaluate_0.10.1    labeling_0.3       parallel_3.5.0     broom_0.4.4        Rcpp_0.12.18       scales_1.0.0      
	[31] backports_1.1.2    jsonlite_1.5       mnormt_1.5-5       hms_0.4.2          digest_0.6.15      stringi_1.2.4     
	[37] grid_3.5.0         rprojroot_1.3-2    cli_1.0.0          tools_3.5.0        magrittr_1.5       lazyeval_0.2.1    
	[43] crayon_1.3.4       pkgconfig_2.0.2    rsconnect_0.8.8    xml2_1.2.0         lubridate_1.7.4    reshape_0.8.7     
	[49] assertthat_0.2.0   rmarkdown_1.9      httr_1.3.1         rstudioapi_0.7     R6_2.2.2           nlme_3.1-137      
	[55] compiler_3.5.0

