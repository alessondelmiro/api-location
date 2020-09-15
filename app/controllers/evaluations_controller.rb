class EvaluationsController < ApplicationController
  def create
    @evaluation = Evaluation.new(evaluation_params.merge(user_id: current_user.id))
    if @evaluation.save_update_general!
      head :created
    else
      render json: {errors: @evaluation.errors }, status: :unprocessable_entity
    end
  end

  def index
    if params[:location_id].present?
      @evaluations = Evaluation.where(location_id: params[:location_id]).order(created_at: :desc)
      apply_scopes
    else
      render json: {errors: "A location must be provided" }, status: :unprocessable_entity
    end
  end

  private

  def apply_scopes
    @evaluations = @evaluations.offset(params[:offset]) if params[:offset].present?
    @evaluations = @evaluations.limit(params[:limit] || 10)
  end

  def evaluation_params
    params.require(:evaluation).permit(:location_id, :rating, :comment)
  end
end
