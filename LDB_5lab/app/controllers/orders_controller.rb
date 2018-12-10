class OrdersController < ApplicationController
  def index
    @my_orders = []
    projs = Project.where(manager: current_user['email'])
    projs.each do |proj|
      @my_orders.push(Order.where(projid: proj.id))
    end
    @my_orders
  end

  def show
  end

  def new
  end

  def create
    if params[:order]
      Order.create(date: DateTime.current, cost: params[:ppu].to_f*params[:order][:qty].to_f, provider: params[:order][:provider], vat: params[:order][:vat], recvaccount: params[:order][:recvaccount], contactname: params[:order][:contactname], qty: params[:order][:qty], unit: params[:order][:unit], material: params[:order][:material], projid: params[:order][:projid])
      ProvidedMaterial.find_by(name: params[:order][:provider], material: params[:order][:material]).deduct_qty(params[:order][:qty].to_f)
    end
  end

  def edit
  end

  def update
  end

  def destroy
    ordr = Order.find_by(id: params[:id])
    ProvidedMaterial.find_by(name: ordr.provider, material: ordr.material).add_qty(ordr.qty.to_f) unless params[:comp]
    ordr.destroy
  end
end
