# crqa-quickstart-at-ati

Demonstration R code for some recurrence over text and other categorical series.

Demo coded by: Rick Dale, cognaction.org/rick/ 

Shared for: [Nonlinear ATI Summer, 2016 in Cincinnati, OH](http://www.apa.org/science/resources/ati/nonlinear.aspx)

If you find this code useful we encourage you to cite the crqa library publication:
 
> Coco, M. I. & Dale, R. (2014). Cross-recurrence quantification analysis of categorical and continuous time series: an R package. *Frontiers in Quantitative Psychology and Measurement*, *5*, 510.
> [http://journal.frontiersin.org/article/10.3389/fpsyg.2014.00510/full](http://journal.frontiersin.org/article/10.3389/fpsyg.2014.00510/full)

For quick start view the PDF **ATI_Demo_RStudio.pdf**. 

Other code samples:

* **wordFullExample.R**: An example of processing transcript to convert text into numeric series and then perform analysis over it. Also includes an example of LIWC processing for RQA.

* **windowedRQAExample.R**: Using some sample data from Dr. Kentaro Kodama, this code shows how to set a window size and window shift to obtain a time series of RQA measures.

* **handlingSheets.R**: Some further sample R code to do windowed recurrence and work with columns of a CSV file (thanks to Dr. Vicki Dawei Jia for these sample data). These data are categorical.

* **paramSelectionExample.R**: A demonstration of selecting parameters automatically.

* **recodedTextWithIdentityColumn.R**: Using identity at the front of the text line to create a coded pair of time series to do CRQA with transcripts.

If you are fresh to R (and RStudio) see: [https://www.datacamp.com/courses/free-introduction-to-r](https://www.datacamp.com/courses/free-introduction-to-r)

If you have just installed RStudio, you need to install the required packages, like this:

install.packages('crqa')

In the code, when you see library(X), where X is some library loaded by the script, ensure that you carry out this procedure for that library as well: install.packages('X').





