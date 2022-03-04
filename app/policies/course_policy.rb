class CoursePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
    
    def edit?
      @user.has_role?(:admin)
    end
  end
end
