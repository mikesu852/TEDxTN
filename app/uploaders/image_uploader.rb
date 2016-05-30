# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #def filename
  #  "#{model.class.to_s.underscore}#{model.id}_thumb.#{file.extension}"
  #end

  version :large do
    resize_to_fill(1600,900)
  end

  version :square do
    resize_to_fill(960,960)
  end

end
