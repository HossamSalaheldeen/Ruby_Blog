class ArticlesController < ApplicationController
    # http_basic_authenticate_with name: "hossam", password: "123456", except: [:index, :show]
    load_and_authorize_resource
    # authorize_resource class: false
    before_action :authenticate_user!
    def index
        @articles = Article.all
        # render :json => @articles
    end

    def show
        @article = Article.find(params[:id])
        # render :json => @article
    end
    
    def new
        # @article = Article.new
        @article = current_user.articles.build
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        # @article = Article.new(article_params)
        @article = current_user.articles.build(article_params)
        if @article.save
            redirect_to @article
        else
            render 'new'
        end    
    end

    def update
        @article = Article.find(params[:id])
       
        if @article.update(article_params)
          redirect_to @article
        else
          render 'edit'
        end
    end

    
    def destroy 
        @article = Article.find(params[:id])
        @article.destroy
    
        redirect_to articles_path
    end

    private
    def article_params
        params.require(:article).permit(:title, :text)
    end
end
