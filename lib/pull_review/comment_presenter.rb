module PullReview
  class CommentPresenter
    def initialize(comment)
      @comment = comment
    end

    def to_a
      [
        comment.fetch('user').fetch('login'),
        comment.fetch('created_at'),
        comment.fetch('body').split("\n"),
        ''
      ].flatten
    end

    private
    attr_reader :comment
  end
end
