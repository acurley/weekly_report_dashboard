# Weekly Report Dashboard

### Data Preparation
When preparing a new week's worth of data, create a new directory in Dropbox/dashboard_work/weekly_report_data with today's date in the following format: YYYY-MM-DD.

* 50F Report
	* Export from Jenark as PDF
	* Open PDF in Adobe Acrobat
	* Extract Last Page
	* Convert last page to XML with OCR turned on.
	* Save file as 50f.xml
	* Delete original PDF
* 81F Report
	* Print from Jenark
	* Open PDF in Adobe Acrobat
	* Tools => Pages => Extract all pages
	* Delete original Jenark PDF.
	* Run "Export Directory to XML" action
* Activity Report
	* Export "Reasons Analysis" from Jenark.
	* Extract all pages
	* Delete original

	

### Assumptions
1.  Property#phases won't change.  If so, this value must be manually updated.  Source of this data is the 50F report and the Marketing Director's assessment.
2.  Property#total_units won't change.  If so, this value must be manually updated. Source of value is the 50F report.
3.  If new properties are added, the software might fail if there is a new alternate name that is not registered.