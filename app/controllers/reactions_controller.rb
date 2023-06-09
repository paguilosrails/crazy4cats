class ReactionsController < ApplicationController
    def new_user_reaction
      @user = current_user
      @type = params[:reaction_type]
      @publication = Publication.find(params[:publication_id]) if params[:publication_id]
      @kind = params[:kind]
  
      respond_to do |format|
        if @type == "publication"
          reaction_publication = Reaction.find_by(user_id: @user.id, publication_id: @publication.id)
          if reaction_publication
            format.html { redirect_to publication_path(@publication), notice: 'Ya reaccionaste a esta publicación' }
          else
            @reaction = Reaction.new(user_id: @user.id, publication_id: @publication.id, reaction_type: @type, kind: @kind)
            if @reaction.save
              format.html { redirect_to publication_path(@publication), notice: 'Reacción creada exitosamente' }
            else
              format.html { redirect_to publication_path(@publication), notice: 'Algo falló' }
            end
          end
        else
          format.html { redirect_to root_path, notice: 'Tipo de reacción inválido' }
        end
      end
    end
  end
  
