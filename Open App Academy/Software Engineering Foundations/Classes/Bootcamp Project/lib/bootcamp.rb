class Bootcamp
    def initialize(name, slogan, student_capacity)
        @name = name
        @slogan = slogan
        @student_capacity = student_capacity
        @teachers = []
        @students = []
        @grades = Hash.new{|h, k| h[k] = []}
    end
    def name
        return @name
    end
    def slogan
        return @slogan
    end
    def teachers
        return @teachers
    end
    def students
        return @students
    end
    def hire(teacher)
        @teachers << teacher
    end
    def enroll(student)
        if @students.length >= @student_capacity
            return false
        else
            @students << student
            return true
        end
    end
    def enrolled?(student)
        return students.include?(student)
    end
    def student_to_teacher_ratio
        return (students.length/teachers.length).round
    end
    def add_grade(student, grade)
        if enrolled?(student)
            @grades[student] << grade
            return true
        else
            return false
        end
    end
    def num_grades(student)
        return @grades[student].length
    end
    def average_grade(student)
        if enrolled?(student)
            total = 0;
            @grades[student].each do |g|
                total+= g
            end
            if total == 0
                return nil
            else
                return (total/num_grades(student)).round
            end
        else
            return nil
        end
    end
end