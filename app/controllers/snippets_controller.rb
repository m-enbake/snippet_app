class SnippetsController < ApplicationController
  before_action :set_snippet, only: [:show, :edit, :update, :destroy]
  before_filter :set_search
  before_filter :check_private_snippet , only: [:show]


  # GET /snippets
  # GET /snippets.json
  def index
    @search = Snippet.search(params[:q])
    snippets = @search.result
    @snippets = snippets.paginate(:page => params[:page])
  end

  # GET /snippets/1
  # GET /snippets/1.json
  def show
  end

  # GET /snippets/new
  def new
    @snippet = Snippet.new 
  end

  # GET /snippets/1/edit
  def edit
  end

  # POST /snippets
  # POST /snippets.json
  def create
    @snippet = Snippet.new(snippet_params)

    respond_to do |format|
      if @snippet.save
        format.html { redirect_to @snippet, notice: 'Snippet was successfully created.' }
        format.json { render :show, status: :created, location: @snippet }
      else
        format.html { render :new }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /snippets/1
  # PATCH/PUT /snippets/1.json
  def update
    respond_to do |format|
      if @snippet.update(snippet_params)
        format.html { redirect_to @snippet, notice: 'Snippet was successfully updated.' }
        format.json { render :show, status: :ok, location: @snippet }
      else
        format.html { render :edit }
        format.json { render json: @snippet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /snippets/1
  # DELETE /snippets/1.json
  def destroy
    @snippet.destroy
    respond_to do |format|
      format.html { redirect_to snippets_url, notice: 'Snippet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def private_snippet
      @snippet = Snippet.find_by(:slug => params[:slug])
      render 'show'
  end

  def set_search
    @q=Snippet.search(params[:q])
  end

  def recent_snippet
      @snippets = Snippet.last(params[:count])
      respond_to do |format|    
        format.html { redirect_to @snippets, notice: 'Snippet was successfully created.' }
        format.json { render :index, status: 200 }
      end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_snippet
      @snippet = Snippet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def snippet_params
      params.require(:snippet).permit(:snippet_text, :private, :slug)
    end

    def check_private_snippet
      @snippet = Snippet.find params[:id]
      redirect_to root_path if @snippet.private?
    end
end
