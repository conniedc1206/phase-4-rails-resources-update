class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    # find the bird that matches the ID from the route params
    bird = Bird.find_by(id: params[:id])
    # update the bird using the params from the body of the request
    if bird
      bird.update(bird_params)
      render json: bird
    else
      render json: {error: "Bird not found"}, status: :not_found
    end
  end

  # we can provide a custom route that will do the work of calculating the number of likes and incrementing it. With this approach, all the frontend has to do is send a request to our new custom route, without worrying about sending any data in the body of the request.
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: "Bird not found"}, status: :not_found
    end
  end
  # by creating this custom route, we are breaking the REST conventions we had been following up to this point. One alternate way to structure this kind of feature and keep our routes and controllers RESTful would be to create a new controller, such as Birds::LikesController, and add an update action in this controller.

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
