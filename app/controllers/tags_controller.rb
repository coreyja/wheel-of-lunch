class TagsController < AuthenticatedController
  def index
    @tags = Tag.by_name
  end

  def show
    @tag = Tag.find(params[:id])
  end
end
