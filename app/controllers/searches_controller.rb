class SearchesController < ApplicationController
    def search
        find = params[:search]
        if User.find_by_email(find)
            redirect_to bienvenue_path
        else
            flash[:error]="there isn't user with this name"
            redirect_to request.referer    
        end
    end    
end
