# -*- coding: utf-8 -*-
class CategoriesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user, except: [:show, :index]
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.founder = current_user
    if @category.save
      flash[:success] = "新建成功"
      redirect_to index_for_admin_categories_path
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
    render 'new'
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      redirect_to index_for_admin_categories_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.all.sort_by {|category| category.brands.count}.reverse
  end

  def index_for_admin
    @categories = Category.all
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to index_for_admin_categories_path
  end
end
