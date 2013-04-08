class SessionsController < ApplicationController
  skip_before_filter :ensure_user, only: :create

  def create
    user = User.create
    cookies.permanent.signed[:id] = user.id

    redirect_back_or(root_path)
  end
end
