class PublicationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin_or_author, only: [:update, :edit, :destroy]
  before_action :set_publication, only: [ :show, :edit, :update, :destroy ]
  

  # GET /publications or /publications.json
  def index
    @publications = Publication.all.order(created_at: :desc)   
  end

  # GET /publications/1 or /publications/1.json
  def show
    @publication = Publication.find(params[:id])
    @comments = @publication.comments
  end
  
  # GET /publications/new
  def new
    @publication = Publication.new
  end

  # GET /publications/1/edit
  def edit    
  end

  # POST /publications or /publications.json
  def create
    @publication = Publication.new(publication_params)
    @publication.user = current_user   

    respond_to do |format|
      if @publication.save
        format.html { redirect_to @publication, notice: "Publication was successfully created." }
        format.json { render :show, status: :created, location: @publication }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publications/1 or /publications/1.json
  def update  
    respond_to do |format|
      if @publication.update(publication_params)
        format.html { redirect_to @publication, notice: "Noticia actualizada exitosamente" }
        format.json { render :show, status: :ok, location: @publication }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @publication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publications/1 or /publications/1.json
  def destroy
    @publication.destroy

    respond_to do |format|
      format.html { redirect_to home_index_path, notice: "Publicación eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publication
      @publication = Publication.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def publication_params
      params.require(:publication).permit(:image, :title, :description, :user_id)    
    end
 
    def authorize_admin_or_author
      unless current_user.admin? || (@publication && current_user.id == @publication.user_id)
        redirect_to home_index_path, notice: "No estás autorizado para hacer esta acción"
      end
    end
end


