############
# This script takes the JSTOR bundle directory and a txt list of names to search for
# and produces a single file concatenating all files that match at least 1 of the names.
# It executes in parallel.
###########

# Input
DATA=/data/JSTOR/data.txt
NAMES_FILE=./names_scott_version.csv

# Temp and Output
MATCHING_NAMES=/data/JSTOR/matching_names.txt
UNIQUE_MATCHING_NAMES=/data/JSTOR/uniq_matching_names.txt
MATCHING_FILES=/data/JSTOR/matching_files.txt
UNIQUE_MATCHING_FILES=/data/JSTOR/uniq_matching_files.txt
CONTENT_OUTPUT=/data/JSTOR/content.txt

# Poduce a grep output that contains 1 output for each match of each name in file
echo "counting"
cat $NAMES_FILE | parallel -n4 --pipe grep -o -f - $DATA | tee $MATCHING_NAMES

# Results are not unique, make them so
echo "unique $MATCHING_NAMES to $UNIQUE_MATCHING_NAMES"
cat $MATCHING_NAMES | sort | uniq > $UNIQUE_MATCHING_NAMES

# Now save contents of all matching files into single file
echo catting
cat $UNIQUE_MATCHING_FILES | xargs cat > $CONTENT_OUTPUT
