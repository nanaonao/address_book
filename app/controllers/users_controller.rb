class UsersController < ApplicationController

  def index
    # Userモデルの全てのデータを取得して@usersに代入する
    @users = User.all
  end
# 新規登録画面が表示された時に呼ばれるアクション
  def new
    # Userというモデルオブジェクトを生成して@userに入れる
    # インスタンス変数を使うことで、コントローラーからビューに値を渡せる
    @user = User.new

  end
 # 新規登録ボタンを押された時に呼ばれるアクション
  def create
    # フォームから送られてきたデータを使ってUserモデルを生成し、@userに入れる
    # user_paramsは下のprivate欄に詳細あり
    @user = User.new(user_params)
    # データベースに保存
    if @user.save
    # ユーザー一覧画面にリダイレクト
    # users_pathとは　rake routes（routes.rbで定義したルーティングを、
    # ターミナルで確認することができるコマンド）を打った時に出てくる、
    # 飛ばしたいアクションのPrefixに「_path」をつけることで、パス指定が簡単できる
    # ちなみにプロゲートでやったのは「redirect_to URL指定」。もちろんURL指定でも動く。
      redirect_to users_path
    else
      # 別のアクションを経由せず（ルーテイングを通らず）に、直接ビューを表示する
      # (redirect_toとの違いはルーテイングを通るか否か)
      render "new"
    end
  end
  # 編集画面に遷移した時に呼ばれるアクション
  def edit
    # 渡されるusersテーブルのidを元に、Usersテーブルからデータを持ってきて@userに入れる
    @user = User.find(params[:id])
  end
  # updateボタンが押された時に呼ばれるアクション
  def update
    @user = User.find(params[:id])
    # フォームから送られてきたデータ(user_params)
    if @user.update(user_params)
      redirect_to users_path
    else
      render "edit"
    end
  end
  # 詳細ボタンが押された時に呼ばれるアクション
  def show
    @user = User.find(params[:id])
  end
  # 削除ボタンが押された時に呼ばれるアクション
  def destroy
    # 削除したいデータをidによって検索し、@userに入れる
    @user = User.find(params[:id])
    # destroyアクションでデータベースからデータを削除
    @user.destroy
    # 削除後、一覧画面に遷移する
      redirect_to users_path
  end

  # このコントローラ内からのみ、呼ぶことができる(スコープ指定)
  private
  # フォームから不正なデータが送られてきても、
  # 指定された項目しかデータベースに保存、更新されないようにする
  def user_params
    params[:user].permit(:name, :phone)
  end



end
