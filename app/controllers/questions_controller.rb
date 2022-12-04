class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_question, only: %i[show destroy update edit]

  def index
    @questions = Question.all
  end

  def show
    @answer = @question.answers.new
    @answers = @question.answers.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: "Your question successfully created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path, notice: "Your question successfully deleted"
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end


  def new_question
    @question = Question.new
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
