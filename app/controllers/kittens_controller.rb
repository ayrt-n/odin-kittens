class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(kitten_params)

    if @kitten.save
      flash[:success] = 'New kitten created! Meow!'
      redirect_to @kitten
    else
      flash.now[:error] = 'Double check your form right meow, there might be some missing info!'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(kitten_params)
      flash[:success] = 'Kitten update successful! Meow!'
      redirect_to @kitten
    else
      flash.now[:error] = 'Double check your form right meow, there might be some missing info!'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Kitten.destroy(params[:id])
    flash[:success] = 'Kitten has been released, meow :('
    redirect_to root_path, status: :see_other
  end

  private

  def kitten_params
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
