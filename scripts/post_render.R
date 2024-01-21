# Load the required library
if (!requireNamespace("renderthis", quietly = TRUE)) {
  install.packages("renderthis")
}
library(renderthis)

# List all '.slides.html' files in the '_site/slides/' directory
slide_files <- list.files(path = "~/Library/Mobile Documents/com~apple~CloudDocs/LittleMonkeyiCloudHub/A-Teaching/PS52007D_2023-4/_site/content/Week06", pattern = "\\.slides\\.html$", recursive = TRUE, full.names = TRUE)

# Exclude 'index.slides.html'
slide_files <- slide_files[!grepl("index\\.slides\\.html$", slide_files)]


# Print for debugging
print(paste("Slide Files found: ", length(slide_files)))

# Check if any '.slides.html' files are found
if (length(slide_files) == 0) {
  print("No '.slides.html' files found.")
} else {
  # Loop through each '.slides.html' file and convert it to PDF
  for (slide_path in slide_files) {
    # Print for debugging
    print(paste("Processing: ", slide_path))
    
    # Generate the PDF file name (same name as the HTML file but with a .pdf extension)
    path_sans_ext <- sub("\\.slides\\.html$", "", slide_path)
    path_sans_int <- sub("\\_site\\/", "", path_sans_ext)
    pdf_path <- paste0(path_sans_ext, ".pdf")
    png_path <- paste0(path_sans_int, ".png")
    
    # Set the 'complex' flag based on your requirements (TRUE or FALSE)
    complex <- FALSE
    
    # Convert the slide to PDF
    renderthis::to_pdf(slide_path, to = pdf_path, complex_slides = complex)
    
    # Print a message indicating the PDF has been generated
    print(paste("PDF generated:", pdf_path))
    
    # Produce Preview image as png
    renderthis::to_png(slide_path, to = png_path, keep_intermediates = TRUE)
  }
}

