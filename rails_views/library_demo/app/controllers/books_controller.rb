class BooksController < ApplicationController

  def index
    # @books is an instance variable and it makes it available to index views
    @books = Book.all
    render :index # index view /app/views/books/index.html.erb
  end

  def show
    @book = Book.find_by(id: params[:id])

    if @book
      render :show # show view
    else
      # render :index or
      # redirects to the GET /books route (index)
      redirect_to books_url
    end
  end

  def new
    @book = Book.new
    render :new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      # show user the book show page
      redirect_to book_url(@book)
    else
      # show user the new book form
      render :new
    end
  end

  def edit
    # params[:id] gets the id from the route GET /books/:id/edit books#edit
    @book = Book.find_by(id: params[:id])
    render :edit
  end
  
  def update
    # params[:id] gets the id from the route PATCH /books/:id/ books#update
    @book = Book.find_by(id: params[:id])

    # update_attribute will try to change and save the updates to book
    if @book.update_attributes(book_params)
      # redirect to book show page
      redirect_to book_url(@book)
    else
      render :edit
    end
  end

  private
  # only allows users to insert values into these parameters
  def book_params
    params.require(:book).permit(:title, :author, :year, :description, :category)
  end

end
