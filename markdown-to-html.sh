#!/bin/bash

OUTPUT_DIR="blog"  # Output directory for generated HTML files
INDEX_FILE="blog/index.html"  # Output file for the index file

# Loop through all markdown files in the source directory
for FILE in source/*.md; do
  # Generate HTML file from markdown
  OUTPUT_FILE="$OUTPUT_DIR/$(basename "${FILE%.md}.html")"
  pandoc "$FILE" -o "$OUTPUT_FILE"
done


# Wrap the index file with HTML structure
echo "<html>
<head>
  <title>Blog Index</title>
</head>
<body>
  <h1>Blog Index</h1>
    <nav>
      <ul>" > temp.html

for FILE in blog/*.html; do
  if [[ "$FILE" == "blog/index.html" ]]; then
    continue
  fi
  echo "<li><a href= $(basename "$FILE")>" >> temp.html
  echo "$(basename "${FILE%.*}")</a></li>" >> temp.html
done

echo "</ul></nav></body>
</html>" >> temp.html

mv temp.html "$INDEX_FILE"
