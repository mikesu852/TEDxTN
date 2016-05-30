class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :prepare_meta_tags, if: "request.get?"

  protected
    def prepare_meta_tags(options={})
      site_name   = "TEDxTainan"
      title       = "TEDxTainan"
      description = "TEDxTainan"
      image       = options[:image] || "your-default-image-url"
      current_url = request.url
      defaults = {
        site:        site_name,
        title:       title,
        image:       image,
        description: description,
        og: {
          url: current_url,
          site_name: site_name,
          title: title,
          image: image,
          description: description,
          type: 'website'
        }
      }

      options.reverse_merge!(defaults)
      set_meta_tags options
    end

  private
  	def current_user
    	@current_user ||= session[:user_id] && User.find(session[:user_id])
  	end

  	def check_login
    	if !current_user
      		redirect_to root_path
    	end
  	end

  	helper_method :current_user,:check_login
end
