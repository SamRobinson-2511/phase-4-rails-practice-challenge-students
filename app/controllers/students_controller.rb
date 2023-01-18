class StudentsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :student_not_found


    def index
        render json: Student.all, include: :instructor, status: 200
    end

    def show
        student = find_student
        render json: student, include: :instructor, status: 200
    end

    def create
        student = Student.create!(student_params)
        render json: student, include: :instructor, status: :created
    end

    def update
        student = Student.update!(student_params)
        render json: student, include: :instructor, status: 204
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end


    private
    def student_params
        params.require(:student).permit(:name, :age, :major, :instructor_id )
    end

    def student_not_found
        render json: { errors: ['student not found']}, status: 404
    end

    def find_student
        Student.find(params[:id])
    end
end
