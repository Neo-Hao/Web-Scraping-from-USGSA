Web-Scraping-from-USGSA
=======================

<h2>Purpose:</h2>

Web scraping from US General Service Administration Website: http://www.reginfo.gov

The website of US General Service Administration contains rich and detailed information of regulation and rules made by different government branches over years.

A sample rule would be like: http://www.reginfo.gov/public/do/eAgendaViewRule?pubId=200210&RIN=1125-AA38

<strong>Title:</strong> Protective Orders in Immigration Administration Proceedings<br>
<strong>Abstract:</strong> This rule amends regulations governing the Executive Office for Immigration Review (EOIR) by authorizing immigration judges to issue protective orders to limit public disclosure of sensitive law enforcement ...<br>
<strong>Timetable:</strong> ...

The information in timetable is important and valuable for many researchers working in public administration, but the website doesn't provide a convenient way for people to view all this type of data, namely action of a rule and its matched date, on a single page.

This project can help scrap all this type of data in the following format:

<strong>Column Name:</strong> Action,    Date,    RIN<br>
<strong>Row 1:</strong>        ...<br>
<strong>Row 2:</strong>        ...

<h2>Usage:</h2>

To use the script of this project, you have to make sure you have R (http://www.r-project.org/) installed on either your PC or Mac, and follow the following steps:

1. Download the all the files and put them in the working directory of R
2. Make sure all files are in the same folder
2. Ran the whole script first
3. Run the function totalData(start, end); you have to specify the start and end parameters as the integeters, and their range is from 1 to 43150.

By the way, if you are curious where the RIN number data was retrieved, you can check <a href="http://www.reginfo.gov/public/do/eAgendaSearchResult" target="_blank">this page</a>. Click "Download All RIN Data in XML", you will get a XML file. We get all the RIN numbers from the XML file.


<h2>Warning:</h2> 

Please <strong>BE SURE</strong> to check with US General Service Administration with their specification about web scraping before you use this script. 

