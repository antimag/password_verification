class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy, :forgot_password, :edit_password, :verify_password,:update_password]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  # POST /employers.json
  def create
    @employer = Employer.new(employer_params)

    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employers/1
  # PATCH/PUT /employers/1.json
  def update
    respond_to do |format|
      if @employer.update(employer_params)
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employers/1
  # DELETE /employers/1.json
  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to employers_url, notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def forgot_password
    @employer.generate_password_token
    EmployerMailer.send_password_link(@employer).deliver
    redirect_to root_path, notice: "Update password link has been sent to your email."
  end


  def verify_password
    if @employer.password_token_valid?(params[:password_token])

      redirect_to(edit_password_path(@employer))
    else
      redirect_to employers_url, notice: "Invalid reset password token"
    end
  end

  def edit_password
    
  end

  def update_password
    if @employer.update_attributes(password: employer_params[:password], password_confirmation: employer_params[:password_confirmation], pwd_link_expiry_date: Time.now)
      redirect_to root_path, notice: "Password updated successfully."
    else
      render "edit_password"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employer
      @employer = Employer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employer_params
      params.require(:employer).permit(:name, :email, :password, :password_confirmation, :age, :gender)
    end
end
