class StudentsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_error_message
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_error_message

    def index
        students = Student.all
        render json: students, status: :ok
    end

    def show
        student = find_student
        render json: student, status: :ok
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student, status: :ok
    end

    def destroy
        student = find_student
        student.destroy
        render status: :no_content
    end

    private

    def find_student
        Student.find(params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end
end
