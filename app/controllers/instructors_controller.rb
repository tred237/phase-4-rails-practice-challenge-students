class InstructorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error_message
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error_message

    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = find_instructor
        render json: instructor, status: :ok
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)
        render json: instructor, status: :ok
    end

    def destroy
        instructor = find_instructor
        instructor.destroy
        instructor.students.map{|s| s.update!(instructor_id: Instructor.all.sample.id)}
        render status: :no_content
    end

    private

    def find_instructor
        Instructor.find(params[:id])
    end

    def instructor_params
        params.permit(:name)
    end
end
