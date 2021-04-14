class UserController < ApplicationController
  def imported_files
    @user = current_user
    @user.import_files
    @imported_files = ImportFile.paginate(page: params[:page], per_page: 10)
  end
end
