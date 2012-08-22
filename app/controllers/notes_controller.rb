class NotesController < ApplicationController
  
  before_filter :course_from_course_id
  
  # GET /courses/:course_id/notes
  # GET /courses/:course_id/notes.json
  def index
    @notes = @course.notes

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /courses/:course_id/notes/1
  # GET /courses/:course_id/notes/1.json
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /courses/:course_id/notes/new
  # GET /courses/:course_id/notes/new.json
  def new
    @note = @course.notes.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /courses/:course_id/notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /courses/:course_id/notes
  # POST /courses/:course_id/notes.json
  def create
    @note = Note.new(params[:note])

    respond_to do |format|
      if @note.save
        format.html { 
          redirect_to course_note_path(@course, @note), 
                      notice: 'Note was successfully created.' 
        }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /courses/:course_id/notes/1
  # PUT /courses/:course_id/notes/1.json
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to course_note_path(@course, @note), notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/:course_id/notes/1
  # DELETE /courses/:course_id/notes/1.json
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.html { redirect_to course_notes_path(@course) }
      format.json { head :no_content }
    end
  end
  
  private
  
    def course_from_course_id
      @course = Course.find params[:course_id]
    end
    
end
