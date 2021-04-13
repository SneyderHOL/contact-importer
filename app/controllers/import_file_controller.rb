class ImportFileController < ApplicationController
  def import
    @import_file = ImportFile.new
  end

  def upload
    @import_file = ImportFile.new(import_params)
    @import_file.status = "on hold"
    @import_file.user = current_user
    headers = []
    @import_file.column.select do |key, value|
      headers.push(value.to_i)
    end
    byebug
    headers.sort!
    if headers != (1..6).to_a
      flash.now[:notice] = "The headers do not match, please try again"
      render 'import'
      return
    end
    
  end

  private

  def import_params
    params.require(:import_file).permit(:file, column: [:name, :birthdate, :phone, :address, :credit_card, :email])
  end
end
