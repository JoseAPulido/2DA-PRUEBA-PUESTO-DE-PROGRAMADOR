class LanguageController < ApplicationController
  def switch
    locale = params[:locale].to_sym
    if I18n.available_locales.include?(locale)
      session[:locale] = locale
    end
    redirect_to request.referer || root_path
  end
end
