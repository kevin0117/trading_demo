class CommoditiesController < ApplicationController
  before_action :find_commodity, only: %i[edit show update destroy]
  
  def index
    @commodities = Commodity.order(id: :desc)
    @commodity = Commodity.new
  end

  def new
    @commodity = Commodity.new
  end

  def create
    @commodity = Commodity.new(commodity_params)
    @commodity.user_id = current_user.id
    
    if @commodity.save
      SendCommodityWorker.perform_async(@commodity.id)
      redirect_to commodities_path, notice: "新增成功"
    else
      render :new
    end
  end

  def update
    if @commodity.update(commodity_params)
      redirect_to commodities_path, notice: "更新成功"
    else
      render :edit
    end
  end

  def destroy
    if @commodity.may_cancel?
      RemoveCommodityWorker.perform_async(@commodity.id)
      @commodity.destroy
      @commodity.cancel!
      redirect_to commodities_path, notice: "取消成功"
    else
      redirect_to commodities_path, notice: "此委託單已成交"
    end
  end

  def deal
    @commodity = Commodity.find_by(id: params[:id])
    if @commodity && @commodity.trade!
      @commodity.closer_id = current_user.id
      @commodity.save
      RemoveCommodityWorker.perform_async(@commodity.id)

      # 寄給結單使用者
      MailWorker.perform_async(@commodity.closer_id)
      # 寄給掛單委託者
      MailWorker.perform_async(@commodity.user_id)
      # 寄給系統管理員
      MailAdminWorker.perform_async(1, @commodity.user_id, @commodity.closer_id)
      redirect_to commodities_path, notice: "下單成功"
    else
      redirect_to commodities_path, notice: "下單失敗"
    end
  end

  def edit; end
  def show; end

  private

  def find_commodity
    @commodity = Commodity.find(params[:id])
  end

  def commodity_params                                                            
    params.require(:commodity).permit(:title,
                                      :quantity, 
                                      :status, 
                                      :price, 
                                      :action)
  end
end
