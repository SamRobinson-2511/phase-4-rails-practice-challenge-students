class InstructorsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :instructor_not_found
rescue_from ActiveRecord::RecordInvalid, with: :instructor_invalid


    def index
        render json: Instructor.all, include: :students, status: 200
    end

    def show
        instructor = find_instructor
        render json: instructor, include: :students, status: 200
    end

    def create
        instructor = Instructor.create!(instructor_params)
        render json: instructor, include: :students, status: :created
    end

    def update
        instructor = find_instructor
        instructor.update!(instructor_params)  
        render json: instructor, include: :students, status: 204
    end

    def destroy 
        instructor = find_instructor
        instructor.destroy
        head :no_content
    end



    private

    def instructor_params
        params.require(:instructor).permit(:id, :name)
    end

    def instructor_invalid invalid_instructor
        render json: { errors: invalid_instructor.record.errors.full_messages}, status: 422
        
    end

    def instructor_not_found
        render json: { errors: ['Instructor not found']}, status: :not_found
    end

    def find_instructor
        Instructor.find(params[:id])
    end

end
