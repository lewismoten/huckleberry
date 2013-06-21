class ProfilesController < AuthenticatedController
  # GET /profiles
  # GET /profiles.json
  def index
    @profile_users = User.order('name asc').limit(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  def show
    @user = User.find_by_initials(params[:initials])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def approve
    if current_user.is_admin?

      @user = User.find_by_initials(params[:initials])
      @user.update_attributes(approved: true)
    else
      @user.update_attributes(email: 'youre not admin')
    end

    redirect_to users_path

  end

end