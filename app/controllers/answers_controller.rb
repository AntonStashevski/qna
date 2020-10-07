class AnswersController < ApplicationController
  before_action :find_question, only: %i[index create]
  before_action :find_answer, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @answers = @question.answers
  end

  def show; end

  def new; end

  def edit; end

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    redirect_to @question, notice: 'Your answer successfully created.' if @answer.save
  end

  def update
    if current_user.author?(@answer) && @answer.update(answer_params)
      redirect_to @answer.question, notice: 'Your answer successfully updated.'
    end
  end

  def destroy
    if current_user.author? @answer
      @answer.destroy
      flash[:notice] = 'Your answer successfully deleted.'
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end
