# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

    	include CarrierWave::RMagick
    	storage :file
    	def store_dir
      	"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    	end

    	version :large do
    		resize_to_limit(600,600)
  	  end

  	  version :thumb do
    		process :crop
    		resize_to_limit(200,200)
  	  end

      def crop
        if model.crop_x.present?
          resize_to_limit(600,600)
          manipulate! do |img|
            x=model.crop_x.to_i
            y=model.crop_y.to_i
            w=model.crop_w.to_i
            h=model.crop_h.to_i
            img.crop!(x,y,w,h)
          end
        end
      end
end
