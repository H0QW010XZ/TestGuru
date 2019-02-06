class TestsController < ApplicationController
  before_action :set_test, only: %i[show edit update destroy start]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_from_test_not_found

  def show; end

  def edit; end

  def index
    @tests = Test.all
  end

  def new
    @test = Test.new
  end

  def create
    @test = current_user.created_tests.new(test_params)

    if @test.save
      redirect_to @test, success: 'Test was created successfully!'
    else
      render :new
    end
  end

  def update
    if @test.update(test_params)
      redirect_to @test, success: 'Test was updated successfully!'
    else
      render :edit
    end
  end

  def destroy
    @test.destroy!
    redirect_to tests_path, success: 'Test was deleted successfully!'
  end

  def start
    current_user.tests.push(@test)
    redirect_to @user.test_passage(@test)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def set_test
    @test = Test.find(params[:id])
  end

  def rescue_from_test_not_found
    render plain: 'Test not found'
  end
end
