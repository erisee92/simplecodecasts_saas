class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :select_plan, only: :new
  
  def create
    super do |resource|
      if params[:plan]
        resource.plan_id = params[:plan]
        if resource.plan_id == 2
          resource.save_with_payment
        else
          resource.save
        end
      end
    end
  end
  
  def destroy
    @user = current_user
    if @user.stripe_customer_token
      puts "Test20"
      customer = Stripe::Customer.retrieve(@user.stripe_customer_token)
      customer.cancel_subscription()
    end
    if @user.destroy
      flash.alert = "Your subscription and account has been cancelled successfully!"
      redirect_to root_path
    end
  end
  
  private
    def select_plan
      unless params[:plan] && (params[:plan] == '1' || params[:plan] == '2')
        flash[:notice] = "Please select a membership plan to sign up."
        redirect_to root_url
      end
    end
end