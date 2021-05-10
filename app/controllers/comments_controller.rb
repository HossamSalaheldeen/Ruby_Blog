class CommentsController < ApplicationController
    # http_basic_authenticate_with name: "hossam", password: "123456", only: :destroy
    before_action :authenticate_user!

    # def new
    #     @comment = Comment.new
    #     # @comment = current_user.comments.build
    # end


    # def create
    #     @article = Article.find(params[:article_id])
    #     @comment = @article.comments.create(comment_params)
    #     redirect_to article_path(@article)
    # end

    def create
        @article = Article.find(params[:article_id])
        @comment = @article.comments.create(comment_params)
        @comment.user_id = current_user.id
        if @comment.save
          redirect_to @article
        else
          flash.now[:danger] = "error"
        end
    end

    def destroy
        @article = Article.find(params[:article_id])
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article)
    end
     
    private
        def comment_params
            params.require(:comment).permit(:commenter, :body)
        end
end
