class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
        can :manage, :all
    elsif user.role? :instructor 
        can :update, Instructor do |instructor|
            instructor.id == user.instructor_id
        end
        can :update, User do |u|
            user.id == u.id
        end
        can :read, Instructor
        can :read, Camp
        can :read, Family
        can :read, Location
        can :read, Student do |student|
            # instructor can only view students who they are teaching
            user.instructor.camps.map{|c| c.students.map(&:id)}.flatten.include?(student.id)
        end
    else
        can :read, Camp do |camp|
            Camp.upcoming.to_a.map(&:id).include?(camp.id)
        end # make it this specific?
        can :read, Instructor
        can :read, Location
    end


    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/bryanrite/cancancan/wiki/Defining-Abilities
  end
end
