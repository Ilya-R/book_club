class CommentsController < ApplicationController
  before_action :set_book, only: %i[create destroy]
  before_action :set_comment, only: [:destroy]

  def create
    @new_comment = @book.comments.build(comment_params)
    @new_comment.user = current_user

    if user_signed_in? && @new_comment.save
      redirect_to @book, notice: 'Ваш комментарий сохранен'
    else
      redirect_to @book, alert: 'Не удалось сохранить ваш комментарий'
    end
  end

  def destroy
    if current_user_can_edit?(@comment) && @comment.destroy
      redirect_to @book, notice: 'Комментарий был успешно удален'
    else
      redirect_to @book, alert: 'Не удалось удалить комментарий'
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_book
    @book = Book.all.where(id: params[:book_id]).take
  end
end
