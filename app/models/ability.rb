class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
    can :index, Search
  end

  def admin_abilities
    can :manage, :all
  end

  def user_abilities
    guest_abilities
    can :create, [Question, Answer, Comment]
    can :update, [Question, Answer, Comment], user_id: user.id
    can :destroy, [Question, Answer, Comment], user_id: user.id

    can [:vote_up, :vote_down], [Question, Answer] do |subject|
      subject.user != user && !user.voted?(subject)
    end

    can :vote_cancel, [Question, Answer] do |subject|
      user.voted?(subject)
    end

    can :best, Answer do |subject|
      user.author_of?(subject.question) && !subject.best?
    end

    can :destroy, Attachment do |subject|
      user.author_of?(subject.attachable)
    end

    can :me, User, user_id: user.id
    can :index, User

    can :subscribe, Question do |subject|
      !user.subscribed?(subject)
    end

    can :unscribe, Question do |subject|
      user.subscribed?(subject)
    end
  end
end
