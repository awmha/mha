class StaticPagesController < ApplicationController
  layout "public"
  
  def home
    @projects = Project.all
  end

  def test
    @projects = Project.all
  end

  def test2
    @projects = Project.all
  end

  def contact
    @projects = Project.all
  end
end