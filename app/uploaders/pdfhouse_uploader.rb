class PDFHouseUploader < CarrierWave::Uploader::Base
  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  include CarrierWave::MimeTypes
  process :set_content_type

  def store_dir
    "public/pdffiles"
  end

  def cache_dir
    "/tmp/uploads"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w(pdf)
  end
end