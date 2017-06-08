class FeedbacksController < ApplicationController
	# def new 
	# 	@feedback = Feedback.new
	# end

	def create
		@feedback = Feedback.new(feedback_params)
		@feedback.save
		flash[:feedback] = "Ваша заявка принята, мы свяжемся с вами как можно быстрее"
		redirect_to root_path
	end

	private 

	  def feedback_params
	    params.require(:feedback).permit(:name, :email, :comment)
	  end 
end
