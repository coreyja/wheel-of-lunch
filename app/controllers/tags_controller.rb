class TagsController < AuthenticatedController
  def index
    @tags = Tag.by_name
  end
end
