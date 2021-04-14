class ImportFileController < ApplicationController
  def import
    @import_file = ImportFile.new
  end

  def upload
    @import_file = ImportFile.new(import_params)
    @import_file.status = "on hold"
    @import_file.user = current_user
    byebug
    unless @import_file.column || @import_file.valid?
      flash.now[:notice] = "Something went wrong"
      render 'import'
      return
    end
    byebug
    if @import_file.save
      @import_file.processing
      flash[:notice] = "The file was successfully uploaded"
      redirect_to user_imported_files_path
    else
      flash.now[:notice] = "Something went wrong"
      render 'import'
      #return
    end
  end

  private

  def import_params
    params.require(:import_file).permit(:file, column: [:name, :birthdate, :phone, :address, :credit_card, :email])
  end
end
