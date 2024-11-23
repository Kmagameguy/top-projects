class KittensController < ApplicationController
  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = 'Kitten created!'
      redirect_to @kitten
    else
      flash.now[:error] = 'Kitten not created!'
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:success] = 'Kitten updated!'
      redirect_to @kitten
    else
      flash.now[:error] = 'Kitten not updated!'
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def destroy
    @kitten = Kitten.find(params[:id])

    if @kitten.destroy
      flash[:success] = 'Kitten deleted!'
      redirect_to root_path
    else
      flash.now[:error] = 'Kitten not deleted!'
      render :show, status: :unprocessable_entity
    end
  end

  def index
    @kittens = Kitten.all
  end

  def show
    @kitten = Kitten.find(params[:id])
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
