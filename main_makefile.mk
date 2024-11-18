# Define directories
DATA_DIR := /home/user/project_dir/data
OUTPUT_DIR := /home/user/project_dir/output

# Step 1: Clean raw data using Python script
$(OUTPUT_DIR)/clean_data.csv: clean_data.py $(DATA_DIR)/raw_data.csv
	python clean_data.py --input $< --output $@

# Step 2: Analyze the cleaned data using R
$(OUTPUT_DIR)/analysis_results.csv: $(OUTPUT_DIR)/clean_data.csv analyze_data.R
	Rscript analyze_data.R --input $< --output $@

# Step 3: Generate the final PDF report using Stata
$(OUTPUT_DIR)/final_report.pdf: $(OUTPUT_DIR)/analysis_results.csv generate_report.do
	stata -b do generate_report.do

all: $(OUTPUT_DIR)/final_report.pdf
### Last line needed to ensure final report is always generated
### Even if a file called "all" exists in directory
.PHONY: all