require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end
    def valid_title?(title)
        return @salaries.include?(title)
    end
    def > (startup)
        return self.funding > startup.funding
    end
    def hire(employee_name, title)
        if valid_title?(title)
            new_employee = Employee.new(employee_name, title)
            @employees << new_employee
        else
            raise 'An error has occured'
        end
    end
    def size
        return @employees.length
    end
    def pay_employee(employee)
        salary = @salaries[employee.title]
        if salary <= @funding
            employee.pay(salary)
            @funding-= salary
        else
            raise "An error has occured"
        end
    end
    def payday
        @employees.each {|e| pay_employee(e) }
    end
    def average_salary
        total = 0.0
        @employees.each { |employee| total += @salaries[employee.title] }
        return total / @employees.length
    end
    def close
        @employees = []
        @funding = 0
    end
    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |k, v|
            @salaries[k] = v if @salaries[k] == nil
        end
        @employees += startup.employees
        startup.close
    end
end