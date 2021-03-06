class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
  
    def show?
      @user.has_role?(:admin) || @record.course.user == @user || @record.course.bought(@user) == false
    end
    
    def edit?
      @record.course.user_id == @user.id
    end
    
    def update?
      @record.course.user_id == @user.id
    end
    
    def new?
      # @record.course.user == @user
    end
    
    def create?
      @record.course.user_id == @user.id
    end
    
    def destroy?
      @record.course.user == @user
    end
end
