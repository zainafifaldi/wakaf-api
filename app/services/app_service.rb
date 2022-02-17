class AppService
  class << self
    def call(*args)
      new(*args).call
    end
  end

  def user?
    current_user_or_guest&.is_a?(User)
  end
end
