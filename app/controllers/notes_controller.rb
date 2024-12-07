class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]

  def index
    # Base query
    @notes = Note.all

    # Filtro de búsqueda por título o contenido
    if params[:query].present?
      @notes = @notes.where("title LIKE ? OR content LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    # Ordenar según el parámetro recibido
    case params[:order]
    when 'recent-desc'
      @notes = @notes.order(created_at: :desc)
    when 'recent-asc'
      @notes = @notes.order(created_at: :asc)
    when 'alpha-asc'
      @notes = @notes.order(title: :asc)
    when 'alpha-desc'
      @notes = @notes.order(title: :desc)
    else
      @notes = @notes.order(created_at: :desc) # Orden predeterminado
    end

    # Agrupar por mes y año
    @notes_by_month = @notes.group_by { |note| note.created_at.strftime("%B %Y") }
  end

  def show; end

  def new
    @note = Note.new
  end

  def edit; end

  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.html { redirect_to notes_url, notice: "Nota creada exitosamente." }
        format.json { render :index, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: "Nota actualizada exitosamente." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Nota eliminada exitosamente." }
      format.json { head :no_content }
    end
  end

  private

  def set_note
    @note = Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title, :body, :content)
  end
end
